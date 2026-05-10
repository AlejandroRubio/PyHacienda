USE [RENTA_25]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [bronze].[ventas_activos_financieros]
as
select 
	v.id,
	v.accion,
	c.fecha as fecha_compra,
	v.fecha as fecha_venta,
	c.numero_acciones as numero_acciones_compra,
	v.numero_acciones as numero_acciones_venta,
	c.comision as comision_compra,
	v.comision as comision_venta,
	c.valor_accion as valor_accion_compra,
	v.valor_accion as valor_accion_venta,
	v.broker
from [INFO_BURSATIL].dbo.acciones_ventas v
inner join [INFO_BURSATIL].dbo.acciones_compras c
	on v.id = c.id
where year(v.fecha) = 2025