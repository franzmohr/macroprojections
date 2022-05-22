# European Central Bank

LEI: 549300DTUYXVMJXZNY75

## Directory content

* `prep.R`: The script used to produce the `forecasts.csv` file. Further documentation can be found there.
* `imf_ecb.csv`: A table that allows to map ECB country abbreviations with the IMF's country and region codes.
* `forecasts.csv`: Standardised file for the institution's entire sample of projections.

## Workflow

Since the ECB provides its data in a machine-readable format, it can be downloaded directly from its website and, thus, the workflow only consists in running the script `prep.R`. However, file `imf_ecb.csv` might require infrequent maintenance in case the country codes change or countries become part of the monetary union.

## Source

[ECB Statistical Data Warehouse](https://sdw.ecb.europa.eu/browse.do?node=5275746)
