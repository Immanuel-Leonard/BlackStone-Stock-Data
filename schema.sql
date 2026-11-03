-- Blackstone (BX) fundamentals and price data
-- Run against a fresh database: psql -f schema.sql
--
-- No CREATE DATABASE statement here: the database is created by the platform
-- (Supabase) or by the user before this file runs. Including it made the
-- original file unrunnable as a script and put a semicolon in its filename.

CREATE TABLE balance_sheet (
    fiscal_date_ending  DATE PRIMARY KEY,
    reported_currency   VARCHAR(3),
    total_assets        NUMERIC,
    total_current_assets NUMERIC,
    cash_and_cash_equivalents_at_carrying_value NUMERIC,
    cash_and_short_term_investments NUMERIC,
    inventory           NUMERIC,
    current_net_receivables NUMERIC,
    total_non_current_assets NUMERIC,
    property_plant_equipment NUMERIC,
    accumalate_depreciation_amortization_ppe NUMERIC,
    intangible_assets   NUMERIC,
    intangible_assets_excluding_good_will NUMERIC,
    good_will           NUMERIC,
    investments         NUMERIC,
    longterm_investments NUMERIC,
    short_term_investments NUMERIC,
    other_current_assets NUMERIC,
    other_non_current_assets NUMERIC,
    total_liabilities   NUMERIC,
    total_current_liabilites NUMERIC,
    current_accounts_payable NUMERIC,
    deferred_revenue    NUMERIC,
    current_debt        NUMERIC,
    short_term_debt     NUMERIC,
    total_non_current_liabilites NUMERIC,
    capital_lease_obligations NUMERIC,
    long_term_debt      NUMERIC,
    current_long_term_debt NUMERIC,
    long_term_debt_non  NUMERIC,
    short_long_term_debt_total NUMERIC,
    other_current_liabilities NUMERIC,
    other_noncurrent_liabilities NUMERIC,
    total_share_equity  NUMERIC,
    treasury_stock      NUMERIC,
    retained_earnings   NUMERIC,
    common_stock        NUMERIC,
    common_stock_shares_outstanding NUMERIC
);

-- OHLCV: prices are NUMERIC, not INT, so cents are not truncated.
CREATE TABLE time_series_daily (
    day     DATE PRIMARY KEY,
    open    NUMERIC(12, 4),
    high    NUMERIC(12, 4),
    low     NUMERIC(12, 4),
    close   NUMERIC(12, 4),
    volume  BIGINT
);

CREATE TABLE time_series_weekly (
    day     DATE PRIMARY KEY,
    open    NUMERIC(12, 4),
    high    NUMERIC(12, 4),
    low     NUMERIC(12, 4),
    close   NUMERIC(12, 4),
    volume  BIGINT
);

CREATE INDEX idx_balance_sheet_fiscal_year
    ON balance_sheet (fiscal_date_ending DESC);
