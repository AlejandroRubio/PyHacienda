USE [RENTA_25]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [silver].[desglose_ventas_declarables]
AS
SELECT 
	fecha_venta,
	id_mw,
	nombre_articulo,
	subnombre_articulo,
	importe_venta,
	importe_compra,
	importe_envio,
	importe_beneficio,
	cuenta
FROM [bronze].[desglose_ventas_declarables]
where venta_atraves_wallapay='S'