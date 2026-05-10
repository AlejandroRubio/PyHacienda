USE [RENTA_25];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER VIEW [silver].[ventas_activos_financieros]
AS
WITH ventas AS
(
    SELECT
          codigo = CONCAT(
                'TV',
                RIGHT(
                    CONCAT(
                        '0000',
                        ROW_NUMBER() OVER (
                            ORDER BY fecha_venta, id
                        )
                    ),
                    4
                )
            )

        , nif_emisor = CAST('' AS VARCHAR(20))
        , nombre_emisor = accion
        , nif_declarante = CAST('' AS VARCHAR(20))
        , nombre_declarante = broker
        , fecha_operacion = fecha_venta

        -- Valores fijos para mercado español y acciones
        , clave_mercado = CAST('Secundario Oficial Val. Español' AS VARCHAR(100))
        , valor = CAST('Acciones' AS VARCHAR(50))
        , titulares = CAST(1 AS INT)

        , importe_venta = CAST(
              ROUND(
                  ISNULL(numero_acciones_venta, 0)
                  * ISNULL(valor_accion_venta, 0),
                  2
              ) AS DECIMAL(18,2)
          )

        , comision_venta = CAST(comision_venta AS DECIMAL(18,2))

        , comision_compra_ajustada =
            CAST(
                CASE
                    WHEN numero_acciones_compra IS NULL
                      OR numero_acciones_compra = 0
                      OR numero_acciones_venta IS NULL
                      OR comision_compra IS NULL
                    THEN NULL
                    ELSE
                        comision_compra
                        * CAST(numero_acciones_venta AS DECIMAL(18,6))
                        / CAST(numero_acciones_compra AS DECIMAL(18,6))
                END
            AS DECIMAL(18,2))

    FROM [bronze].[ventas_activos_financieros]
)
SELECT
      codigo
    , nif_emisor
    , nombre_emisor
    , nif_declarante
    , nombre_declarante
    , fecha_operacion
    , clave_mercado
    , valor
    , titulares
    , importe_venta
    , comision_venta
    , comision_compra_ajustada
FROM ventas;
GO