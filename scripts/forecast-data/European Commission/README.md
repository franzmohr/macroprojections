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

## Releases before November 2021 and after November 2024

The visualisation tool only covers recent releases. The earlier releases (spring 2008 to spring 2021, including the winter forecasts of 2013–2017 and the interim forecasts of 2008–2012 and 2018–2021) and the releases of spring 2025 to spring 2026 were read from the statistical annex of each forecast document (the "European Economic Forecast" institutional papers and their predecessors): GDP from the table "Gross domestic product, volume", inflation from the HICP table and the unemployment rate from the table "Unemployment rate", forecast years only. Interim forecasts cover GDP and inflation only, and until 2012 mostly only the largest member states. The files follow the same format as the downloads from the visualisation tool. Where a release prints both EU27 and EU28 (2017–2019), the EU28 row is the one recorded as "EU".

`prep.R` maps the aggregates by their label, including labels that carry the composition such as "EA 20" or "EU 27".

## Source

[Economic forecasts of the European Comission](https://ec.europa.eu/info/business-economy-euro/economic-performance-and-forecasts/economic-forecasts_en)
