# ClickHouse and Superset Exploration Report

## Objective
Explore ClickHouse database and create visualizations in Superset.

## Steps Followed
1. Set up ClickHouse server and created the `web_logs` table.
2. Inserted sample data into the table.
3. Installed Superset in a virtual environment.
4. Connected Superset to ClickHouse using SQLAlchemy URI.
5. Created datasets and visualizations (bar chart, line chart).
6. Compiled a dashboard combining the charts.

## Challenges Faced
- SQLAlchemy version mismatch causing import errors.
  - Solution: Downgraded SQLAlchemy to 1.4.54.
- Superset not showing ClickHouse in database dropdown.
  - Solution: Installed `clickhouse-sqlalchemy` in the virtual environment.

## Observations
- ClickHouse is very fast for analytical queries.
- Superset allows easy visualization with minimal configuration.

