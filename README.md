# CMDRs Toolbox

CMDRs Toolbox is a collection of Elite Dangerous resources that I have gathered, generated, or converted for quick reference. The repository contains calculators, data tables, and supporting imagery that can be opened locally without any build step.

This fork builds on the excellent groundwork from [Down To Earth Astronomy's original CMDR's Toolbox](https://github.com/DownToEarthAstronomy/CMDRs-Toolbox). Their curation and tooling laid the foundation for many of the resources collected here.

## Repository layout

```
├── assets/                 # Shared imagery and visual assets
├── docs/                   # Written reference material and data tables
├── tools/                  # HTML utilities, data exports, and helper scripts
├── LICENSE                 # Project license (MIT)
└── logo_alpha_black.png    # Project branding asset
```

### Tools (`tools/`)

| Directory | Description |
| --- | --- |
| `billionaires-boulevard/` | Trade route helper with the latest "Billionaire's Boulevard" data export and HTML view. |
| `carrier-fuel-finder/` | Fuel planning tables and conversion scripts for fleet carriers. |
| `crystal-shards/` | CSV exports and PowerShell scripts for tracking crystal shard sites. |
| `fleet-carrier-calculator/` | Stand-alone calculator for carrier upkeep and jump costs. |
| `material-finder/` | Engineering material locations compiled into an offline HTML table. |
| `multi-stop-route-planner/` | HTML planner for creating multi-stop trade or travel routes. |
| `odyssey-material-locations/` | Odyssey material location workbook, generated HTML tables, and helper scripts. |
| `read-file-demo/` | Small experiment that tests reading JSON into an HTML table. |

Each tool is self-contained; open the `.html` files in a browser or run the PowerShell scripts on Windows to regenerate data tables.

### Documentation (`docs/`)

* `guardian/` — Reference pages summarising Guardian beacons, modules, and terminal site information.
* `guides/` — Visual guides including the Imperial rank grind, exploration interface notes, and shield engineering diagrams.

### Shared assets (`assets/`)

* `backgrounds/` — Backdrops and wallpaper imagery used across several tools.
* `community-logos/` — Logos for Elite Dangerous community groups.
* `icons/` — Small icons used by site navigation mock-ups.
* `mining/` and `mining-maps/` — Mining overlays, screenshots, and point-of-interest maps.
* `subjects/` — Subject tiles covering common gameplay themes.

## Contributing

This project is primarily a personal knowledge base, but improvements and corrections are welcome. If you add a new resource, keep the directory names kebab-cased and document it in this README so visitors can quickly find it.

