# Organisation for Economic Co-operation and Development

LEI: 969500Y2NFIMDP5MO798

## Directory content

* `prep.R`: The script used to produce the `forecasts.csv` file from the files stored in folder `raw`.
* `raw`: One file per Economic Outlook edition (or interim release) and variable, `YYYYMMDD_<VARIABLE>.csv`, with a column `Category` of country names as in `scripts/support-data/geo_list.csv` and one column per projection year.
* `exclusions.csv`: Values that do not measure what their IMF code stands for, which `prep.R` drops, with the reason.
* `sources.csv`: The annex table, StatLink or URL of every file, and the source of every publication date.
* `coverage.md`: Editions covered, source types, country-name mapping, definitions and open points.
* `forecasts.csv`: Standardised file for the institution's entire sample of projections.

## Content

The full OECD Economic Outlooks (June and November/December) from EO83 (June 2008) onwards, read from the statistical annex tables: real GDP (NGDP_RPCH), consumer prices (PCPIPCH; the harmonised index for euro-area countries, the euro area and the United Kingdom, the national CPI otherwise) and the unemployment rate (LUR, national definitions, % of labour force). Where an edition's annex could not be downloaded (EO106, EO109, EO112–EO114), the values come from the OECD's database for that edition, checked against the annexes of the other editions. The interim Economic Outlooks add GDP, and from September 2021 inflation, for the G20; their US inflation figure is the private consumption deflator and is excluded (see `exclusions.csv`).

Only variables with an IMF WEO code are kept. The Economic Outlook's forecasts of private consumption, which have no WEO code, are not part of this repository.

## Workflow

* After a new Economic Outlook, download the annex tables (StatLinks) for real GDP, consumer prices and the unemployment rate, and save each as `raw/YYYYMMDD_<VARIABLE>.csv` in the format above, with the OECD's country names mapped to those of `geo_list.csv` (see `coverage.md`).
* Run the script `prep.R` to generate an update of the `forecasts.csv` file.

## Source

[OECD Economic Outlook](https://www.oecd.org/economic-outlook/)
