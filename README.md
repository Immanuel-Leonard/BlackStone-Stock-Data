# Blackstone (BX) — Fundamentals and Price Data Pipeline

An end-to-end pipeline that pulls Blackstone's stock price history and annual
financial statements from the Alpha Vantage API, loads them into a PostgreSQL
database (Supabase), and stages them for analysis.

**Question:** What does Blackstone's balance sheet look like across annual
reports, and how has the share price moved over the same period?

## Architecture

    Alpha Vantage API  →  extract / load  →  PostgreSQL (Supabase)  →  analysis
       (REST, JSON)        (Python,            (bx_db)                 (SQL)
                            psycopg2)

This is the part of the project worth leading with: it is an ELT-shaped pipeline
with a real relational schema, not a notebook that reads a CSV.

## Endpoints pulled

| Alpha Vantage function | Table | Grain |
|---|---|---|
| `OVERVIEW` | — (company profile) | One row per company |
| `INCOME_STATEMENT` | — (staged) | One row per fiscal year |
| `BALANCE_SHEET` | `balance_sheet` | One row per fiscal year |
| `CASH_FLOW` | — (staged) | One row per fiscal year |
| `EARNINGS` | — (staged) | One row per fiscal quarter |
| `SPLITS` | — (staged) | One row per split event |
| `TIME_SERIES_DAILY` | `time_series_daily` | One row per trading day |
| `TIME_SERIES_WEEKLY` | `time_series_weekly` | One row per week |

The `balance_sheet` table models 37 line items (assets, liabilities, equity)
matching Alpha Vantage's annual-report field set.

## Schema

See `schema.sql`.

- `balance_sheet` — one row per fiscal year, 37 columns
- `time_series_daily` — OHLCV by trading day
- `time_series_weekly` — OHLCV by week

Prices are stored as `NUMERIC(12,4)`, not `INT`, so cents are preserved — the
API returns strings like `"147.25"` and integer columns would round them away.

## Setup

Secrets are supplied at runtime and never stored in the notebook. In Google
Colab, add these to the Secrets panel (key icon) with notebook access enabled:

`DB_USER`, `DB_PASSWORD`, `DB_HOST`, `DB_PORT`, `DB_NAME`,
`ALPHAVANTAGE_API_KEY`, and the eight pre-built request URLs
(`FUNDAMENTAL_URL`, `INCOME_URL`, `CASH_FLOW_URL`, `EARNINGS`, `SPLITS`,
`BALANCE_SHEET`, `TSD`, `TSW`).

Then run the notebook top to bottom. For a local run:

    pip install -r requirements.txt
    psql -f schema.sql
    export ALPHAVANTAGE_API_KEY=your_key_here
    export DATABASE_URL=postgresql://user:password@host:5432/bx_db
    python src/load_blackstone.py

Nothing is hardcoded. The connection is built from environment variables and
the run stops immediately if any of them is missing.

## Queries

`queries/` holds the analytical SQL, including a year-over-year change query
using the `LAG` window function over fiscal years.

## Known limitations

- Alpha Vantage's free tier caps requests per minute, so the loader backs off
  between calls rather than firing them in a burst.
- Balance-sheet figures arrive as strings and are cast explicitly to numeric
  types rather than relying on Postgres coercion.
- Only one symbol (BX) is configured. The loader takes the symbol as an
  argument, so extending it to a watchlist is a small change.
- No incremental load logic yet — a re-run reloads the full history.
- The staged endpoints (`INCOME_STATEMENT`, `CASH_FLOW`, `EARNINGS`, `SPLITS`)
  are fetched and printed but not yet persisted to tables.

## What I would do next

Persist the remaining statement endpoints, add incremental loading keyed on
date, move the transformations into dbt models so the SQL is tested and
documented, and schedule the load.

---

**Skills demonstrated:** Python · REST API integration · psycopg2 ·
PostgreSQL schema design · window functions · environment-based secrets



