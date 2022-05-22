# European Commission

LEI: 254900ZNYA1FLUQ9U393

## Directory content

* `prep.R`: The script used to produce the `forecasts.csv` file from the files stored in folder `raw`. Further documentation can be found there.
* `raw`: Folder containing raw files, which are combined using script `prep.R`. See below for details on the update.
* `forecasts.csv`: Standardised file for the institution's entire sample of projections.

## Workflow

* Go to the website, where the European Commission publishes its forecasts: [https://ec.europa.eu/info/business-economy-euro/economic-performance-and-forecasts/economic-forecasts_en](https://ec.europa.eu/info/business-economy-euro/economic-performance-and-forecasts/economic-forecasts_en)
* Select "GDP" in the visualisation tool and click on "CSV" to download the data as "YYYYMMDD_NGDP_RPCH.csv", where "YYYYMMDD" corresponds to the date of the publication. "NGDP_RPCH" is the IMF's code for real GDP growth projections.
* Select "Inflation" in the visualisation tool and click on "CSV" to download the data as "YYYYMMDD_PCPIPCH.csv", where "YYYYMMDD" corresponds to the date of the publication. "PCPIPCH" is the IMF's code for inflation projections.
* Select "Unemployment rate" in the visualisation tool and click on "CSV" to download the data as "YYYYMMDD_LUR.csv", where "YYYYMMDD" corresponds to the date of the publication. "LUR" is the IMF's code for unemployment rate projections, which is required to read the file.
* Run the script `prep.R` to generate an update of the `forecast.csv` file.

## Source

[Economic forecasts of the European Comission](https://ec.europa.eu/info/business-economy-euro/economic-performance-and-forecasts/economic-forecasts_en)
