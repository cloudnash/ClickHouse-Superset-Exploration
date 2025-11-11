

# Install virtualenv if not already installed
sudo apt install python3-venv

# Create a new virtual environment for Superset
python3 -m venv superset-env

# Activate the virtual environment
source superset-env/bin/activate


# Update pip to the latest version
pip install --upgrade pip

# Install essential dependencies
pip install wheel
pip install setuptools


# Install Apache Superset
pip install apache-superset


# Install a specific version of Superset
pip install apache-superset==5.0.0
# Install ClickHouse SQLAlchemy connector
pip install clickhouse-sqlalchemy

# Install SQLAlchemy (if there’s a mismatch or version issue)
pip install sqlalchemy==1.4.54  # Downgrade SQLAlchemy to 1.4.x if needed
# Initialize the Superset metadata database
superset db upgrade

# Load sample data (optional)
superset load_examples


# Start the Superset server
superset run -h 0.0.0.0 -p 8088 --with-threads --reload --debugger


pip check
# Install compatible SQLAlchemy version
pip install sqlalchemy==1.4.54


clickhouse+native://default:@localhost:9000/demo








