# Carrier Fuel Finder data feed

The web UI now loads its fuel carrier catalogue from
[`data/fuel_carriers.json`](data/fuel_carriers.json). The inline version string
(`DATA_FEED_VERSION`) is appended to the request as `?v=<version>` so browsers
fetch fresh data whenever the feed changes. A matching snapshot is embedded via
[`data/fuel_carriers.snapshot.js`](data/fuel_carriers.snapshot.js) and is used as
a fallback whenever the live request fails.

## Updating the dataset

1. Pull the latest CSV export from the community spreadsheet or Spansh and
   store it as `Trit_Overlaps.csv` (the default expected by the tooling).
2. Run the update script to regenerate the feed and snapshot (requires
   [`requests`](https://pypi.org/project/requests/)):

   ```bash
   cd Carrier_Fuel_Finder
   python scripts/update_carrier_feed.py --version YYYY-MM-DD
   ```

   The script resolves carrier coordinates via the EDSM API, so give it a few
   seconds to respect rate limits. Successful execution updates both
   `data/fuel_carriers.json` and `data/fuel_carriers.snapshot.js`.
3. Review the diff, increment the `DATA_FEED_VERSION` constant inside
   `Carrier_Fuel_Finder.html` to match the version you passed to the script, and
   commit the changes.

## Automating updates

The generator is lightweight enough to be scheduled. A simple cron entry keeps
things aligned with new community submissions:

```
# m h dom mon dow command
0 6 * * * cd /path/to/CMDRs-Toolbox/Carrier_Fuel_Finder \
  && /usr/bin/python3 scripts/update_carrier_feed.py --version $(date +\%Y-\%m-\%d) \
  && git add data/fuel_carriers.* \
  && git commit -m "Update carrier fuel dataset" || true
```

The cron job bakes the current date into the feed (ensuring cache busting) and
falls back to a no-op commit if there are no data changes.
