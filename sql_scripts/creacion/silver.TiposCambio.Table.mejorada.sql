USE [RENTA_25];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
SET XACT_ABORT ON;
GO

/*
    Tabla: [silver].[TiposCambio]
    Propósito: almacenar cotizaciones de divisas normalizadas por fecha.

    Cambios frente al script original:
    - Usa schema [silver] para encajar con arquitectura medallion.
    - Evita FLOAT para importes/cotizaciones; usa DECIMAL para mayor precisión.
    - Fecha pasa de DATETIME a DATE, asumiendo cotización diaria.
    - Campos clave NOT NULL.
    - Clave primaria compuesta por Divisa + Fecha.
    - Constraints básicas de calidad.
    - Metadatos de carga para trazabilidad.
    - Script idempotente: no falla si el schema o la tabla ya existen.
*/

IF SCHEMA_ID(N'silver') IS NULL
BEGIN
    EXEC(N'CREATE SCHEMA [silver] AUTHORIZATION [dbo];');
END;
GO

IF OBJECT_ID(N'[silver].[TiposCambio]', N'U') IS NULL
BEGIN
    CREATE TABLE [silver].[TiposCambio]
    (
        [Divisa]       VARCHAR(3)       NOT NULL,
        [Fecha]        DATE             NOT NULL,
        [Cotizacion]   DECIMAL(19, 8)   NOT NULL,

        [FechaCarga]   DATETIME2(0)     NOT NULL
            CONSTRAINT [DF_TiposCambio_FechaCarga]
            DEFAULT (SYSUTCDATETIME()),


        CONSTRAINT [PK_TiposCambio]
            PRIMARY KEY CLUSTERED ([Divisa], [Fecha]),

        CONSTRAINT [CK_TiposCambio_Divisa_Longitud]
            CHECK (LEN([Divisa]) = 3),

        CONSTRAINT [CK_TiposCambio_Cotizacion_Positiva]
            CHECK ([Cotizacion] > 0)
    );
END;
GO

/*
    Índice opcional útil si consultas mucho por fecha, por ejemplo:
    WHERE Fecha BETWEEN ... AND ...
*/
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_TiposCambio_Fecha'
      AND object_id = OBJECT_ID(N'[silver].[TiposCambio]', N'U')
)
BEGIN
    CREATE NONCLUSTERED INDEX [IX_TiposCambio_Fecha]
        ON [silver].[TiposCambio] ([Fecha])
        INCLUDE ([Divisa], [Cotizacion]);
END;
GO
