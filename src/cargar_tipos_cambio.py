import csv
import io
import zipfile
from datetime import datetime
import requests
import pyodbc


from parametrizacion import ECB_HIST_ZIP_URL, CONN_STR, TABLA_EXCHANGE_RATES


def descargar_csv_bce():
    response = requests.get(ECB_HIST_ZIP_URL, timeout=30)
    response.raise_for_status()

    with zipfile.ZipFile(io.BytesIO(response.content)) as z:
        csv_name = z.namelist()[0]
        with z.open(csv_name) as f:
            return f.read().decode("utf-8")


def cargar_tipos_cambio(anio: int):
    csv_text = descargar_csv_bce()
    print("Descarga correcta desde BCE")

    reader = csv.DictReader(io.StringIO(csv_text))
    registros = []

    for row in reader:
        fecha = datetime.strptime(row["Date"], "%Y-%m-%d")

        if fecha.year != anio:
            continue

        for divisa in ("USD", "GBP"):
            valor_bce = row.get(divisa)

            if not valor_bce:
                continue

            cotizacion_eur = float(valor_bce)

            registros.append((divisa, fecha, cotizacion_eur, datetime.now()))

    if not registros:
        print(f"No se encontraron datos para el año {anio}")
        return

    with pyodbc.connect(CONN_STR) as conn:
        cursor = conn.cursor()

        cursor.fast_executemany = True

        cursor.executemany(
            f"""
            INSERT INTO {TABLA_EXCHANGE_RATES} (Divisa, Fecha, Cotizacion, FechaCarga)
            VALUES (?, ?, ?, ?)
            """,
            registros
        )

        conn.commit()

    print(f"Insertados {len(registros)} registros para el año {anio}")


