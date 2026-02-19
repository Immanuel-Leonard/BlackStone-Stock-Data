CREATE DATABASE bx_db;

CREATE TABLE balance_sheet(
    fiscal_date_ending DATE,
    reported_currency varchar(1),
    total_assets int,
    total_current_assets int,
    cash_and_cash_equivalents_at_carrying_value int,
    cash_and_short_term_investments int,
    inventory int,
    current_net_receivables int,
    total_non_current_assets int,
    property_plant_equipment int,
    accumalate_depreciation_amortization_ppe int,
    intangible_assets int,
    intangible_assets_excluding_good_will int,
    good_will int,
    investments int,
    longterm_investments int,
    short_term_investments int,
    other_current_assets int,
    other_non_current_assets int,
    total_liabilities int,
    total_current_liabilites int,
    current_accounts_payable int,
    deferred_revenue int,
    current_debt int,
    short_term_debt int,
    total_non_current_liabilites int,
    capital_lease_obligations int,
    long_term_debt int,
    current_long_term_debt int,
    long_term_debt_non int,
    short_long_term_debt_total int,
    other_current_liabilities int,
    other_noncurrent_liabilities int,
    total_share_equity int,
    treasury_stock int,
    retained_earnings int,
    common_stock int,
    common_stock_shares_outstanding int

);
CREATE TABLE time_series_daily(
      information varchar(1),
      day Date,
      open int,
      high int,
      low int,
      close int,
      volume int
);

CREATE TABLE time_series_weekly(
      information varchar(1),
      day Date,
      open int,
      high int,
      low int,
      close int,
      volume int

);