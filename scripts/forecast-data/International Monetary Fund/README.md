# International Monetary Fund

LEI: E7EXN6FJGRUTJYNZ3Z71

## Directory content

* `prep.R`: The script used to produce the `forecasts.csv` file from the files in `raw` and `article-iv`.
* `raw`: The World Economic Outlook database, one file per vintage. Up to April 2025 as the IMF's SDMX XML file (`YYYYMMDD_weo.xml`). From October 2025 the WEO is published only in the IMF's new data portal format, with ISO3 country codes; those vintages are stored converted to the columns `prep.R` produces (`YYYYMMDD_weo.csv`). `raw/README.md` documents the conversion and its checks, and `convert_new_format.R` is the conversion script.
* `article-iv`: Projections for Austria from the IMF's Article IV staff reports (the staff report's indicator table), one file per report, dated by its publication date, with `sources.csv` (page and table of every value) and `coverage.md`. `prep.R` takes the variables with an IMF WEO code (NGDP_RPCH, PCPIPCH, LUR).
* `forecasts.csv`: Standardised file for the institution's entire sample of projections.

## Workflow

* Download each new WEO vintage from the IMF (the WEO database page or data.imf.org). Save an XML vintage as `raw/YYYYMMDD_weo.xml`; convert a vintage in the new format with `convert_new_format.R`.
* After an Article IV consultation with Austria, add the staff report's projections as `article-iv/raw/YYYYMMDD_forecasts.csv` and document them in `article-iv/sources.csv`.
* Run the script `prep.R` to generate an update of the `forecasts.csv` file.

## Source

[IMF World Economic Outlook databases](https://www.imf.org/en/Publications/WEO/weo-database), [IMF country page for Austria](https://www.imf.org/en/Countries/AUT)
