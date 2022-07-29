-- 6. parte_costo.sql
set @TIPO_COSTO_ESTANDAR = 364;
set @its_all_ok = true;

delete from a24_ky_dev.parte_costo where @its_all_ok;
ALTER TABLE a24_ky_dev.parte_costo AUTO_INCREMENT = 1;

insert into a24_ky_dev.parte_costo (
	parte_id
	, costo
	, activo
	, fecha_inicial
	, fecha_final
	, materia_prima_originaria
	, materia_prima_no_originaria
	, empaque_originario
	, empaque_no_originario
	, otros_costos_originario
	, otros_costos_no_originario
	, gasto_directo
	, gasto_indirecto
	, compra_nacional
	, opcion_id_tipo_costo
)
SELECT
	parte_dev.id																																			as parte_id
	, if(
			ifnull(parte_costo_prod.materia_prima_no_gravable, 0)  +
			ifnull(parte_costo_prod.materia_prima_gravable, 0) +
			ifnull(parte_costo_prod.empaque_no_gravable, 0) +
			ifnull(parte_costo_prod.empaque_gravable, 0) +
			ifnull(parte_costo_prod.mano_obra_gravable, 0) +
			ifnull(parte_costo_prod.mano_obra_no_gravable, 0) +
			ifnull(parte_costo_prod.gasto_gravable, 0) +
			ifnull(parte_costo_prod.gasto_no_gravable, 0) = 0,
			parte_costo_prod.costo,
			 if(
				ifnull(parte_costo_prod.materia_prima_no_gravable, 0)  +
				ifnull(parte_costo_prod.materia_prima_gravable, 0) +
				ifnull(parte_costo_prod.empaque_no_gravable, 0) +
				ifnull(parte_costo_prod.empaque_gravable, 0) +
				ifnull(parte_costo_prod.mano_obra_gravable, 0) +
				ifnull(parte_costo_prod.mano_obra_no_gravable, 0) +
				ifnull(parte_costo_prod.gasto_gravable, 0) +
				ifnull(parte_costo_prod.gasto_no_gravable, 0) = parte_costo_prod.costo,
				parte_costo_prod.costo,
				ifnull(parte_costo_prod.materia_prima_no_gravable, 0)  +
				ifnull(parte_costo_prod.materia_prima_gravable, 0) +
				ifnull(parte_costo_prod.empaque_no_gravable, 0) +
				ifnull(parte_costo_prod.empaque_gravable, 0) +
				ifnull(parte_costo_prod.mano_obra_gravable, 0) +
				ifnull(parte_costo_prod.mano_obra_no_gravable, 0) +
				ifnull(parte_costo_prod.gasto_gravable, 0) +
				ifnull(parte_costo_prod.gasto_no_gravable, 0)
			)
	) 																																							as costo,
	parte_costo_prod.activo																													as activo,
	ifnull(parte_costo_prod.fecha_vigor, '2015-01-01') 															as fecha_inicial,
	ifnull(parte_costo_prod.fecha_vencimiento, '9999-12-31')												as fecha_final
	, ifnull(parte_costo_prod.materia_prima_no_gravable, 0)													as materia_prima_originaria
	, ifnull(parte_costo_prod.materia_prima_gravable, 0) 														as materia_prima_no_originaria
	, ifnull(parte_costo_prod.empaque_no_gravable, 0)																as empaque_originario
	, ifnull(parte_costo_prod.empaque_gravable, 0)																	as empaque_no_originario
	, 0																									 														as otros_costos_originario
	, 0																																							as otros_costos_no_originario
	, (
		ifnull(parte_costo_prod.mano_obra_gravable, 0) +
		ifnull(parte_costo_prod.mano_obra_no_gravable, 0)
	)																																								as gasto_directo
	, (
		ifnull(parte_costo_prod.gasto_gravable, 0) +
		ifnull(parte_costo_prod.gasto_no_gravable, 0)
	)																																								as gasto_indirecto
	, 0 																																						as compra_nacional
	, @TIPO_COSTO_ESTANDAR 																													as opcion_id_tipo_costo
FROM a24_ky_prod.parte_costo	parte_costo_prod
left join a24_ky_prod.parte		parte_prod				ON	parte_prod.id			=	parte_costo_prod.parte_id
left join a24_ky_dev.parte 		parte_dev 				on 	parte_dev.noparte = parte_prod.noparte
where @its_all_ok
-- and parte_dev.id in (427, 76)
-- and parte_dev.id in (778, 1473)
-- and parte_dev.id in (1935,1936,1937,1938,1939,1940,1941,1942,1943,1944,1948,1949)