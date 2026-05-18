USE [RENTA_25]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [bronze].[desglose_ventas_declarables]
AS
    SELECT
        fecha AS fecha_venta,
        ventas.id_operacion_venta AS id_mw,
        nombre_articulo,
        subnombre_articulo,
        importe_venta,
        importe_compra,
        importe_envio,
        round(importe_beneficio,2) as importe_beneficio,
        cuentas.nombre AS cuenta,
        CASE
            WHEN importe_compra = 0 THEN 10
            ELSE ROUND(importe_beneficio / importe_compra, 2)
        END AS rentabilidad,
        unidades
    FROM [contabilidad_2025].dbo.ventas ventas
    INNER JOIN [contabilidad_2025].dbo.cuentas cuentas
        ON cuentas.id_mw = ventas.id_cuenta_venta_mw
    INNER JOIN [contabilidad_2025].dbo.categorias categorias
        ON categorias.id_mw = ventas.id_categoria_venta_mw

GO
