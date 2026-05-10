import os
import re
import pyodbc
from cargar_tipos_cambio import cargar_tipos_cambio
from parametrizacion import ANIO_VIEJO, ANIO_NUEVO, SQL_SCRIPTS_DIR, CONN_STR


def cambiar_ano_scripts_base():
    for root, dirs, files in os.walk(SQL_SCRIPTS_DIR):
        for file in files:
            print(f"Procesando fichero: {file}")
            if file.endswith(".sql"):
                ruta_archivo = os.path.join(root, file)

                with open(ruta_archivo, "r", encoding="utf-16le") as f:
                    contenido = f.read()

                contenido_nuevo = contenido.replace(ANIO_VIEJO, ANIO_NUEVO)

                with open(ruta_archivo, "w", encoding="utf-16le") as f:
                    f.write(contenido_nuevo)

                print(f"Actualizado: {ruta_archivo}")


def leer_archivo(ruta):
    for encoding in ("utf-8-sig", "utf-16", "utf-16-le", "utf-16-be", "latin-1"):
        try:
            with open(ruta, "r", encoding=encoding) as f:
                content = f.read()
            if "\x00" not in content:
                return content
        except UnicodeDecodeError:
            continue
    raise ValueError(f"No se pudo leer el archivo: {ruta}")


def dividir_por_go(sql):
    # SQL Server usa GO como separador de batch, pero pyodbc no lo entiende directamente
    return [
        bloque.strip()
        for bloque in re.split(r"^\s*GO\s*;?\s*$", sql, flags=re.IGNORECASE | re.MULTILINE)
        if bloque.strip()
    ]


def ejecutar_scripts_sql_server(directorio):
    archivos_sql = []

    directorio = directorio + "creacion"

    for root, _, files in os.walk(directorio):
        for file in files:
            if file.lower().endswith(".sql"):
                archivos_sql.append(os.path.join(root, file))

    archivos_sql.sort()

    with pyodbc.connect(CONN_STR, autocommit=False) as conn:
        cursor = conn.cursor()

        for ruta in archivos_sql:
            print(f"Ejecutando: {ruta}")

            sql = leer_archivo(ruta)
            bloques = dividir_por_go(sql)

            try:
                for bloque in bloques:
                    cursor.execute(bloque)

                conn.commit()
                print(f"OK: {ruta}")

            except Exception as e:
                conn.rollback()
                print(f"ERROR en: {ruta}")
                print(e)
                raise


if __name__ == "__main__":
    # Paso 1: Cambiar año de los ficheros SQL
    #cambiar_ano_scripts_base()

    # Paso 2: Ejecución de los ficheros SQL
    ejecutar_scripts_sql_server(SQL_SCRIPTS_DIR)

    # Paso 3: Carga de tipos de cambio del año en curso
    cargar_tipos_cambio(int(f"20{ANIO_NUEVO}"))
