# Congressional Budget Office

## Directory content

* `prep.R`: The script used to produce the `forecasts.csv` file. It downloads the Excel file of every vintage listed in `vintages.csv` to a temporary file, reads the calendar-year sheet and keeps the projection years. The Excel files are not stored in this repository.
* `vintages.csv`: One row per vintage: the publication date (`pubdate`), the Excel file on cbo.gov (`file_url`), the report it supplements (`report`, `report_url`), the source of the publication date (`date_source`) and an Internet Archive copy of the Excel file (`archive_url`). cbo.gov answers scripted downloads with HTTP 403 (bot protection), so `prep.R` tries `file_url` first and falls back to `archive_url`.
* `coverage.md`: Vintages covered, definitions, how actual and projected years are told apart, verification and open points.
* `forecasts.csv`: Standardised file for the institution's entire sample of projections.

## Content

CBO's 10-year economic projections from January 2000 onwards (The Budget and Economic Outlook, its updates and CBO's Current View of the Economy), read from the "Calendar Year" sheet of CBO's "10-Year Economic Projections" files: real GDP (NGDP_RPCH, annual-average % change), the consumer price index for all urban consumers (PCPIPCH, CPI-U, annual-average % change) and the civilian unemployment rate (LUR, calendar-year average, %), for the United States (IMF code 111). Only the years the file shades as forecast are kept. Values are rounded to one decimal, as in CBO's report tables.

## Workflow

* After CBO publishes a new vintage, add a row to `vintages.csv`: the report's publication date (from its page on cbo.gov/publication), the URL of the Excel file listed under "10-Year Economic Projections" on [Budget and Economic Data](https://www.cbo.gov/data/budget-economic-data), the report's title and URL, the source of the date and, if available, an Internet Archive copy of the file (`https://web.archive.org/web/<timestamp>id_/<file_url>`; save the file with the Wayback Machine if no copy exists).
* Run the script `prep.R` to generate an update of the `forecasts.csv` file. It stops with an error naming the vintage if a file cannot be downloaded or parsed.

## Source

[CBO, Budget and Economic Data: 10-Year Economic Projections](https://www.cbo.gov/data/budget-economic-data)
