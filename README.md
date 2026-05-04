# 🏛️ PyHacienda

<p align="center">
  <img src="img/logo.png" alt="PyHacienda logo" width="800"/>
</p>

> Automatización de reportes fiscales para la declaración de la renta española.  
> Olvídate de copiar celdas de Excel a mano — PyHacienda lo hace por ti.

---

## ¿Qué es esto?

PyHacienda es un conjunto de scripts Python que consolida datos financieros dispersos (dividendos, intereses bancarios, ventas de marketplace) y los transforma en vistas SQL listas para la declaración de la renta. También descarga automáticamente los tipos de cambio históricos del **Banco Central Europeo** para convertir posiciones en USD y GBP a euros.

```
BCE (tipos de cambio) ──────────────────────────────────────┐
                                                             ▼
INFO_BURSATIL (dividendos) ──────┐               ┌─ silver.TiposCambio
contabilidad_XXXX (ventas) ──────┼──▶  SQL Views ─┤
cuentas bancarias (intereses) ───┘               └─ Reportes declarables
```

---

## 📁 Estructura del proyecto

```
PyHacienda/
├── requirements.txt
└── src/
    ├── app.py                   # Orquestador principal
    ├── cargar_tipos_cambio.py   # Descarga BCE e inserta tipos de cambio
    ├── parametrizacion.py       # Configuración centralizada
    └── sql_scripts/
        ├── dbo.ExchangeRates.Table.sql
        ├── dbo.desglose_ventas_declarables.View.sql
        ├── dbo.dividendos_en_extranjero.View.sql
        ├── dbo.dividendos_españoles_no_incorporados.View.sql
        ├── dbo.dividendos_ya_declarados.View.sql
        ├── dbo.oro_dividendos_*.View.sql
        └── dbo.rendimientos_cuentas_bancarias.View.sql
```

---

## ⚙️ Componentes

### `app.py` — El orquestador

Ejecuta el flujo completo en tres pasos:

| Paso | Qué hace |
|------|----------|
| **1** | Actualiza el año en todos los scripts `.sql` (p.ej. `24` → `25`) |
| **2** | Ejecuta los scripts SQL contra SQL Server, creando tablas y vistas |
| **3** | Llama a `cargar_tipos_cambio` para poblar los tipos de cambio del año |

### `cargar_tipos_cambio.py` — Tipos de cambio desde el BCE

Descarga el histórico completo de tipos de cambio publicado por el Banco Central Europeo, filtra por el año indicado y lo carga en la tabla `silver.TiposCambio`.

- Soporta divisas: **USD**, **GBP**
- Los valores se almacenan tal como los publica el BCE: `1 EUR = X divisa`
- Registra la fecha y hora de carga en la columna `FechaCarga`

### `parametrizacion.py` — Configuración centralizada

Toda la configuración en un único sitio. Los valores se pueden sobreescribir con variables de entorno:

| Variable de entorno | Por defecto | Descripción |
|---|---|---|
| `DB_DRIVER` | `ODBC Driver 17 for SQL Server` | Driver ODBC |
| `DB_SERVER` | `AlexPC\SQLEXPRESS` | Servidor SQL Server |
| `DB_NAME` | `RENTA_25` | Base de datos destino |
| `SQL_SCRIPTS_DIR` | `C:/Labs/PyHacienda/sql_scripts` | Carpeta de scripts SQL |

### `sql_scripts/` — Las vistas fiscales

Cada vista transforma datos brutos en conceptos fiscales listos para rellenar en el modelo:

| Vista | Qué calcula |
|---|---|
| `dividendos_en_extranjero` | Dividendos de brokers internacionales (IB), convierte USD→EUR |
| `dividendos_españoles_no_incorporados` | Dividendos españoles aún no declarados |
| `dividendos_ya_declarados` | Unión de dividendos ya incorporados en declaraciones anteriores |
| `desglose_ventas_declarables` | Ventas de marketplace con retención del 19% |
| `rendimientos_cuentas_bancarias` | Intereses bancarios (cuentas corrientes e imposiciones a plazo) |
| `oro_dividendos_*` | Versiones formateadas de las anteriores, listas para copiar |

---

## 🚀 Uso

### Requisitos previos

- Python 3.10+
- SQL Server con ODBC Driver 17
- Acceso de escritura a la base de datos `RENTA_XX`

### Instalación

```bash
pip install -r requirements.txt
```

### Ejecución completa

```bash
cd src
python app.py
```

Esto ejecuta los tres pasos en orden: actualización de año → DDL → tipos de cambio.

### Solo tipos de cambio (un año concreto)

Si solo necesitas recargar los tipos de cambio sin tocar el esquema:

```python
from cargar_tipos_cambio import cargar_tipos_cambio
cargar_tipos_cambio(2025)
```

### Configuración para otro entorno

```bash
export DB_SERVER="OtroServidor\SQLEXPRESS"
export DB_NAME="RENTA_26"
python app.py
```

---

## 🗄️ Base de datos

PyHacienda trabaja contra tres bases de datos en SQL Server:

| Base de datos | Rol |
|---|---|
| `RENTA_XX` | BD principal: tablas de soporte y vistas de reporting |
| `INFO_BURSATIL` | Fuente de datos de inversión (dividendos, posiciones) |
| `contabilidad_XXXX` | Fuente de datos contables (ventas, rendimientos bancarios) |

---

## 🔧 Stack técnico

| Componente | Tecnología |
|---|---|
| Lenguaje | Python 3.10+ |
| Base de datos | SQL Server (ODBC Driver 17) |
| Tipos de cambio | [BCE eurofxref-hist](https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist.zip) |
| Dependencias | `pyodbc`, `requests` |
