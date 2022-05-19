# Data on macroeconomic projections

Download the complete data set

* [CSV](forecasts.csv)
* [XLSX](forecasts.xlsx)

## Purpose

Economic projections are an indispensable source of information for public institutions such as ministries, central banks and supervisory authorities. However, forecast providers usually publish forecasts only on their own websites and not all publish them in a machine-readable format. The purpose of this repository of macroeconomic forecasts is to address those caveats by providing a platform, where macroeconomic projections are collected and can be downloaded in a machine-readable format. By that, this project intends to contribute to a more intensive use of economic forecasts by policy makers and to foster research on the forecasting power of different approaches.

## Content

* `year`: Reference year of the forecast.
* `ctry`: ID of the country. The ID follows the IMF, which also has IDs for regions. This is not possible with traditional ISO 3166-1 alpha-2 or alpha-3 codes.
* `pubdate`: Date of the publication of the forecast in the format `YYYY-MM-DD`.
* `variable`: Varible code of the variable based on the conventions used in the IMF's World Economic Outlook database.
* `institution`: LEI of the forecast provider.
* `value`: Value of the forecast.

## Coverage

* Only forecasts of non-commercial institutions are included in the data set. Therefore, all the information in the data set is publicly available at the time of collection of the data. This is ensured by requiring a working link to the original source of the forecast.
* Only forecasts of institutions that have a valid legal entity identifier (LEI) are included in the data set. The LEI is used as the main identifier of forecast providers.
* Currently, only annual forecasts are considered.
* The goal of this repository is global coverage, which is automatically achieved by including the IMF's forecasts for the World Economic Outlook. However, forecasts by local institutions should also be gradually included to complement the IMF's data.
* The coverage of the data is documented in the meta file.

## Disclaimer

The data provided in this project is collected on a best-effort basis and absolutely no warranty is given on the accuracy and timeliness of the information.

## Contribute

See XYZ




