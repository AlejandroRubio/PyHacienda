USE [RENTA_25];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER VIEW [gold].[rendimientos_cuentas_bancarias]
AS
/*
    Vista: [gold].[1_rendimientos_cuentas_bancarias]
    Objetivo: consolidar rendimientos de cuentas bancarias y depósitos,
              calculando importes brutos y retenciones estimadas al 19%.
*/
WITH movimientos AS (
    SELECT
        d.cuenta,
        d.descripcion,
        d.categoria,
        CAST(d.cantidad AS decimal(19, 4)) AS cantidad
    FROM [contabilidad_2025].[dbo].[detalle_operaciones] AS d
),
rendimientos_cuentas AS (
    SELECT
        m.cuenta AS nombre_pagador,
        ROUND(SUM(m.cantidad), 2) AS cantidad_neta,
        CASE
            WHEN m.cuenta = 'Trade Republic' THEN 'Cuenta financiera'
            ELSE 'Cuenta corriente'
        END AS tipo
    FROM movimientos AS m
    WHERE m.categoria IN ('Remuneración cuentas', 'Promos bancos')
      -- Evita promociones de cheques regalo de Openbank/Amazon.
      AND m.descripcion NOT LIKE '%amazon%'
      -- Descarta cuentas no declarables en este bloque.
      AND m.cuenta NOT IN ('Amazon', 'Trade Republic Valores')
      AND m.cuenta NOT LIKE '%urbanitae%'
    GROUP BY
        m.cuenta
),
rendimientos_depositos AS (
    SELECT
        CASE
            WHEN m.descripcion = 'pibank 2023' THEN 'PiBank'
            ELSE ''
        END AS nombre_pagador,
        ROUND(SUM(m.cantidad), 2) AS cantidad_neta,
        'Imposición a plazo' AS tipo
    FROM movimientos AS m
    WHERE m.categoria = 'Remuneración depósito'
      AND m.descripcion <> 'PSOE'
    GROUP BY
        CASE
            WHEN m.descripcion = 'pibank 2023' THEN 'PiBank'
            ELSE ''
        END
),
rendimientos AS (
    SELECT
        nombre_pagador,
        cantidad_neta,
        tipo
    FROM rendimientos_cuentas

    UNION ALL

    SELECT
        nombre_pagador,
        cantidad_neta,
        tipo
    FROM rendimientos_depositos
)
SELECT
    r.nombre_pagador,
    r.cantidad_neta,
    r.tipo,
    ROUND(r.cantidad_neta / 0.81, 2) AS rendimientos_dinerarios, -- cantidad bruta
    ROUND(r.cantidad_neta * 0.19 / 0.81, 2) AS retenciones          -- retenciones ya pagadas
FROM rendimientos AS r;
GO
