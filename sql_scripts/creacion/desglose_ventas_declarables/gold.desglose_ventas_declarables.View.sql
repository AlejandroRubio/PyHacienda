USE [RENTA_25]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [gold].[desglose_ventas_declarables]
AS
    SELECT
        fecha_venta,
		nombre_articulo,
		importe_compra,
		importe_venta,
		importe_beneficio,
		ROUND(importe_beneficio * 0.19, 2) AS beneficio_retencion
	from [silver].[desglose_ventas_declarables]

GO
