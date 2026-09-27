> **In this repository** only the variables with an IMF WEO code are kept (NGDP_RPCH, PCPIPCH, LUR). The private consumption forecasts (NCP_RPCH) this collection also covered have no WEO code and are held outside macroprojections; they have been removed from the raw files and `sources.csv` here.

# OECD Economic Outlook projections 2008 – September 2026: coverage

Variables: `NGDP_RPCH` real GDP growth, `NCP_RPCH` real private consumption growth, `PCPIPCH` consumer price inflation, `LUR` unemployment rate.
Output: `raw/YYYYMMDD_<VAR>.csv` (185 files), `sources.csv` (one row per file). Working files (downloads, parsers, cross-checks) are in `work/`.

## Summary

* **All 37 full editions, EO83 (June 2008) to EO119 (June 2026), were collected for all four variables** (148 tables).
* **25 interim releases were collected** (37 tables): the Interim Report of March 2009 (GDP, inflation and unemployment for the US, Japan
  and the euro area), the Interim Economic Assessments of September 2014 and March 2015 (GDP), and every Interim Economic Outlook from
  September 2015 to September 2026 (GDP, plus headline inflation from September 2021). No interim reports private consumption, and
  only March 2009 reports unemployment.
* Only projection years are kept: the edition's publication year and the following year or years that the table projects
  (June/May editions and interims: 2 years; Nov/Dec editions: 3 years). Earlier years, averages, Q4/Q4 columns and
  "difference from previous EO" columns are dropped.
* Values are rounded to one decimal, as printed. The Excel values are at full precision; rounding them half-up reproduced the printed
  PDF tables and the Austria country notes in every case checked. `..` in a table is written as `NA`.

## Coverage by edition

| Pubdate | Edition | Kind | Years | GDP | Cons. | CPI | Unemp. | Source type |
|---|---|---|---|---|---|---|---|---|
| 20080604 | EO83 | main | 2008-2009 | 31 | 31 | 31 | 31 | StatLink |
| 20081125 | EO84 | main | 2008-2010 | 33 | 33 | 33 | 33 | StatLink |
| 20090331 | Interim Report March 2009 | interim | 2009-2010 | 3 | – | 3 | 3 | PDF |
| 20090624 | EO85 | main | 2009-2010 | 33 | 32 | 33 | 33 | StatLink |
| 20091119 | EO86 | main | 2009-2011 | 33 | 33 | 33 | 33 | StatLink |
| 20100526 | EO87 | main | 2010-2011 | 34 | 34 | 34 | 34 | StatLink |
| 20101118 | EO88 | main | 2010-2012 | 35 | 35 | 35 | 35 | StatLink |
| 20110525 | EO89 | main | 2011-2012 | 35 | 35 | 35 | 35 | StatLink |
| 20111128 | EO90 | main | 2011-2013 | 35 | 35 | 35 | 35 | StatLink |
| 20120522 | EO91 | main | 2012-2013 | 35 | 35 | 35 | 35 | StatLink |
| 20121127 | EO92 | main | 2012-2014 | 35 | 35 | 35 | 35 | StatLink |
| 20130529 | EO93 | main | 2013-2014 | 35 | 35 | 35 | 35 | StatLink |
| 20131119 | EO94 | main | 2013-2015 | 35 | 35 | 35 | 35 | StatLink |
| 20140506 | EO95 | main | 2014-2015 | 35 | 35 | 35 | 35 | StatLink |
| 20140915 | Interim Economic Assessment September 2014 | interim | 2014-2015 | 11 | – | – | – | PDF |
| 20141125 | EO96 | main | 2014-2016 | 35 | 35 | 35 | 35 | StatLink |
| 20150318 | Interim Economic Assessment March 2015 | interim | 2015-2016 | 11 | – | – | – | PDF |
| 20150603 | EO97 | main | 2015-2016 | 43 | 43 | 43 | 35 | StatLink |
| 20150916 | Interim Economic Outlook September 2015 | interim | 2015-2016 | 12 | – | – | – | PDF |
| 20151109 | EO98 | main | 2015-2017 | 45 | 44 | 45 | 35 | StatLink |
| 20160218 | Interim Economic Outlook February 2016 | interim | 2016-2017 | 12 | – | – | – | PDF |
| 20160601 | EO99 | main | 2016-2017 | 45 | 44 | 45 | 35 | StatLink |
| 20160921 | Interim Report September 2016 | interim | 2016-2017 | 12 | – | – | – | PDF |
| 20161128 | EO100 | main | 2016-2018 | 46 | 45 | 46 | 36 | StatLink |
| 20170307 | Interim Economic Outlook March 2017 | interim | 2017-2018 | 12 | – | – | – | PDF |
| 20170607 | EO101 | main | 2017-2018 | 46 | 45 | 46 | 36 | StatLink |
| 20170920 | Interim Economic Outlook September 2017 | interim | 2017-2018 | 13 | – | – | – | PDF |
| 20171128 | EO102 | main | 2017-2019 | 46 | 45 | 46 | 36 | StatLink |
| 20180313 | Interim Economic Outlook March 2018 | interim | 2018-2019 | 21 | – | – | – | PDF |
| 20180530 | EO103 | main | 2018-2019 | 46 | 45 | 46 | 36 | StatLink |
| 20180920 | Interim Economic Outlook September 2018 | interim | 2018-2019 | 21 | – | – | – | PDF |
| 20181121 | EO104 | main | 2018-2020 | 46 | 45 | 46 | 37 | StatLink |
| 20190306 | Interim Report March 2019 | interim | 2019-2020 | 21 | – | – | – | PDF |
| 20190521 | EO105 | main | 2019-2020 | 46 | 45 | 46 | 37 | PDF (annex) |
| 20190919 | Interim Report September 2019 | interim | 2019-2020 | 21 | – | – | – | PDF |
| 20191121 | EO106 | main | 2019-2021 | 48 | 47 | 48 | 37 | EO database |
| 20200302 | Interim Report March 2020 | interim | 2020-2021 | 21 | – | – | – | PDF |
| 20200610 | EO107 | main | 2020-2021 | 48 | 47 | 48 | 38 | Annex Excel |
| 20200916 | Interim Report September 2020 | interim | 2020-2021 | 21 | – | – | – | PDF |
| 20201201 | EO108 | main | 2020-2022 | 48 | 47 | 48 | 38 | Annex Excel |
| 20210309 | Interim Report March 2021 | interim | 2021-2022 | 22 | – | – | – | PDF |
| 20210531 | EO109 | main | 2021-2022 | 48 | 47 | 48 | 39 | EO database |
| 20210921 | Interim Report September 2021 | interim | 2021-2022 | 22 | – | 20 | – | PDF |
| 20211201 | EO110 | main | 2021-2023 | 48 | 47 | 48 | 39 | Annex Excel, PDF (annex) |
| 20220608 | EO111 | main | 2022-2023 | 48 | 46 | 48 | 39 | Annex Excel |
| 20220926 | Interim Report September 2022 | interim | 2022-2023 | 22 | – | 21 | – | PDF |
| 20221122 | EO112 | main | 2022-2024 | 50 | 48 | 50 | 39 | EO database |
| 20230317 | Interim Report March 2023 | interim | 2023-2024 | 22 | – | 21 | – | PDF |
| 20230607 | EO113 | main | 2023-2024 | 50 | 48 | 50 | 39 | EO database |
| 20230919 | Interim Report September 2023 | interim | 2023-2024 | 22 | – | 21 | – | PDF |
| 20231129 | EO114 | main | 2023-2025 | 50 | 48 | 50 | 39 | EO database |
| 20240205 | Interim Report February 2024 | interim | 2024-2025 | 22 | – | 21 | – | PDF |
| 20240502 | EO115 | main | 2024-2025 | 49 | 47 | 49 | 39 | Annex Excel |
| 20240925 | Interim Report September 2024 | interim | 2024-2025 | 22 | – | 21 | – | PDF |
| 20241204 | EO116 | main | 2024-2026 | 49 | 47 | 49 | 39 | Annex Excel |
| 20250317 | Interim Report March 2025 | interim | 2025-2026 | 22 | – | 21 | – | PDF |
| 20250603 | EO117 | main | 2025-2026 | 49 | 47 | 49 | 39 | Annex Excel |
| 20250923 | Interim Report September 2025 | interim | 2025-2026 | 22 | – | 21 | – | PDF |
| 20251202 | EO118 | main | 2025-2027 | 50 | 48 | 50 | 39 | Annex Excel |
| 20260326 | Interim Report March 2026 | interim | 2026-2027 | 22 | – | 21 | – | PDF |
| 20260603 | EO119 | main | 2026-2027 | 51 | 49 | 51 | 39 | Annex Excel |
| 20260923 | Interim Report September 2026 | interim | 2026-2027 | 22 | – | 21 | – | PDF |

The columns GDP to Unemp. give the number of rows written, meaning the countries and aggregates that map to `geo_list.csv`.

## Source types

| Editions | Source | Notes |
|---|---|---|
| EO83–EO104 | **StatLink** Excel file of each annex table (the DOI link under each table in the edition PDF; it resolves to statlinks.oecdcode.org) | 88 files, all retrieved |
| EO105 | **PDF**: the separate statistical annex `EO105_Annexes_E.pdf` (an oecd.org copy retrieved from web.archive.org) | From EO105 on, the annex is published separately and has no StatLinks |
| EO107 (single-hit), EO108, EO111 | **Annex Excel** workbooks (`EOxxx_Demand-and-Output.xls[x]`, `..._Inflation-Wages-Costs-and-Labour-Market.xls[x]`): oecd.org copies retrieved from web.archive.org | EO107 published two scenarios. The annex tables are the single-hit scenario (file `EO107_1_*`, database flow `DF_EO107_INTERNET_1`) |
| EO110 | GDP and consumption: **PDF** annex (archived `EO110_Annexes_E.pdf`). CPI and unemployment: **Annex Excel** (archived) | The Demand-and-Output workbook for EO110 was not archived |
| EO115–EO119 | **Annex Excel** `EOxxx_Statistical_Annexes.xlsx` from oecd.org (`content/dam/...`) | EO119 has two scenarios. Its annex is the central projection ("time-limited disruption") and equals the EO119 database |
| EO106, EO109, EO112, EO113, EO114 | **The OECD EO database vintage of that edition**, via SDMX: the `sdmx.oecd.org/archive` flows `DF_EO106_INTERNET`, `DF_EO109_INTERNET`, `DF_EO112_INTERNET` and `DF_EO113_INTERNET`, and the `sdmx.oecd.org/public` flow `OECD.ECO.MAD,DSD_EO_114@DF_EO_114` | No annex file could be retrieved, whether StatLink, Excel or annex PDF. The oecd.org pages sit behind a Cloudflare challenge, and web.archive.org has no copies. See "Database editions" below |
| Interims | **PDF** of the interim report or handout (from oecd.org `content/dam`, or web.archive.org copies of oecd.org files) | Parsed from the PDF text. March 2009 and September 2014 were transcribed by hand. Interim reports have no StatLinks |

### Database editions (EO106, EO109, EO112–EO114)
Each database vintage is the edition's own: the dataflow is titled, for example, "Economic Outlook No 112 - November 2022". To test
whether a database vintage reproduces the annex, every annex-sourced edition (EO83–EO105, EO107, EO108, EO110, EO111 and EO115–EO119)
was compared cell by cell with its own database vintage. **All values agree to one decimal**, with two exceptions:

* cells missing from the database: Slovenia unemployment in EO85, EO88 and EO89, and Chile consumption in EO87–EO90;
* EO102 euro-area GDP 2018: the StatLink gives 2.1 and the database rounds to 2.2. The StatLink value is kept.

The five database editions follow the same rules as the annex:

* GDP comes from `GDPV_ANNPCT`, consumption from `CPV_ANNPCT` and unemployment from `UNR`.
* Consumer prices use the HICP (`CPIH_YTYPCT`) for euro-area members, the euro area and the United Kingdom, and the national CPI
  (`CPI_YTYPCT`) for all other countries. The annex followed exactly this split in every edition checked. For Croatia (EO112–EO114)
  the database has only the HICP.
* The rows are all countries with projections plus the euro area. The euro area is database code `EA17`, which holds the current
  euro-area aggregate. The database "World" aggregate is left out of GDP, because the annex GDP table has no World row. The
  unemployment table keeps only OECD members, as the annex does:
  * EO106: Colombia and Costa Rica are excluded, because they were not yet members in November 2019.
  * EO109: Costa Rica is included, because it was a member from 25 May 2021. Whether the EO109 annex listed it could not be verified.

## Definitions
* **NGDP_RPCH**: real GDP at market prices, % change from the previous year (annex table "Real GDP"; in interims, "Real GDP growth,
  year-on-year"). India is on a fiscal-year basis (April–March) in the OECD tables.
* **NCP_RPCH**: real private final consumption expenditure, % change (annex table "Real private consumption expenditure").
* **PCPIPCH**:
  * Main editions: annex table "Consumer price indices", % change from the previous year. The table uses the **HICP for euro-area
    countries, the euro area and the United Kingdom, and the national CPI for all other countries**. This was verified against the
    database for every edition.
  * Interims: "Headline inflation", with the same HICP/CPI convention, **except that the United States value is the private
    consumption expenditure (PCE) deflator**. This holds from September 2021 to September 2026: the interim value minus its printed
    revision reproduces the PCE deflator in the preceding EO database, not the CPI. The September 2021 table note says so explicitly;
    later notes do not.
  * March 2009 interim: CPI for the US and Japan, HICP for the euro area.
* **LUR**: unemployment rate, % of labour force, national ("commonly used") definitions. The annex table is "Unemployment rates:
  commonly used definitions" up to EO97 and "Unemployment rates: national definitions" from EO98. The harmonised-rate table was not used.

## Name mapping (OECD label → `geo_list.csv` ctry_name)
* `Czechia` → `Czech Republic` (EO115–EO119). `Czech Republic` is unchanged elsewhere.
* `Türkiye`, including the encoding variant `T�rkiye`, → `Turkey`. `Turkey` is unchanged.
* `Russian Federation` → `Russia` (EO97–EO99).
* `Euro area 17`, and `Euro area2` and `Euro area7` with their footnote markers → `Euro area`.
* Footnote markers were removed: `India¹`/`India1`/`India3`, `Iceland1`, `Mexico1`, `Spain2`, `Sweden2`/`Sweden3`,
  `United Kingdom2`/`United Kingdom3`, `United States3`/`United States4`, `World1`.
* `Korea`, `Slovak Republic` and `China` are already geo_list names. The database label "China (People's Republic of)" → `China`.
* `World` (interims only) → `World`. This is the OECD's PPP-weighted world aggregate, which is not necessarily the IMF's definition.

**Dropped rows (no geo_list entry):**
* `Total OECD`, in all main editions, because geo_list has no OECD aggregate
* `G20` / `G-20`
* `G20 countries excluding Argentina and Türkiye` (a memo row in the 2025–26 interim inflation tables)
* `Rest of the World`
* `Aggregate` (March 2015)
* `Other countries` and `Total OECD` (March 2009)

No other row was unmappable.

## Editions or variables not found or not collected
* No interim has private consumption projections, and only March 2009 has unemployment projections.
* Interim inflation is published only from September 2021 on, plus March 2009. Earlier interims give GDP only.
* **March 2022 interim** ("Economic and Social Impacts and Policy Implications of the War in Ukraine"): it has no projection table, so
  nothing was collected.
* **Interim assessments from 2008 to March 2014**: those checked (September 2013 and March 2014) contain only quarterly G7
  indicator-model forecasts, with no annual projection table for these variables, so none were collected. The other assessments of
  2008–2013 were not retrieved or inspected. The **September 2012 "Interim Report"** (DOI eco_outlook-v2012-sup1) could not be retrieved.
* Main editions: nothing is missing. For EO106, EO109, EO112, EO113 and EO114 the annex itself could not be retrieved, so the database
  was used (see above).
* NA cells, as printed:
  * Estonia and Slovenia rows in EO84–EO88 (pre-accession `..`)
  * China consumption in EO97
  * Russia consumption in EO110

## Checks
* **Austria check (all 37 main editions):** every Austria value in the output was compared with the Austria country-note table
  ("Austria: Demand, output and prices"). This covers GDP, private consumption, HICP and the unemployment rate for all projection
  years: 368 values. The country notes came from the StatLink Excel files of the notes for EO83–EO104 and EO109–EO119, and from the
  notes in the edition PDFs for EO105–EO108 (for EO107, the single-hit table). **No mismatch.** Interims have no country notes.
  Detail: `work/austria_check.csv`.
* **Picture re-reads of PDF tables** (at least one in five of the PDF-derived tables):
  * Annex PDF tables (3 of 6): EO105 Real GDP, EO105 Unemployment, EO110 Private consumption
  * Interim tables (8 of 37): March 2009, September 2014, March 2015, February 2016, September 2019, September 2021 inflation,
    March 2023 GDP and September 2026 inflation

  All values matched.
* Annex-versus-database cross-check: see "Database editions".

## Publication dates
Each date is the OECD release (press-conference) date. The source for every date is recorded in `sources.csv` in the notes
column, as "date: <source>". No date needed correcting, so no raw file was renamed.

* **EO83–EO111 and the interims of 2009-03-31, 2018-03-13, 2020-09-16, 2021-03-09, 2021-09-21, 2022-09-26, 2023-03-17 and
  2023-09-19 were all verified against primary OECD sources**, retrieved as web.archive.org captures of oecd.org. The sources are of
  four kinds:
  * the OECD Economic Outlook landing page's press-conference line (EO83, EO84, EO85, EO88, EO89, EO91);
  * OECD press handouts, "Press Conference Paris, <date>" (EO86, EO87, EO90);
  * OECD newsroom media advisories, "... to be released on <date>" (EO92–EO97, EO99–EO111);
  * OECD press releases carrying the release date (EO98 9/11/2015, the interims 16/09/2020 and 19/09/2023) or the OECD interim page
    (31 March 2009).

  Every date given before is confirmed.
* **EO112–EO115 and the 2024-02-05 interim** were verified against OECD media advisories (web.archive.org captures).
* **EO118, EO119 and the interims of 2024-09-25 to 2026-09-23** were verified against the titles of OECD media advisories on oecd.org
  ("OECD to release ... on <weekday> <date>"). These were located by web search, because oecd.org itself cannot be fetched.
* **The other interims from 2014 to 2020** have their date printed on the document, and each is also matched by an OECD media advisory.
* **Date unverified: EO116 (20241204) and EO117 (20250603).** No primary release-date page could be retrieved for them. Web search
  reports these dates, but only in search summaries, not in a retrievable OECD document. They are marked "date unverified" in
  `sources.csv`.
