# IMF WEO vintages after October 2024 (LEI E7EXN6FJGRUTJYNZ3Z71)

Retrieved 2026-09-27. No values were typed in, interpolated or imputed.

## Vintages found

| Vintage | Official publication date | Where it is now | Format obtained | File in `raw/` |
|---|---|---|---|---|
| April 2025 | 2025-04-22 | imf.org legacy page `weo-database/2025/april/download-entire-database` | SDMX 2.1 WEO_PUB XML, the same structure as 2021–2024 | `20250422_weo.xml` |
| October 2025 | 2025-10-14 | IMF Data Portal, dataset `IMF.RES:WEO_2025_OCT_VINTAGE` (1.0.0) | Excel "WEO October 2025 Entire Dataset" and SDMX 2.1 from the API. The WEO_PUB SDMX file no longer exists. | `20251014_weo.csv` (converted) |
| April 2026 | 2026-04-14 | IMF Data Portal, dataset `IMF.RES:WEO` (9.0.0, the current vintage) | Excel "April 2026 WEO Entire Dataset" and SDMX 2.1 from the API | `20260414_weo.csv` (converted) |

- **No other vintages exist in between.** The WEO Updates of July 2025, January 2026 and July 2026 come without a database. The IMF's WEO Database Transition Guide (in `checks/`) says so explicitly.
- **October 2026 is not out yet.** On 2026-09-27 the October 2026 WEO had not been published.
- **Publication dates:** April 2025 is 22 April 2025, the date in the URL of the report's issue page. Its SDMX header and the portal copy (WEO 6.0.0) also carry `PUBLICATION_DATE 2025-04-22`. The portal's "Reports" list shows "14 Apr" for it, which looks like a portal error. October 2025 has `PUBLICATION_DATE 2025-10-14`. April 2026 has `PUBLICATION_DATE 2026-04-14`.
- **The October 2025 portal dataset was updated after publication.** It carries `UPDATE_DATE 2025-11-19`, so the portal copy may include a correction made after publication. The Excel file and the API extract agree on every value (see Checks below).

## Files

- `raw/20250422_weo.xml`: this is `xmlfile_APR2025.xml` from `original/weoapr2025-sdmxdata.zip`, unchanged. prep.R reads it without any change (tested with prep.R's `read_imf_pred()` verbatim: 3,177 rows, 193 economies).
- `raw/20251014_weo.csv` and `raw/20260414_weo.csv`: the converted rows, with columns `year, variable, ctry, value, pubdate` written with `write.csv` exactly as in `forecasts.csv`. prep.R does **not** pick these up, because it lists only `*.xml` files. They have to be appended separately, e.g. by `rbind`-ing them onto the result of prep.R.
- `original/`: the files as downloaded:
  - `weoapr2025-sdmxdata.zip`, `weopub-dsd-apr2025.xlsx` and `weoapr2025all.xls`. The last is the April 2025 tab-delimited file in UTF-16, used only for the country code mapping.
  - `WEOOct2025all.xlsx` and `WEOApr2026all.xlsx`: the official entire-dataset Excel files from data.imf.org.
  - `WEO_2025_OCT_VINTAGE_1.0.0_…_sdmx21.xml` and `WEO_9.0.0_Apr2026_…_sdmx21.xml`: API extracts for the three indicators, used only for cross-checking. They came from `https://api.imf.org/external/sdmx/2.1/data/IMF.RES,<flow>,<version>/.NGDP_RPCH+PCPIPCH+LUR.A`.
- `convert_new_format.R`: produces the two CSVs from the Excel files.
- `checks/`: the WEO Statistical Appendix Tables A and B for each vintage, the April 2026 Database Appendix, and the Transition Guide.

## How the new format was mapped onto prep.R's columns

The source for both vintages is the official Excel sheet `Countries`. The only row taken from the sheet `Country Groups` is `G163`, the euro area. prep.R's filters, applied to the new columns:

| prep.R (WEO_PUB XML) | New format (Excel / portal) | Mapping |
|---|---|---|
| `FREQ == "A"` | `FREQUENCY == "Annual"` | Every row is annual. |
| `CONCEPT` | `INDICATOR.ID` | The codes are identical: NGDP_RPCH, PCPIPCH, LUR. |
| `REF_AREA` (IMF numeric code) | `COUNTRY.ID` (ISO3) | ISO3 is mapped to the WEO country code using the April 2025 tab-delimited file, which has both `WEO Country Code` and `ISO`. The mapping is one to one. It was checked on the April 2025 vintage: the portal copy (ISO codes) and the WEO_PUB file (numeric codes) agree on all 3,170 common rows, with no value differences. There are two additions, `KOS → 967` and `G163 → 163`, explained below. |
| `TIME_PERIOD` | year columns `1980` … `2031` | Pivoted to long format. |
| `LASTACTUALDATE` | `LATEST_ACTUAL_ANNUAL_DATA` | The Transition Guide maps "Estimates Start After" to this field. For fiscal-year economies the new field says e.g. `FY2023/24`. It is mapped to the year in which the fiscal year ends (2024), for the reason given below. |
| `TIME_PERIOD > LASTACTUALDATE` | `year > last actual` | Series with no last-actual year are dropped. prep.R drops these too, because the comparison is NA. |
| `OBS_VALUE`, "n/a" → NA, remove "," | the value | Rows with empty cells are dropped. The Excel files contain no "n/a" or "--" strings. |
| `pubdate` from the file name | the official publication date | 2025-10-14 and 2026-04-14 |

**Fiscal years.** In the old WEO_PUB files, the NOTES of fiscal-year series state "Latest actual data: FYxxxx/yy" next to a numeric LASTACTUALDATE. In every such series, LASTACTUALDATE was the year in which the fiscal year ends: 386 series in `20241022_weo.xml` and 367 in `20250422_weo.xml`, with no exception. This holds even for series whose notes say "FY(t/t+1) = CY(t)", such as Iran and India. So `FY2023/24` becomes 2024. Without this rule, 12 economies would have lost all projections, among them India, Pakistan, Iran and Bangladesh, because `"2025" > "FY2024/25"` is FALSE in R.

**Kosovo.** The portal code is `KOS`. The April 2025 file lists Kosovo as `UVK` with WEO code 967, which also appears in `forecasts.csv`.

**Euro area (163).** prep.R keeps REF_AREA 163 because the euro area is the only aggregate with a LASTACTUALDATE. Historically it kept LUR only, because only the LUR series of 163 carried a LASTACTUALDATE. In the new files, `G163` has a last-actual year for all three variables. The CSVs therefore contain NGDP_RPCH and PCPIPCH for 163 as well: 6 extra rows each per vintage. Drop them if the series should match the older vintages.

**Liechtenstein (LIE)** is left out. It has projections from October 2025 onwards, but no WEO numeric code appears in any WEO_PUB file or in the IMF codelist, and I did not invent one.

**Sri Lanka (524)** has no rows in April 2026. Its cells for 2025 onwards are empty in the IMF's own file.

**Precision.** Country values in the Excel files are rounded to 3 decimals, like the WEO_PUB files. The API gives unrounded values; e.g. Austria's GDP growth for 2026 is 0.681765 in the API and 0.682 in Excel. I used the Excel values.

**Missing-value rows.** For `"--"` cells, prep.R produces rows with value NA. In the April 2025 file there is one: ctry 642 (Equatorial Guinea), NGDP_RPCH, 2026. The new files have no such cells, so the CSVs have no NA rows.

Row counts: April 2025 (prep.R) 3,177 rows / 193 economies. October 2025 3,023 / 193. April 2026 3,142 / 192. Earlier vintages in `forecasts.csv` have 3,011–3,277 rows.

## Checks

**1. Excel versus API (whole vintage).** Both CSVs were rebuilt from the portal SDMX API extracts with the same rules:
- October 2025: 3,023 of 3,023 rows match, with no differences at 3 decimals.
- April 2026: 3,142 of 3,142 rows match. 6 values differ in the third decimal, all of them half-way rounding cases. Examples: San Marino (135) LUR 4.4425 in the API against 4.443 in Excel, and Tajikistan (923) GDP 2024 8.4165 against 8.417.

**2. April 2025, WEO_PUB XML versus portal (WEO 6.0.0).** 3,170 common rows, with no differences. The only rows not in common are euro-area LUR and the `"--"` row.

**3. Published WEO tables.** The files are the WEO Statistical Appendix, `checks/weo_<vintage>_tablea.pdf` and `tableb.pdf`: Table A2 for real GDP, A6 for consumer prices and B1 for the unemployment rate. The tables show 1 decimal. Values in the files are given as file → table.

| Vintage | Country | Variable | Year t | Year t+1 |
|---|---|---|---|---|
| **Apr 2025** (t = 2025) | Austria 122 | GDP | −0.261 → −0.3 ✓ | 0.775 → 0.8 ✓ |
| | | CPI | 3.183 → 3.2 ✓ | 1.694 → 1.7 ✓ |
| | | LUR | 5.586 → 5.6 ✓ | 5.533 → 5.5 ✓ |
| | Germany 134 | GDP | −0.050 → 0.0 ✓\* | 0.922 → 0.9 ✓ |
| | | CPI | 2.086 → 2.1 ✓ | 1.946 → 1.9 ✓ |
| | | LUR | 3.468 → 3.5 ✓ | 3.215 → 3.2 ✓ |
| | United States 111 | GDP | 1.826 → 1.8 ✓ | 1.744 → 1.7 ✓ |
| | | CPI | 2.988 → 3.0 ✓ | 2.466 → 2.5 ✓ |
| | | LUR | 4.159 → 4.2 ✓ | 4.151 → 4.2 ✓ |
| **Oct 2025** (t = 2025) | Austria 122 | GDP | 0.270 → 0.3 ✓ | 0.764 → 0.8 ✓ |
| | | CPI | 3.562 → 3.6 ✓ | 2.328 → 2.3 ✓ |
| | | LUR | 5.681 → 5.7 ✓ | 5.554 → 5.6 ✓ |
| | Germany 134 | GDP | 0.191 → 0.2 ✓ | 0.944 → 0.9 ✓ |
| | | CPI | 2.114 → 2.1 ✓ | 1.756 → 1.8 ✓ |
| | | LUR | 3.669 → 3.7 ✓ | 3.368 → 3.4 ✓ |
| | United States 111 | GDP | 2.017 → 2.0 ✓ | 2.102 → 2.1 ✓ |
| | | CPI | 2.715 → 2.7 ✓ | 2.435 → 2.4 ✓ |
| | | LUR | 4.184 → 4.2 ✓ | 4.119 → 4.1 ✓ |
| **Apr 2026** (t = 2026) | Austria 122 | GDP | 0.682 → 0.7 ✓ | 1.004 → 1.0 ✓ |
| | | CPI | 2.451 → 2.5 ✓ | 2.561 → 2.6 ✓ |
| | | LUR | 5.719 → 5.7 ✓ | 5.577 → 5.6 ✓ |
| | Germany 134 | GDP | 0.791 → 0.8 ✓ | 1.183 → 1.2 ✓ |
| | | CPI | 2.651 → 2.7 ✓ | 2.295 → 2.3 ✓ |
| | | LUR | 3.860 → 3.9 ✓ | 3.458 → 3.5 ✓ |
| | United States 111 | GDP | 2.324 → 2.3 ✓ | 2.100 → 2.1 ✓ |
| | | CPI | 3.228 → 3.2 ✓ | 2.141 → 2.1 ✓ |
| | | LUR | 4.376 → 4.4 ✓ | 4.249 → 4.2 ✓ |

\* Germany's GDP for 2025 in April 2025 is −0.050 at 3 decimals. The table prints 0.0, which is consistent with an unrounded value just above −0.05.

For April 2026, the IMF DataMapper (`imf.org/external/datamapper/api/v1`, which now serves April 2026) gives the same values at 1 decimal for all nine Austria, Germany and US series for 2026–27.

In April 2026, 2025 is already an actual year for Austria, Germany and the US, so their rows start in 2026. That is consistent with Tables A2 and B1, which show 2025 outside the projection columns.

## Doubts

- **The new CSVs cannot be read by prep.R unchanged.** They do not come from a WEO_PUB file, and prep.R lists only `.xml` files.
- **The fiscal-year rule is inferred, not documented.** The rule `FYxxxx/yy` → end year is inferred from the old files. It reproduces them exactly, but the IMF does not document it for the new field.
- **Some Excel metadata looks stale.** `COUNTRY_UPDATE_DATE` for Austria is 2025-09-18 even in April 2026, although the April 2026 values differ from October 2025. The values themselves match the published tables.
- **The October 2025 portal copy may not be the original release.** It was updated on 2025-11-19, and I could not obtain a copy frozen at 2025-10-14 to compare. The legacy imf.org download page for October 2025 is a 404.
- **Euro-area GDP and CPI and Liechtenstein** are left to your decision, as described above.
