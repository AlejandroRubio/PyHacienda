/*
Consulta para el 2 bloque: Rendimientos de cuentas bancarias
*/
SELECT *
FROM RENTA_25.gold.rendimientos_cuentas_bancarias
order by rendimientos_dinerarios desc

/*
Detalle de todas las operaciones
*/

select *
--sum(cantidad)
from [CONTABILIDAD_2025].dbo.detalle_operaciones
where categoria in ('Remuneración cuentas', 'Promos bancos')
--and cuenta='openbank' 
order by cuenta


