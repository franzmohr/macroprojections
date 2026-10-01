# CBO 10-year economic projections January 2000 – February 2026: coverage

Variables: `NGDP_RPCH` real GDP, `PCPIPCH` CPI-U, `LUR` civilian unemployment rate. Country: United States (`ctry` 111).
Input: `vintages.csv` (52 vintages). Output: `forecasts.csv` (1,745 values).

## Summary

* **52 vintages, from The Budget and Economic Outlook of January 2000 to that of February 2026**, with all three variables in every vintage.
  CBO lists 53 files under "10-Year Economic Projections". The December 2023 file is left out (see below).
* Source: CBO's "10-Year Economic Projections" Excel files ([Budget and Economic Data](https://www.cbo.gov/data/budget-economic-data)), sheet
  "2. Calendar Year". `prep.R` takes the one sheet whose name contains "calendar year". The files are downloaded at run time and not stored
  here. CBO republished the files for January 2000 to January 2011 in February 2025 (folder `system/files/2025-02/`), in the layout of the
  later files.
* Only projection years are kept: the cells CBO shades as forecast values. Every file says so in its notes
  ("Actual values reflect data released as of …. Forecast values are shaded."; June 2017: "Projected values are shaded").
* Values are rounded to one decimal (half away from zero) from the full-precision Excel values. CBO prints its tables the same way.

## Definitions

| Code | Row in the calendar-year sheet | Measure |
|---|---|---|
| NGDP_RPCH | "Real GDP", then the row "Percentage change" (from 2018: "Percentage change, annual rate") below it | change in the calendar-year average of real GDP, % |
| PCPIPCH | "Consumer Price Index, All Urban Consumers (CPI-U)", then the row "Percentage change" below it | change in the calendar-year average of the CPI-U, % (not the chained CPI-U, not the core index) |
| LUR | "Unemployment Rate, Civilian, 16 Years or Older" | calendar-year average, % of the civilian labour force |

Rows are found by these labels, not by cell position. Matching ignores case and footnote markers. The label is in column A (files from
April 2018 on) or column B (older layout), and the units are in the next or the fourth column. The year header is the first row with five or
more years. Fiscal-year and fourth-quarter-to-fourth-quarter figures are not used.

## Actual versus projected years

`prep.R` reads the cell formats of the three rows: a cell with a solid fill is a forecast value. For the .xlsx files it reads the fill from
`styles.xml` and the sheet XML. For the one .xls file (February 2013) it reads the BIFF8 XF and cell records, using a minimal reader that is
part of `prep.R`. The script stops in three cases: a row has no shaded cell, the shaded cells are not the final years of the row, or the first
shaded year is neither the publication year nor the year before.

| Vintages | Data cut-off (notes of the file) | First projection year |
|---|---|---|
| January/February vintages (Budget and Economic Outlook) | early December to mid-January | the year before publication. Its fourth-quarter data were not yet published, so its annual average is partly a forecast |
| March to September vintages (updates, Current View) | February to early September | the publication year |
| February 2013 (.xls) | January 11, 2013 | 2012 for real GDP and the CPI-U, **2013 for the unemployment rate**: the 2012 unemployment rate is not shaded, so it is actual |

February 2013 is the only vintage where the shading differs between the three variables. In every other vintage all three rows are shaded
from the same year on. The first projection year was checked against the PDF tables, whose columns are headed "Actual", "Estimated" or
"Forecast" (see below). For the five vintages in CBO's GitHub repository it was also checked against that repository's `estimate_type`
column ("actual"/"projected"), and all five agree.

Two updates have short horizons: the July 2023 update (An Update to the Economic Outlook: 2023 to 2025) projects only to 2025, and the
September 2025 Current View only to 2028. All other vintages project 10 or 11 years beyond the publication year.

## Vintages

| Pubdate | Report | Projection years | Values | Source of the date |
|---|---|---|---|---|
| 2000-01-26 | The Budget and Economic Outlook: Fiscal Years 2001-2010 | 1999-2010 | 36 | other (see vintages.csv) |
| 2000-07-18 | The Budget and Economic Outlook: An Update | 2000-2010 | 33 | other (see vintages.csv) |
| 2001-01-31 | The Budget and Economic Outlook: Fiscal Years 2002-2011 | 2000-2011 | 36 | other (see vintages.csv) |
| 2001-08-28 | The Budget and Economic Outlook: An Update | 2001-2011 | 33 | other (see vintages.csv) |
| 2002-01-23 | The Budget and Economic Outlook: Fiscal Years 2003-2012 | 2001-2012 | 36 | other (see vintages.csv) |
| 2002-08-27 | The Budget and Economic Outlook: An Update | 2002-2012 | 33 | publication page |
| 2003-01-29 | The Budget and Economic Outlook: Fiscal Years 2004-2013 | 2002-2013 | 36 | other (see vintages.csv) |
| 2003-08-26 | The Budget and Economic Outlook: An Update | 2003-2013 | 33 | other (see vintages.csv) |
| 2004-01-26 | The Budget and Economic Outlook: Fiscal Years 2005 to 2014 | 2003-2014 | 36 | other (see vintages.csv) |
| 2004-09-07 | The Budget and Economic Outlook: An Update | 2004-2014 | 33 | other (see vintages.csv) |
| 2005-01-25 | The Budget and Economic Outlook: Fiscal Years 2006 to 2015 | 2004-2015 | 36 | publication page |
| 2005-08-15 | The Budget and Economic Outlook: An Update | 2005-2015 | 33 | publication page |
| 2006-01-26 | The Budget and Economic Outlook: Fiscal Years 2007 to 2016 | 2005-2016 | 36 | other (see vintages.csv) |
| 2006-08-17 | The Budget and Economic Outlook: An Update | 2006-2016 | 33 | other (see vintages.csv) |
| 2007-01-24 | The Budget and Economic Outlook: Fiscal Years 2008 to 2017 | 2006-2017 | 36 | publication page |
| 2007-08-23 | The Budget and Economic Outlook: An Update | 2007-2017 | 33 | publication page |
| 2008-01-23 | The Budget and Economic Outlook: Fiscal Years 2008 to 2018 | 2007-2018 | 36 | publication page |
| 2008-09-09 | The Budget and Economic Outlook: An Update | 2008-2018 | 33 | publication page |
| 2009-01-07 | The Budget and Economic Outlook: Fiscal Years 2009 to 2019 | 2008-2019 | 36 | publication page |
| 2009-03-20 | A Preliminary Analysis of the President's Budget and an Update of CBO's Budget and Economic Outlook | 2009-2019 | 33 | publication page |
| 2009-08-25 | The Budget and Economic Outlook: An Update | 2009-2019 | 33 | publication page |
| 2010-01-26 | The Budget and Economic Outlook: Fiscal Years 2010 to 2020 | 2009-2020 | 36 | publication page |
| 2010-08-18 | The Budget and Economic Outlook: An Update | 2010-2020 | 33 | publication page |
| 2011-01-26 | Budget and Economic Outlook: Fiscal Years 2011 to 2021 | 2010-2021 | 36 | publication page |
| 2011-08-24 | Budget and Economic Outlook: An Update | 2011-2021 | 33 | publication page |
| 2012-01-31 | The Budget and Economic Outlook: Fiscal Years 2012 to 2022 | 2011-2022 | 36 | publication page |
| 2012-08-22 | An Update to the Budget and Economic Outlook: Fiscal Years 2012 to 2022 | 2012-2022 | 33 | publication page |
| 2013-02-05 | The Budget and Economic Outlook: Fiscal Years 2013 to 2023 | GDP, CPI 2012-2023; LUR 2013-2023 | 35 | publication page |
| 2014-02-04 | The Budget and Economic Outlook: 2014 to 2024 | 2013-2024 | 36 | other (see vintages.csv) |
| 2014-08-27 | An Update to the Budget and Economic Outlook: 2014 to 2024 | 2014-2024 | 33 | publication page |
| 2015-01-26 | The Budget and Economic Outlook: 2015 to 2025 | 2014-2025 | 36 | publication page |
| 2015-08-25 | An Update to the Budget and Economic Outlook: 2015 to 2025 | 2015-2025 | 33 | publication page |
| 2016-01-25 | The Budget and Economic Outlook: 2016 to 2026 | 2015-2026 | 36 | publication page |
| 2016-08-23 | An Update to the Budget and Economic Outlook: 2016 to 2026 | 2016-2026 | 33 | publication page |
| 2017-01-24 | The Budget and Economic Outlook: 2017 to 2027 | 2016-2027 | 36 | publication page |
| 2017-06-29 | An Update to the Budget and Economic Outlook: 2017 to 2027 | 2017-2027 | 33 | publication page |
| 2018-04-09 | The Budget and Economic Outlook: 2018 to 2028 | 2018-2028 | 33 | publication page |
| 2018-08-13 | An Update to the Economic Outlook: 2018 to 2028 | 2018-2028 | 33 | publication page |
| 2019-01-28 | The Budget and Economic Outlook: 2019 to 2029 | 2018-2029 | 36 | publication page |
| 2019-08-21 | An Update to the Budget and Economic Outlook: 2019 to 2029 | 2019-2029 | 33 | publication page |
| 2020-01-28 | The Budget and Economic Outlook: 2020 to 2030 | 2019-2030 | 36 | publication page |
| 2020-07-02 | An Update to the Economic Outlook: 2020 to 2030 | 2020-2030 | 33 | publication page |
| 2021-02-01 | An Overview of the Economic Outlook: 2021 to 2031 | 2020-2031 | 36 | publication page |
| 2021-07-01 | An Update to the Budget and Economic Outlook: 2021 to 2031 | 2021-2031 | 33 | publication page |
| 2022-05-25 | The Budget and Economic Outlook: 2022 to 2032 | 2022-2032 | 33 | publication page |
| 2023-02-15 | The Budget and Economic Outlook: 2023 to 2033 | 2022-2033 | 36 | publication page |
| 2023-07-26 | An Update to the Economic Outlook: 2023 to 2025 | 2023-2025 | 9 | publication page |
| 2024-02-07 | The Budget and Economic Outlook: 2024 to 2034 | 2023-2034 | 36 | publication page |
| 2024-06-18 | An Update to the Budget and Economic Outlook: 2024 to 2034 | 2024-2034 | 33 | publication page |
| 2025-01-17 | The Budget and Economic Outlook: 2025 to 2035 | 2024-2035 | 36 | publication page |
| 2025-09-12 | CBO's Current View of the Economy From 2025 to 2028 | 2025-2028 | 12 | publication page |
| 2026-02-11 | The Budget and Economic Outlook: 2026 to 2036 | 2025-2036 | 36 | publication page |

The report titles are those of the publication pages. The notes of two files name the report slightly differently. February 2021:
"An Overview of the Budget and Economic Outlook: 2021 to 2031" (page: An Overview of the Economic Outlook: 2021 to 2031). August 2019:
"An Update to the Economic Outlook: 2019 to 2029" (page: An Update to the Budget and Economic Outlook: 2019 to 2029).

### Publication dates

The pubdate is the publication date of the report the file supplements. The file itself only names the month.

* August 2019 to February 2026, except February 2021: the date on the report's publication page on cbo.gov, read in the browser.
* August 2002 and January 2005 to February 2021, except January 2006, August 2006 and February 2014: the date on the publication page in an
  Internet Archive copy, because cbo.gov blocks scripted access. `vintages.csv` names the capture.
* January 2000 to January 2004 (except August 2002), September 2004 and August 2006: the publication page shows the first of the month, which
  is a placeholder. For January 2006 and February 2014 the publication page is not archived. For these vintages the day comes from CBO's own
  pages in the Internet Archive where possible:
  * January 2000: errata note in the HTML edition, "electronically released January 26, 2000".
  * September 2004, January 2006 and August 2006: release announcements on the cbo.gov home page.
  * February 2014: the cbo.gov home page listing.

  Otherwise the day comes from contemporaneous reports: CBPP (July 2000, January 2004), PBS NewsHour (January 2001, August 2003), CBS News
  (August 2001), Brookings (January 2002) and CNN Money (January 2003). `vintages.csv` quotes each source.

## Left out

* **December 2023** (CBO's Current View of the Economy From 2023 to 2025, 51135-2023-12-Economic-Projections.xlsx): the file has a single
  table with quarterly figures, fourth-quarter-to-fourth-quarter figures and the fourth-quarter unemployment rate. It has no calendar-year
  averages, so it is not in `vintages.csv`.
* CBO reports without a 10-year economic projections file are not covered. Examples: the budget-only updates of May 2019, March 2020,
  September 2020 and May 2023, the interim projections of May 2020, and the Current Views of November 2022, December 2024 and January 2026.

## Verification

1. **CBO's GitHub repository** (`US-CBO/cbo-data`, `data/economic/economic_projections/calendar_<vintage>.csv`, variables
   `real_gdp_pct_change`, `cpiu_pct_change`, `unemployment_rate`): for 2024-02, 2024-06, 2025-01, 2025-09 and 2026-02, the values rounded to
   one decimal equal those in `forecasts.csv` for every year and variable (36, 33, 36, 12 and 36 values). The years marked "projected" there
   are exactly the years kept here.
2. **Report PDFs** (tables read from rendered page images):
   * August 2001, Table B-1 "CBO's Year-by-Year Economic Forecasts and Projections for Calendar Years 2001 Through 2011": all 33 values are
     equal. 2001 and 2002 are headed "Forecast".
   * January 2008, Table E-1 "CBO's Year-by-Year Forecast and Projections for Calendar Years 2008 to 2018": all 36 values are equal. 2007 is
     headed "Estimated".
   * February 2013, Table 2-1 "CBO's Economic Projections for Calendar Years 2012 to 2023" (2012, 2013, 2014 and the averages 2015–2018 and
     2019–2023): all values and averages are equal. The table marks the 2012 CPI-U (2.1) and the 2012 unemployment rate (8.1) as "Actual value
     for 2012". The Excel file shades the 2012 CPI-U as a forecast and leaves the 2012 unemployment rate unshaded. `forecasts.csv` follows the
     file, so it keeps the 2012 CPI-U and drops the 2012 unemployment rate.
   * April 2018, Table 1-1 "CBO's Economic Projections for Calendar Years 2018 to 2028" (2018–2020 and the averages 2021–2022 and 2023–2028):
     all values and averages are equal. 2017 is headed "Actual" and is not in `forecasts.csv`.
3. Every vintage yields all three variables over the same years, except February 2013 (see above). The Budget and Economic Outlooks and
   their updates have 11 or 12 years. The two short-horizon updates have 3 years (July 2023) and 4 years (September 2025).

## Open points

* cbo.gov returns HTTP 403 to scripted requests (DataDome bot protection), even with a browser-like User-Agent. `prep.R` therefore gets every
  file from the Internet Archive copy in `archive_url`. If CBO revises a file, the archived copy may be older than the file on cbo.gov.
* The February 2013 shading (2012 CPI-U forecast, 2012 unemployment rate actual) differs from the report table (both actual). The data
  follow the file.
* The publication dates of July 2000, January 2001, August 2001, January 2002, January 2003, August 2003 and January 2004 rest on
  contemporaneous third-party reports, not on a CBO page, because CBO's publication pages show placeholders. For January 2001 the source is a
  CBO official quoted by PBS.
