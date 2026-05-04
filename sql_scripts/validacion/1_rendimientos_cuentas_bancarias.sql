SELECT *
FROM [RENTA_25].[dbo].[rendimientos_cuentas_bancarias]
order by rendimientos_dinerarios desc


select *
--sum(cantidad)
from [CONTABILIDAD_2025].dbo.detalle_operaciones
where cuenta='openbank' and categoria in ('Remuneración cuentas', 'Promos bancos')
