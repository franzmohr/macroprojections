# Österreichisches Institut für Wirtschaftsforschung (WIFO)

LEI: 5299004QA39L2ORLX198

## Directory content

* `prep.R`: The script used to produce the `forecasts.csv` file from the files stored in folder `raw`. Further documentation can be found there.
* `raw`: Folder containing raw files, which are combined using script `prep.R`. See below for details on the update.
* `forecasts.csv`: Standardised file for the institution's entire sample of projections.
* `sources.csv`: Page, table and row of every value collected using AI, with the definition used. These vintages are also listed in `scripts/support-data/ai_collected.csv`.

## Workflow

* Go to the website, where the WIFO publishes its forecasts: [https://www.wifo.ac.at/en/publications/wifo-konjunkturprognose/](https://www.wifo.ac.at/en/publications/wifo-konjunkturprognose/)
* Copy one of the csv-files and store it as "YYYYMMDD_forecasts.csv", where "YYYYMMDD" corresponds to the date of the forecast's publication.
* Update the new csv-file according to the new forecast.
* Run the script `prep.R` to generate an update of the `forecast.csv` file.

## Source

[WIFO-Konjunkturprognose](https://www.wifo.ac.at/en/publications/wifo-konjunkturprognose/)
