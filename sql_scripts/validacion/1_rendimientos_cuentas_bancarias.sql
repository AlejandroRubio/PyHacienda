SELECT *
FROM RENTA_25.gold.2_rendimientos_cuentas_bancarias.
order by rendimientos_dinerarios desc


select *
--sum(cantidad)
from [CONTABILIDAD_2025].dbo.detalle_operaciones
where cuenta='openbank' and categoria in ('Remuneraci�n cuentas', 'Promos bancos')
