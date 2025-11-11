# ClickHouse-Superset-Exploration

Title: ClickHouse + Superset Exploration
Date: 11-11-2025

## Overview
This project demonstrates an end-to-end exploration of **ClickHouse** (for high-performance data storage and querying) and **Apache Superset** (for data visualization and dashboards).  
Due to resource constraints, lightweight Python-based visualizations using **Pandas** and **Matplotlib** were also implemented as an alternative visualization method.

Environment:
- EC2: Ubuntu 22.04, t3.medium
- ClickHouse: installed from official repo
- Superset: installed in Python venv (apache-superset)

Steps performed:
1. Launched EC2 and opened ports 22, 8088, 8123, 9000.
2. Installed ClickHouse server & client, created database `demo`, created tables `web_logs` & `web_logs_compressed`.
3. Inserted sample rows; executed SELECT, GROUP BY queries.
4. Demonstrated compression with `CODEC(ZSTD(3))` and ran `OPTIMIZE TABLE FINAL`.
5. Installed Superset, created admin user, started Superset service.
6. Connected Superset to ClickHouse via SQLAlchemy URI `clickhouse+http://default:@<host>:8123/demo`
7. Created two charts (Bar and Line) and combined them into a dashboard.

## Project Structure

```

clickhouse-superset-exploration/
│
├── README.md
├── setup/
│ ├── setup_clickhouse_superset.sh
│ ├── clickhouse_queries.sql
│ ├── superset_connection_guide.txt
│
├── screenshots/
│ ├── clickhouse_table.png
│ ├── clickhouse_query_result.png
│ ├── superset_connection.png
│ ├── superset_bar_chart.png
│ ├── superset_line_chart.png
│ └── superset_dashboard.png
│
└── report/
└── ClickHouse_Superset_Report.md

```
## ⚙️ Setup Steps

### 1️⃣ Launch EC2 and install dependencies

```
sudo apt update
sudo apt install -y python3 python3-venv python3-pip clickhouse-server clickhouse-client
sudo systemctl start clickhouse-server

clickhouse-client


CREATE TABLE web_logs
(
    ts DateTime,
    user_id UInt32,
    url String,
    bytes UInt32,
    status UInt16
)
ENGINE = MergeTree()
ORDER BY ts;

INSERT INTO web_logs VALUES
(now(), 101, '/home', 1024, 200),
(now()-3600, 101, '/product', 2048, 200),
(now()-7200, 102, '/cart', 512, 500),
(now()-10000, 103, '/checkout', 4096, 302);

SELECT * FROM web_logs;

```

## ClickHouse Exploration

- Features explored
- Table creation and insertion
- Basic querying (SELECT, COUNT, GROUP BY)
- Performance-oriented features like MergeTree engine
- Data compression and optimization concepts


Challenges & how I overcame them:
- Common issue: missing ClickHouse driver for SQLAlchemy. Fixed by installing `clickhouse-driver` & `clickhouse-sqlalchemy` into the same Python env as Superset.
- Superset may fail if system packages missing (wheel/build tools). Resolved by installing `build-essential`, `python3-dev`, `libssl-dev`, `libffi-dev`.
- If the Superset server binds to 127.0.0.1 only, use `--host 0.0.0.0` with `superset run` or ensure security groups allow access.
- pandas failed to build from source. Resolved by installing `python3-dev libatlas-base-dev libopenblas-dev liblapack-dev gfortran`

Overall impressions:
- ClickHouse: extremely fast for analytical queries; straightforward to experiment with codecs and MergeTree settings.
- Superset: good low-code visualization layer; simple to connect to ClickHouse once drivers are installed. UI is feature-rich but can be sensitive to environment mismatches (Python deps).
