#!/bin/bash
# Install ClickHouse
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E0C56BD4
sudo apt-get install clickhouse-server clickhouse-client -y
sudo service clickhouse-server start

# Create sample table
clickhouse-client --query="
CREATE TABLE IF NOT EXISTS web_logs (
  ts DateTime,
  user_id UInt32,
  url String,
  bytes UInt32,
  status UInt16
) ENGINE = MergeTree()
ORDER BY ts;"

# Insert sample data
clickhouse-client --query="
INSERT INTO web_logs (ts, user_id, url, bytes, status) VALUES
(now(), 101, '/home', 1024, 200),
(now()-3600, 101, '/product', 2048, 200),
(now()-7200, 102, '/cart', 512, 500),
(now()-10000, 103, '/checkout', 4096, 302);"

# Start Superset
source superset-env/bin/activate
superset db upgrade
superset fab create-admin --username admin --firstname Admin --lastname User --email admin@example.com --password admin
superset run -h 0.0.0.0 -p 8088 --with-threads --reload --debugger
