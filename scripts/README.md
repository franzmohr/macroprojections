# Development

Here you will find all the different scripts and tools that we use to generate the complete data set.

## Directory overview

|Folder|Description                  |
|------|-----------------------------|
|[`forecast-data/`](forecast-data) | Institution-specific forecasts per forecast provider. |
|[`support-data/`](support-data)   | Additional files and scripts, which are useful during update processes accross individual forecast suppliers. |

## Data pipeline

* Raw data is stored in the folder of the respective forecast publisher.
* The script `prep` is executed to update the csv file in the folder of the respective forecast provider.
* Script `combine_forecasts` is executed to combine all institution-specific forecasts useing only the forecasts.csv files of the institution-specific folders.

## Contribute

We welcome contributions for all of our processes. This includes:

* Adding raw files with new forecasts. Especially forecast providers are invited to upload their own projections.
* Refining existing code to automate processes.
* Make general suggestions.

