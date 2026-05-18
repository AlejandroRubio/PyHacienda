USE [RENTA_25];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
SET XACT_ABORT ON;
GO

IF SCHEMA_ID(N'silver') IS NULL
BEGIN
    EXEC(N'CREATE SCHEMA [silver] AUTHORIZATION [dbo];');
END;
GO

IF OBJECT_ID(N'[silver].[tipos_cambio]', N'U') IS NULL
BEGIN
    CREATE TABLE [silver].[tipos_cambio]
    (
        [divisa]       VARCHAR(3)       NOT NULL,
        [fecha]        DATE             NOT NULL,
        [cotizacion]   DECIMAL(19, 8)   NOT NULL,

        [fecha_carga]  DATETIME2(0)     NOT NULL
            CONSTRAINT [df_tipos_cambio_fecha_carga]
            DEFAULT (SYSUTCDATETIME()),

        CONSTRAINT [pk_tipos_cambio]
            PRIMARY KEY CLUSTERED ([divisa], [fecha]),

        CONSTRAINT [ck_tipos_cambio_divisa_longitud]
            CHECK (LEN([divisa]) = 3),

        CONSTRAINT [ck_tipos_cambio_cotizacion_positiva]
            CHECK ([cotizacion] > 0)
    );
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'ix_tipos_cambio_fecha'
      AND object_id = OBJECT_ID(N'[silver].[tipos_cambio]', N'U')
)
BEGIN
    CREATE NONCLUSTERED INDEX [ix_tipos_cambio_fecha]
        ON [silver].[tipos_cambio] ([fecha])
        INCLUDE ([divisa], [cotizacion]);
END;
GO
