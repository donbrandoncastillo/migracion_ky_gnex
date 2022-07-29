-- 8. cliente domicilo.sql
set @TIPO_DOMICILIO_FISCAL = 311;
set @its_all_ok = true;

delete from a24_ky_dev.cliente_domicilio where @its_all_ok;
ALTER TABLE a24_ky_dev.cliente_domicilio AUTO_INCREMENT = 1;

INSERT INTO a24_ky_dev.cliente_domicilio (
	cliente_id,almacen,tipo_domicilio_id,calle,numero_exterior,numero_interior,colonia,codigo_postal,ciudad,pais_id,municipio_id,estado_id,codigo_fabricante,activo
)
select
cliente_dev.id																				as cliente_id
, cliente_domicilio_prod.nombre												as almacen
, @TIPO_DOMICILIO_FISCAL															AS tipo_domicilio_id
, cliente_domicilio_prod.calle
, cliente_domicilio_prod.numero_exterior
, cliente_domicilio_prod.numero_interior
, cliente_domicilio_prod.colonia
, cliente_domicilio_prod.codigo_postal
, cliente_domicilio_prod.ciudad
, cliente_domicilio_prod.pais_id
, cliente_domicilio_prod.municipio_id
, cliente_domicilio_prod.estado_id
, cliente_domicilio_prod.codigo_fabricante
, cliente_domicilio_prod.activo
from a24_ky_prod.cliente_domicilio 								cliente_domicilio_prod
left join a24_ky_prod.cliente											cliente_prod							ON	cliente_prod.id 					=	cliente_domicilio_prod.cliente_id
left join a24_ky_dev.cliente											cliente_dev								ON	cliente_dev.razon_social	=	cliente_prod.razon_social		
where @its_all_ok;


