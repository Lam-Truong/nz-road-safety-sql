# Five Years of NZ Road Safety (2019–2024)
## A SQL-based Exploratory Analysis of the Waka Kotahi Crash Analysis System

**TL;DR**
- Total crashes fell ~20% between 2019 and 2024, but fatal crashes fell only 7.8% — severity per crash has worsened, not improved.
- Fatal crashes are 45% more likely during holiday periods than normal days.
- Per capita, Northland has 6.4x Auckland's road death rate despite a fraction of the population.
- Mist and fog produce crashes 1.5x more likely to be fatal than the national average.
- Road to Zero has not yet delivered measurable improvements in crash severity — deaths per 10,000 crashes actually increased from 95.08 (pre) to 104.88 (post).

---

## Dataset

**Primary:** Waka Kotahi NZTA Crash Analysis System (CAS) open data — the official record of every crash reported to NZ Police since 2000. ~913,000 records. Free, publicly licensed.
Source: [Link](https://opendata-nzta.opendata.arcgis.com/datasets/NZTA::crash-analysis-system-cas-data-1/about)

**Supporting:** Stats NZ Subnational Population Estimates (used for Q3 per-capita analysis).
Source: [Link](https://www.stats.govt.nz/information-releases/subnational-population-estimates-at-30-june-2024-2018-base/)

See `download_data.sh` for download instructions. See *Data Notes* below for how the Stats NZ file was prepared.

---

## Tools

- **DuckDB** — embedded SQL engine (Python library via `pip install duckdb`)
- **Python / Jupyter Notebook** — analysis environment
- **pandas, seaborn, matplotlib** — data wrangling and visualisation
- **VS Code** — editor
- **Git / GitHub** — version control

---

## How to Reproduce

1. Clone the repo:
   ```bash
   git clone https://github.com/Lam-Truong/nz-road-safety-sql.git
   cd nz-road-safety-sql
   ```
2. Install dependencies:
   ```bash
   pip install duckdb pandas seaborn matplotlib jupyter
   ```
3. Download the data (see `download_data.sh` and *Data Notes* below):
   ```bash
   bash download_data.sh
   ```
4. Open and run `project_1_workbook.ipynb` in order from top to bottom.

---

## Findings

### Q1 — Is NZ road safety actually improving over time?

The overall number of crashes increased between 2015 and 2017, followed by a marked decline through to 2024. After the introduction of Road to Zero in late 2019, total crashes decreased from 36,930 to 29,332 in 2024 — an approximate **20% reduction**. However, improvements in more severe outcomes have been more modest, with serious injuries and fatalities declining by only 2.4% and 7.8% respectively over the same period. Most notably, fatalities surged in 2022, increasing 15% compared to 2021 — a signal that overall crash volume and crash severity are moving independently.

### Q2 — When are crashes and fatalities most likely?

There is a clear distinction in crash severity between holiday periods and normal days. The fatality rate during holiday periods is **1.39%**, compared to **0.96%** on non-holiday days — a 45% relative increase. The pattern is even more pronounced for serious crashes: the serious crash rate on holiday periods is **1.94x higher** than on normal days. This suggests that targeted enforcement and road safety campaigns during holiday periods could have an outsized impact on outcomes.

### Q3 — Which regions are the most dangerous per capita?

Raw crash counts favour high-population regions, so per-capita normalisation is essential to identify where crashes are genuinely most dangerous. Using Stats NZ 2023 population estimates as a mid-period proxy across 2020–2024, the five most dangerous regions by deaths per 100,000 population are:

| Rank | Region | Deaths per 100k |
|------|--------|----------------|
| 1 | Northland | 82.12 |
| 2 | Marlborough | 74.80 |
| 3 | West Coast | 67.85 |
| 4 | Manawatū–Whanganui | 65.55 |
| 5 | Gisborne | 59.27 |

Auckland (12.82) and Wellington (12.45) rank at the bottom — their high raw crash counts reflect population size, not disproportionate danger. The gap between Northland and Auckland represents a **6.4x difference** in per-capita road death risk, a signal that national safety targets may need regional sub-targets to be effective.

### Q4 — What environmental factors are over-represented in fatal crashes?

Using relative risk — the ratio of a condition's fatal crash rate to the national baseline — we can identify which weather conditions are genuinely over-represented in fatal crashes, controlling for how common they are overall.

| Weather | Relative Risk |
|---------|--------------|
| Mist or Fog | 1.49 |
| Fine | 1.07 |
| Heavy Rain | 1.01 |
| Light Rain | 0.81 |

After filtering to conditions with over 1,000 recorded crashes for statistical reliability, **mist and fog** emerged as the most dangerous, with crashes 1.5x more likely to be fatal than the national average. Counterintuitively, **light rain** showed a relative risk of 0.81 — crashes under this condition are 19% *less* likely to be fatal, likely because drivers naturally reduce speed in light rain.

*Caveat: relative risk indicates correlation, not causation. Conditions do not cause fatalities — driver behaviour under those conditions does.*

### Q5 — Did Road to Zero (launched 2019) change outcomes?

Comparing 2015–2018 (pre-policy) to 2021–2024 (post-policy), skipping 2019 (transition year) and 2020 (COVID-distorted traffic volumes):

| Era | Total Crashes | Deaths | Deaths per 10k Crashes | Serious Injuries | Serious per 10k Crashes |
|-----|--------------|--------|----------------------|-----------------|------------------------|
| Pre-RtZ | 147,138 | 1,399 | 95.08 | 10,175 | 691.53 |
| Post-RtZ | 126,242 | 1,324 | 104.88 | 9,752 | 772.48 |

Total road deaths remained essentially unchanged at approximately 1,300 per cohort. However, the fatality rate *increased* from 95.08 to 104.88 deaths per 10,000 crashes — meaning individual crashes became more likely to be fatal, not less. Serious injuries fell in raw terms, but serious injuries per 10,000 crashes also rose, suggesting the improvement in raw counts is explained by fewer total crashes rather than crashes becoming less harmful.

Taken together, Road to Zero has not yet delivered measurable improvements in crash severity. This analysis covers only the first four years post-launch — longer-term data may reveal a clearer trend.

### Bonus — Road to Zero by Road Type

Breaking the analysis down by road type shows the worsening severity trend holds across both city streets and highways, suggesting road type had no moderating effect on policy outcomes.

On **city streets**, the fatality rate rose sharply from 44.17 to 58.62 deaths per 10,000 crashes — a 33% increase. On **highways**, the increase was more modest, from 221.15 to 229.75. Notably, highways are consistently ~4x more dangerous than city streets on a per-crash basis, reflecting the higher speeds involved. The post-policy deterioration in severity on both road types reinforces the Q5 conclusion.

---

## Caveats & Limitations

- Analysis is restricted to 2015–2024. The full CAS dataset runs from 2000 to present.
- Per-capita figures use 2023 Stats NZ population estimates applied across 2020–2024. Regional populations shifted modestly over this period, so figures are indicative rather than exact.
- Relative risk in Q4 indicates correlation, not causation.
- The Road to Zero evaluation (Q5) covers only four post-launch years. Policy effects often take longer to materialise.
- 2020 was excluded from the Road to Zero comparison due to COVID-19 lockdowns significantly reducing traffic volumes.

---

## Data Notes

**CAS data:** Downloaded directly from the Waka Kotahi open data portal as a CSV (~400–600 MB). See `download_data.sh`.

**Stats NZ population data:** Downloaded from Stats NZ as an Excel file. The relevant sheet (regional population by year) was manually extracted and saved as `data/statsnz_regional_population.csv` with the following columns:
```
Region, population_2018, population_2023, population_2024, population_2025
```
Population figures use comma-formatted numbers (e.g. 198,500) which are handled in the SQL loading step.

---

## Author

Lam Truong | truongtrienlam1997@gmail.com
GitHub: https://github.com/Lam-Truong
