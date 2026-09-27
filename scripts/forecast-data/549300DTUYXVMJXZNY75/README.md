# European Central Bank

LEI: 549300DTUYXVMJXZNY75

## Directory content

* `prep.R`: The script used to produce the `forecasts.csv` file. Further documentation can be found there.
* `imf_ecb.csv`: A table that allows to map ECB country abbreviations with the IMF's country and region codes.
* `forecasts.csv`: Standardised file for the institution's entire sample of projections.

## Workflow

Since the ECB provides its data in a machine-readable format, it can be downloaded directly from its website and, thus, the workflow only consists in running the script `prep.R`. However, file `imf_ecb.csv` might require infrequent maintenance in case the country codes change or countries become part of the monetary union.

## Variables

Only projection items with an equivalent IMF WEO variable are kept: real GDP (YER → NGDP_RPCH), the HICP (HIC → PCPIPCH) and the unemployment rate (URX → LUR) for the euro area and its members, and for the euro area also exports and imports of goods and services, volume (XTR → TX_RPCH, MTR → TM_RPCH), the current account balance (CAN → BCA_NGDPD), the general government budget balance (SED → GGXCNL_NGDP) and gross debt (MAL → GGXWDG_NGDP), all % of GDP. The ECB publishes the last five for the euro area only.

The ECB data portal rejects queries with every dimension left open; the explicit key in `prep.R` works.

## Source

[ECB Statistical Data Warehouse](https://sdw.ecb.europa.eu/browse.do?node=5275746)
