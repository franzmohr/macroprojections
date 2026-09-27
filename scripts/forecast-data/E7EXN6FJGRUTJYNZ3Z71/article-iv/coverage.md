> **In this repository** only the variables with an IMF WEO code are kept (NGDP_RPCH, PCPIPCH, LUR). The private consumption forecasts (NCP_RPCH) this collection also covered have no WEO code and are held outside macroprojections; they have been removed from the raw files and `sources.csv` here.

# IMF Article IV staff reports for Austria, 2008 to September 2026: coverage

Variables: NCP_RPCH (real private consumption, % change), NGDP_RPCH (real GDP, % change),
PCPIPCH (consumer prices, period average, % change), LUR (unemployment rate, % of labour force).
Only the years a table marks as projections are recorded. Every value was read from a page
image rendered with pdftoppm (150 to 260 dpi). The text layer was not used as the source,
because in several reports it misaligns row labels and values. PDFs, rendered images and text
extracts are in `pdf/`, `img/` and `txt/`, and `build.py` writes `raw/` and `sources.csv`.

`sources.csv` has one extra column, `variable`, because each report now carries four series.

## Is the list complete?

Each staff report's Informational Annex names the previous consultation. Following that chain
from 2026 back to 2008 gives an unbroken sequence with no missing reports:
2008 -> 2009 -> 2010 -> 2011 -> 2012 -> 2013 -> 2014 -> 2015 -> 2016 -> 2018 -> 2021 -> 2022 -> 2024 -> 2025 -> 2026.
- **No 2017 consultation.** The 2018 report says the last consultation was held in December 2016.
- **2019 and 2020:** missions only, no staff report. The May 2019 mission statement says the
  review would continue once a new government was formed. There is also a 2020 concluding
  statement (March 3, 2020). The 2021 report links back to the 2018 staff report.
- **No 2023 consultation.** The 2024 report says the previous discussions were May 30 to June 13, 2022.
- The 2007 Article IV report was published in 2007, so it falls outside the window.

## Reports

| pubdate | CR | Article IV | board | staff report completed | projection years | NCP | GDP | CPI | LUR | WEO before / after pubdate |
|---|---|---|---|---|---|---|---|---|---|---|
| 20080619* | 08/188 | 2008 | 2008-06-13 | 2008-05-22 | 2008-09 | none | Y | Y | Y | Apr 2008 / Oct 2008 |
| 20090921* | 09/295 | 2009 | 2009-09-09 | 2009-08-04 | 2009-10 | none | Y | Y | Y | Apr 2009 / Oct 2009 |
| 20100908 | 10/276 | 2010 | 2010-08-30 | 2010-07-29 | 2010-11 | none | Y | Y | Y | Apr 2010 / Oct 2010 |
| 20110906 | 11/275 | 2011 | 2011-09-02 | 2011-08-05 | 2011-12 | Table 2 | Y | Y | Y | Apr 2011 / Sep 2011 |
| 20120828 | 12/251 | 2012 | 2012-08-27 | 2012-07-31 | 2012-13 | Table 2 | Y | Y | Y | Apr 2012 / Oct 2012 |
| 20130910* | 13/280 | 2013 | 2013-09-04 | 2013-08-16 | 2013-14 | Table 2 | Y | Y | Y | Apr 2013 / Oct 2013 |
| 20140915 | 14/278 | 2014 | 2014-09-08 | 2014-07-31 | 2014-15 | Table 2 | Y | Y | Y | Apr 2014 / Oct 2014 |
| 20160212 | 16/50 | 2015 | 2016-02-10 | 2016-01-19 | 2015-16 | Table 2 | Y | Y | Y | Oct 2015 / Apr 2016 |
| 20170202 | 17/26 | 2016 | 2017-02-01 (LOT) | 2017-01-13 | 2017-22 | Y | Y | Y | Y | Oct 2016 / Apr 2017 |
| 20180912 | 18/272 | 2018 | 2018-09-10 | 2018-08-27 | 2018-23 | Y | Y | Y | Y | Apr 2018 / Oct 2018 |
| 20210909 | 21/203 | 2021 | 2021-08-30 | 2021-08-03 | 2021-26 | Y | Y | Y | Y | Apr 2021 / Oct 2021 |
| 20220902 | 22/284 | 2022 | LOT (PR 2022-09-02) | 2022-08-04 (cover: 08-23) | 2022-27 | Y | Y | Y | Y | Apr 2022 / Oct 2022 |
| 20240513 | 24/107 | 2024 | 2024-05-03 | 2024-04-19 | 2024-29 | Y | Y | Y | Y | Apr 2024 / Oct 2024 |
| 20250703 | 25/159 | 2025 | LOT, 2025-06-25 | 2025-06-09 | 2025-30 | Y | Y | Y | Y | Apr 2025 / Oct 2025 |
| 20260720 | 26/180 | 2026 | 2026-07-08 | 2026-06-24 | 2026-31 | Y | Y | Y | Y | Apr 2026 / Oct 2026 (not yet published on 27 Sep 2026) |

LOT means the Board concluded the consultation on a lapse-of-time basis, without a meeting.

`pubdate` is the date on the IMF publication page for the country report. Three dates are
marked `*` because their publication pages could not be retrieved: IMF's CDN began refusing
requests partway through the work. For these I used the date of the PIN or press release
printed inside the report. Where both dates could be checked, they matched in 2010, 2011, 2014,
2015 and 2016; 2012 is the only exception:
- 2008: PIN 08/72, June 19, 2008. The cover says only "June 2008".
- 2009: PIN 09/120, September 21, 2009. The cover says "September 2009".
- 2013: Press Release 13/331, September 10, 2013. The cover says "September 2013".
- 2012: the publication page says August 28, 2012, but PIN 12/102 is dated August 31, 2012. I used August 28.

The WEO vintages are the regular April and October issues around each publication date. The
autumn 2011 issue was the September 2011 WEO. Vintage names come from my own knowledge rather
than from WEO pages fetched during this work, so check their exact release dates before matching
on them.

## Where private consumption is missing, and the fallback

- **2008, 2009 and 2010 have no private consumption growth in the report.** Table 1 (Basic Data)
  has only total "Consumption", which is private plus public; I checked this against the
  contributions in Table 2. The Medium-Term Framework (Table 2) gives private consumption only
  as a percentage-point contribution to GDP growth. I did not derive growth rates from the
  contributions. None of the three narratives gives a private consumption growth number either.
- **2011 to 2015: Table 1 again has only total "Consumption".** Private consumption growth
  (% change) comes from Table 2, the Medium-Term Macroeconomic Framework, in the same staff
  report. I recorded only the years that Table 1 marks as projections, so these rows line up
  with GDP, CPI and unemployment. Table 2's later projection years are listed in the notes in
  `sources.csv`. The 2013 Table 2 is stamped "CORRECTED: 8/29/13".
- **From 2016 on**, the staff report's main indicator table has a "Private" row under
  "Consumption", so no fallback is needed.
- **Which table counts as "Selected Economic Indicators".** From 2021 on, the table titled
  "Austria: Selected Economic Indicators" is the short table in the *press release*. It covers
  about two projection years and has no consumption row. I used the staff report's main
  indicator table, which has more projection years and agrees with the press-release table
  where they overlap. That table is called "Summary/Main Economic Indicators" and is Table 1,
  2 or 4 depending on the year. In 2016 and 2018 it is also titled "Main Economic Indicators".

## Ambiguities

- **Households only, or including NPISHs.** No table says. "Private consumption" in the Austrian
  national accounts normally means households plus NPISHs, but the IMF tables do not confirm it.
- **Seasonal adjustment.** The 2025 and 2026 national accounts are labelled "SWDA" (seasonally
  and working-day adjusted). Earlier tables do not say. For 2025 the table also shows unadjusted
  real GDP (-0.1, 0.9, 1.6, 1.2, 1.1, 0.8); I recorded the SWDA row, which the press release also uses.
- **Where history ends and projections begin.** I followed each table's "Proj." or "Projections"
  marker:
  - 2015 Article IV (published February 2016): the year 2015 is still labelled a projection.
  - 2016 Article IV (published February 2017): the year 2016 is labelled "Est.", so I dropped it.
  - 2021 staff table: the "Projections" label is centred with no clear underline. The press-release
    table marks 2021 and 2022 as "Proj.", so I took 2021 to 2026.
- **Consumer prices.**
  - 2008 to 2015: labelled "Consumer price index" or "CPI inflation".
  - 2016 onwards: labelled "Consumer prices (avg)", without saying CPI or HICP.
  - In 2024, a text-table footnote marks only WIFO's forecast as national CPI, which suggests
    the staff figure is HICP. Not confirmed.
- **Unemployment.** I recorded the Eurostat or EU-harmonized rate throughout: "Standardized" in
  2008, "Standardized (Eurostat)" or "Eurostat definition" in 2009 to 2015, and "EU harmonized
  rate" from 2016. The national (registered) rate is given in the notes in `sources.csv`.
- **2016 report number.** IMF lists it as CR 17/26. The copy on the OeNB site is stamped
  "17/32", which is the press-release number. Its Table 1 is identical, and I used IMF's 17/26.
- **2021 and 2022 supplements.** The Staff Supplementary Information does not change any of these
  projections. In 2021 it updates only the balance-of-payments table.

## Concluding statements and press releases

None states a private consumption forecast as a number. Checked:
- Concluding statements for 2008, 2009, 2010, 2013, 2014, 2015, 2016, 2018, 2020, 2021, 2022,
  2024, 2025 and 2026, and the 2019 mission statement. They give numbers for GDP growth only.
- The press-release indicator tables in every report. None has a consumption row.
- The 2011 and 2012 concluding statements were not located, so they were not checked.
