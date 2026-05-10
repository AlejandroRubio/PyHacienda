import os

# Años
ANIO_VIEJO = "24"
ANIO_NUEVO = "25"

# Rutas
SQL_SCRIPTS_DIR = os.getenv("SQL_SCRIPTS_DIR", "C:/Labs/PyHacienda/sql_scripts")

# Base de datos
DB_DRIVER = os.getenv("DB_DRIVER", "ODBC Driver 17 for SQL Server")
DB_SERVER = os.getenv("DB_SERVER", r"AlexPC\SQLEXPRESS")
DB_NAME = os.getenv("DB_NAME", f"RENTA_{ANIO_NUEVO}")

CONN_STR = (
    f"DRIVER={{{DB_DRIVER}}};"
    f"SERVER={DB_SERVER};"
    f"DATABASE={DB_NAME};"
    "Trusted_Connection=yes;"
)

# Tablas
TABLA_EXCHANGE_RATES = "silver.tipos_cambio"

# BCE
ECB_HIST_ZIP_URL = "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist.zip"
