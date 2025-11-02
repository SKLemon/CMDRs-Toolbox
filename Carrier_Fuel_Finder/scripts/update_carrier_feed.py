#!/usr/bin/env python3
"""Generate the carrier fuel finder JSON feed from the community CSV snapshot.

The script consumes ``Trit_Overlaps.csv`` (or a compatible CSV export) and
produces two artefacts:

* ``data/fuel_carriers.json`` – the feed consumed by the UI.
* ``data/fuel_carriers.snapshot.js`` – a browser fallback used when the live
  request fails.

Coordinates are fetched from the EDSM API so the tool stays in sync with the
latest discoveries.  Basic throttling is included so the script can be run as a
cron job without overwhelming the API.
"""
from __future__ import annotations

import argparse
import csv
import json
import sys
import time
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Iterable, List, Optional

import requests

EDSM_SYSTEM_URL = "https://www.edsm.net/api-v1/system"


@dataclass
class CarrierRecord:
    system: str
    body: str
    last_seen: Optional[str]
    reported_by: Optional[str]
    x: float
    y: float
    z: float
    pad_size: str = "Large"
    services: Optional[List[str]] = None

    def to_dict(self) -> dict:
        return {
            "system": self.system,
            "body": self.body,
            "lastSeen": self.last_seen,
            "reportedBy": self.reported_by,
            "padSize": self.pad_size,
            "services": self.services or ["Tritium Resupply"],
            "coordinates": {"x": self.x, "y": self.y, "z": self.z},
        }


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--csv",
        default=Path(__file__).resolve().parents[1] / "Trit_Overlaps.csv",
        type=Path,
        help="CSV feed containing community submitted carrier overlaps.",
    )
    parser.add_argument(
        "--output-json",
        default=Path(__file__).resolve().parents[1] / "data" / "fuel_carriers.json",
        type=Path,
        help="Destination JSON feed path.",
    )
    parser.add_argument(
        "--output-snapshot",
        default=Path(__file__).resolve().parents[1] / "data" / "fuel_carriers.snapshot.js",
        type=Path,
        help="Destination snapshot JS path.",
    )
    parser.add_argument(
        "--version",
        required=True,
        help="Semantic/date version string baked into the feed for cache busting.",
    )
    parser.add_argument(
        "--pause",
        default=0.35,
        type=float,
        help="Delay between API calls to respect EDSM rate limits.",
    )
    parser.add_argument(
        "--timeout",
        default=10,
        type=float,
        help="HTTP timeout when calling the EDSM API.",
    )
    return parser.parse_args()


def iter_csv_rows(csv_path: Path) -> Iterable[dict]:
    with csv_path.open(newline="", encoding="utf-8") as handle:
        reader = csv.DictReader(handle)
        for row in reader:
            yield row


def normalise_timestamp(raw: str) -> Optional[str]:
    raw = raw.strip()
    if not raw:
        return None
    for fmt in ("%m/%d/%Y %H:%M:%S", "%Y-%m-%dT%H:%M:%S"):
        try:
            dt = datetime.strptime(raw, fmt)
            return dt.replace(tzinfo=timezone.utc).isoformat()
        except ValueError:
            continue
    return raw


def fetch_coordinates(system: str, timeout: float) -> Optional[dict]:
    response = requests.get(
        EDSM_SYSTEM_URL,
        params={"systemName": system, "showCoordinates": 1},
        timeout=timeout,
    )
    response.raise_for_status()
    data = response.json()
    coords = data.get("coords")
    if not coords:
        return None
    return {"x": float(coords["x"]), "y": float(coords["y"]), "z": float(coords["z"])}


def build_records(rows: Iterable[dict], timeout: float, pause: float) -> List[CarrierRecord]:
    records: List[CarrierRecord] = []
    for row in rows:
        system = row.get("System Name", "").strip()
        if not system:
            continue
        coords = fetch_coordinates(system, timeout)
        if not coords:
            print(f"⚠️  Missing coordinates for {system}", file=sys.stderr)
            continue
        record = CarrierRecord(
            system=system,
            body=row.get("Planet", "").strip(),
            last_seen=normalise_timestamp(row.get("Submitted On", "")),
            reported_by=(row.get("CMDR Name", "") or None),
            x=coords["x"],
            y=coords["y"],
            z=coords["z"],
        )
        records.append(record)
        time.sleep(max(pause, 0))
    return records


def write_outputs(records: List[CarrierRecord], json_path: Path, snapshot_path: Path, version: str) -> None:
    json_payload = {
        "version": version,
        "generated": datetime.now(timezone.utc).isoformat(),
        "data": [record.to_dict() for record in records],
    }
    json_path.parent.mkdir(parents=True, exist_ok=True)
    snapshot_path.parent.mkdir(parents=True, exist_ok=True)

    json_path.write_text(json.dumps(json_payload, indent=2), encoding="utf-8")
    snapshot_path.write_text(
        "window.__CARRIER_FUEL_SNAPSHOT__ = " + json.dumps(json_payload) + ";\n",
        encoding="utf-8",
    )


def main() -> int:
    args = parse_args()
    rows = list(iter_csv_rows(args.csv))
    records = build_records(rows, timeout=args.timeout, pause=args.pause)
    if not records:
        print("No carrier entries were generated; aborting.", file=sys.stderr)
        return 1
    write_outputs(records, args.output_json, args.output_snapshot, args.version)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
