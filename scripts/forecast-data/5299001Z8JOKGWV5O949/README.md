# Oesterreichische Nationalbank

LEI: 5299001Z8JOKGWV5O949

## Directory content

* `prep.R`: The script used to produce the `forecasts.csv` file from the files stored in folder `raw`. Further documentation can be found there.
* `raw`: Folder containing raw files, which are combined using script `prep.R`. See below for details on the update.
* `forecasts.csv`: Standardised file for the institution's entire sample of projections.

## Workflow

* Go to the website, where the Oesterreichische Nationalbank publishes its forecasts: [https://www.oenb.at/Geldpolitik/Konjunktur/gesamtwirtschaftliche-prognose.html](https://www.oenb.at/Geldpolitik/Konjunktur/gesamtwirtschaftliche-prognose.html)
* Copy one of the csv-files and store it as "YYYYMMDD_forecasts.csv", where "YYYYMMDD" corresponds to the date of the forecast's publication.
* Update the new csv-file according to the new forecast.
* Run the script `prep.R` to generate an update of the `forecast.csv` file.

## Source

[Gesamtwirtschaftliche Prognose by the Oesterreichische Nationalbank (in German)](https://www.oenb.at/Geldpolitik/Konjunktur/gesamtwirtschaftliche-prognose.html)
