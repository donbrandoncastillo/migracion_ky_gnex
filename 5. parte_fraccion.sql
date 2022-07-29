-- 5. parte_fraccion.sql
set @TARIFA_MX = 378, @TARIFA_US = 379;
set @TIPO_FRACCION_GENERAL = 381;
set @TIPO_OPERACION_IMPO = 375, @TIPO_OPERACION_EXPO = 377, @TIPO_OPERACION_IMPO_EXPO = 376;
set @its_all_ok = true;

delete from a24_ky_dev.parte_fraccion where @its_all_ok;
ALTER TABLE a24_ky_dev.parte_fraccion AUTO_INCREMENT = 1;


-- 3.1 No partes que solo tienen fracciones de importación
insert into a24_ky_dev.parte_fraccion (
	opcion_id_tarifa,parte_id,opcion_id_tipo_fraccion,opcion_id_tipo_operacion,fraccion_id,umc,factor_conversion,umt,tasa_importacion,tasa_exportacion,no_grava_iva,ieps,fecha_inicio,fecha_final
)
SELECT
	@TARIFA_MX																															as opcion_id_tarifa,
	(
		select parte_dev.id
		from a24_ky_dev.parte parte_dev
		where parte_dev.noparte = parte.noparte
	) 																																			as parte_id,
	@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
	@TIPO_OPERACION_IMPO 																										as opcion_id_tipo_operacion,
	fraccion_dev.id					 																								as fraccion_id,
	(										
		select parte_dev.medida_id_mx
		from a24_ky_dev.parte parte_dev
		where parte_dev.noparte = parte.noparte
	) 																																			as umc,
	ifnull(factor_conversion, 1)																						as factor_conversion,
	fraccion_dev.medida_id																									as umt,
	fraccion_dev.tasa_importacion																						as tasa_importacion,
	fraccion_dev.tasa_exportacion																						as tasa_exportacion,
	0 																																			as no_grava_iva,
	0 																																			as ieps,
	if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
	if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
FROM a24_ky_prod.parte	-- 686
left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_importacion
where (fraccion_id_importacion is not null and (fraccion_id_exportacion is null and fraccion_id_extranjera_exportacion is null and fraccion_id_extranjera_importacion is null))
and @its_all_ok;


-- 3.2 No partes que solo tienen fracciones de exportación
insert into a24_ky_dev.parte_fraccion (
	opcion_id_tarifa,parte_id,opcion_id_tipo_fraccion,opcion_id_tipo_operacion,fraccion_id,umc,factor_conversion,umt,tasa_importacion,tasa_exportacion,no_grava_iva,ieps,fecha_inicio,fecha_final
)
SELECT
	@TARIFA_MX																															as opcion_id_tarifa,
	(
		select parte_dev.id
		from a24_ky_dev.parte parte_dev
		where parte_dev.noparte = parte.noparte
	) 																																			as parte_id,
	@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
	@TIPO_OPERACION_EXPO 																										as opcion_id_tipo_operacion,
	fraccion_dev.id					 																								as fraccion_id,
	(										
		select parte_dev.medida_id_mx
		from a24_ky_dev.parte parte_dev
		where parte_dev.noparte = parte.noparte
	) 																																			as umc,
	ifnull(factor_conversion, 1)																						as factor_conversion,
	fraccion_dev.medida_id																									as umt,
	fraccion_dev.tasa_importacion																						as tasa_importacion,
	fraccion_dev.tasa_exportacion																						as tasa_exportacion,
	0 																																			as no_grava_iva,
	0 																																			as ieps,
	if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
	if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
FROM a24_ky_prod.parte	-- 686
left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_exportacion
where (fraccion_id_exportacion is not null and (fraccion_id_importacion is null and fraccion_id_extranjera_exportacion is null and fraccion_id_extranjera_importacion is null))
and @its_all_ok;

-- 3.3 No partes que tiene la misma fracción de impo y expo y no tienen fracciones extrangeras
insert into a24_ky_dev.parte_fraccion (
	opcion_id_tarifa,parte_id,opcion_id_tipo_fraccion,opcion_id_tipo_operacion,fraccion_id,umc,factor_conversion,umt,tasa_importacion,tasa_exportacion,no_grava_iva,ieps,fecha_inicio,fecha_final
)
SELECT
	@TARIFA_MX																															as opcion_id_tarifa,
	(
		select parte_dev.id
		from a24_ky_dev.parte parte_dev
		where parte_dev.noparte = parte.noparte
	) 																																			as parte_id,
	@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
	@TIPO_OPERACION_IMPO_EXPO																								as opcion_id_tipo_operacion,
	fraccion_dev.id					 																								as fraccion_id,
	(										
		select parte_dev.medida_id_mx
		from a24_ky_dev.parte parte_dev
		where parte_dev.noparte = parte.noparte
	) 																																			as umc,
	ifnull(factor_conversion, 1)																						as factor_conversion,
	fraccion_dev.medida_id																									as umt,
	fraccion_dev.tasa_importacion																						as tasa_importacion,
	fraccion_dev.tasa_exportacion																						as tasa_exportacion,
	0 																																			as no_grava_iva,
	0 																																			as ieps,
	if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
	if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
FROM a24_ky_prod.parte	-- 686
left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_exportacion
where (fraccion_id_exportacion = fraccion_id_importacion and (fraccion_id_extranjera_importacion is null and fraccion_id_extranjera_exportacion is null))
and @its_all_ok;

-- 3.4 No partes que tiene la misma fracción de impo y expo y la fraccion extrangera impo y expo son iguales
insert into a24_ky_dev.parte_fraccion (
	opcion_id_tarifa,parte_id,opcion_id_tipo_fraccion,opcion_id_tipo_operacion,fraccion_id,umc,factor_conversion,umt,tasa_importacion,tasa_exportacion,no_grava_iva,ieps,fecha_inicio,fecha_final
)
select
*
from (
	-- No partes con fracciones mexicanas de impo/expo iguales
	SELECT
		@TARIFA_MX																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO_EXPO																								as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_exportacion
	where (fraccion_id_exportacion = fraccion_id_importacion and (fraccion_id_extranjera_importacion = fraccion_id_extranjera_exportacion))
	and @its_all_ok
	union all
	-- No partes con fracciones extrangeras de impo/expo iguales
	SELECT
		@TARIFA_US																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO_EXPO																								as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_extranjera_importacion
	where (fraccion_id_exportacion = fraccion_id_importacion and (fraccion_id_extranjera_importacion = fraccion_id_extranjera_exportacion))
	and @its_all_ok
) as inserts_finales;

-- 3.5 No partes que tiene la misma fracción de impo y expo y con fraccion extrangera de expo solamente
insert into a24_ky_dev.parte_fraccion (
	opcion_id_tarifa,parte_id,opcion_id_tipo_fraccion,opcion_id_tipo_operacion,fraccion_id,umc,factor_conversion,umt,tasa_importacion,tasa_exportacion,no_grava_iva,ieps,fecha_inicio,fecha_final
)
select
*
from (
	-- No partes con fracciones mexicanas de impo/expo iguales
	SELECT
		@TARIFA_MX																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO_EXPO																								as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_exportacion
	where (fraccion_id_exportacion = fraccion_id_importacion and (fraccion_id_extranjera_importacion is null and fraccion_id_extranjera_exportacion is not null))
	and @its_all_ok
	union all
	-- No partes con fracción extrangera de expo solamente
	SELECT
		@TARIFA_US																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_EXPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_extranjera_exportacion
	where (fraccion_id_exportacion = fraccion_id_importacion and (fraccion_id_extranjera_importacion is null and fraccion_id_extranjera_exportacion is not null))
	and @its_all_ok
) as inserts_finales;

-- 3.6 No partes que tiene la misma fracción de impo y expo y con fraccion extrangera de impo solamente
insert into a24_ky_dev.parte_fraccion (
	opcion_id_tarifa,parte_id,opcion_id_tipo_fraccion,opcion_id_tipo_operacion,fraccion_id,umc,factor_conversion,umt,tasa_importacion,tasa_exportacion,no_grava_iva,ieps,fecha_inicio,fecha_final
)
select
*
from (
	-- No partes con fracciones mexicanas de impo/expo iguales
	SELECT
		@TARIFA_MX																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO_EXPO																								as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_exportacion
	where (fraccion_id_exportacion = fraccion_id_importacion and (fraccion_id_extranjera_exportacion is null and fraccion_id_extranjera_importacion is not null))
	and @its_all_ok
	union all
	-- No partes con fracción extrangera de impo solamente
	SELECT
		@TARIFA_US																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_extranjera_importacion
	where (fraccion_id_exportacion = fraccion_id_importacion and (fraccion_id_extranjera_exportacion is null and fraccion_id_extranjera_importacion is not null))
	and @its_all_ok
) as inserts_finales;


-- 3.7 No partes que tiene la misma fracción de impo y expo y con fraccion extrangera de impo diferentes a fraccion extrangera de expo
insert into a24_ky_dev.parte_fraccion (
	opcion_id_tarifa,parte_id,opcion_id_tipo_fraccion,opcion_id_tipo_operacion,fraccion_id,umc,factor_conversion,umt,tasa_importacion,tasa_exportacion,no_grava_iva,ieps,fecha_inicio,fecha_final
)
select
*
from (
	-- No partes con fracciones mexicanas de impo/expo iguales
	SELECT
		@TARIFA_MX																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO_EXPO																								as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_exportacion
	where (fraccion_id_exportacion = fraccion_id_importacion and fraccion_id_extranjera_exportacion != fraccion_id_extranjera_importacion)
	and @its_all_ok
	union all
	-- No partes con fracción extrangera de impo solamente
	SELECT
		@TARIFA_US																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_extranjera_importacion
	where (fraccion_id_exportacion = fraccion_id_importacion and fraccion_id_extranjera_exportacion != fraccion_id_extranjera_importacion)
	and @its_all_ok
	union all
	-- No partes con fracción extrangera de expo solamente
	SELECT
		@TARIFA_US																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_EXPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_extranjera_exportacion
	where (fraccion_id_exportacion = fraccion_id_importacion and fraccion_id_extranjera_exportacion != fraccion_id_extranjera_importacion)
	and @its_all_ok
) as inserts_finales;

-- 3.8 No partes que solo tiene fracción MX de expo y solo con fraccion extrangera de expo
insert into a24_ky_dev.parte_fraccion (
	opcion_id_tarifa,parte_id,opcion_id_tipo_fraccion,opcion_id_tipo_operacion,fraccion_id,umc,factor_conversion,umt,tasa_importacion,tasa_exportacion,no_grava_iva,ieps,fecha_inicio,fecha_final
)
select
*
from (
	-- No partes con fracciones mexicanas de expo
	SELECT
		@TARIFA_MX																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_EXPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_exportacion
	where (fraccion_id_exportacion is not null and fraccion_id_importacion is null and fraccion_id_extranjera_exportacion is not null and fraccion_id_extranjera_importacion is null)
	and @its_all_ok
	union all
	-- No partes de fracción extrangera de expo solamente
	SELECT
		@TARIFA_US																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_EXPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_extranjera_exportacion
	where (fraccion_id_exportacion is not null and fraccion_id_importacion is null and fraccion_id_extranjera_exportacion is not null and fraccion_id_extranjera_importacion is null)
	and @its_all_ok
) as inserts_finales;

-- 3.9 No partes con fraccion MX impo y fraccion MX expo diferentes y sin fracciones extrangeras
insert into a24_ky_dev.parte_fraccion (
	opcion_id_tarifa,parte_id,opcion_id_tipo_fraccion,opcion_id_tipo_operacion,fraccion_id,umc,factor_conversion,umt,tasa_importacion,tasa_exportacion,no_grava_iva,ieps,fecha_inicio,fecha_final
)
select
*
from (
	-- No partes con fracciones mexicanas de expo
	SELECT
		@TARIFA_MX																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_EXPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_exportacion
	where (fraccion_id_importacion != fraccion_id_exportacion AND (fraccion_id_extranjera_importacion is null and fraccion_id_extranjera_exportacion is null))
	and @its_all_ok
	union all
	-- No partes con fracciones mexicanas de impo
	SELECT
		@TARIFA_MX																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_importacion
	where (fraccion_id_importacion != fraccion_id_exportacion AND (fraccion_id_extranjera_importacion is null and fraccion_id_extranjera_exportacion is null))
	and @its_all_ok
) as inserts_finales;

-- 3.10 no partes con fraccion mx impo, sin fracciones de expo  y fracciones extrangeras iguales
insert into a24_ky_dev.parte_fraccion (
	opcion_id_tarifa,parte_id,opcion_id_tipo_fraccion,opcion_id_tipo_operacion,fraccion_id,umc,factor_conversion,umt,tasa_importacion,tasa_exportacion,no_grava_iva,ieps,fecha_inicio,fecha_final
)
select
*
from (
	-- No partes con fracciones mexicanas de impo
	SELECT
		@TARIFA_MX																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte	-- 686
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_importacion
	where (fraccion_id_importacion is not null and fraccion_id_exportacion is null AND (fraccion_id_extranjera_importacion = fraccion_id_extranjera_exportacion))
	and @its_all_ok
	union all
	-- No partes con fracciones extrangeras iguales
	SELECT
		@TARIFA_US																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO_EXPO																								as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_extranjera_importacion
	where (fraccion_id_importacion is not null and fraccion_id_exportacion is null AND (fraccion_id_extranjera_importacion = fraccion_id_extranjera_exportacion))
	and @its_all_ok
) as inserts_finales;


-- 3.11 no partes con fraccion mx impo diferente a fraccion mx expo y con fracción extrangera de impo y sin fracción extrangera de expo
insert into a24_ky_dev.parte_fraccion (
	opcion_id_tarifa,parte_id,opcion_id_tipo_fraccion,opcion_id_tipo_operacion,fraccion_id,umc,factor_conversion,umt,tasa_importacion,tasa_exportacion,no_grava_iva,ieps,fecha_inicio,fecha_final
)
select
*
from (
	-- No partes con fracciones mexicanas de impo
	SELECT
		@TARIFA_MX																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte	-- 686
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_importacion
	where (fraccion_id_importacion != fraccion_id_exportacion AND (fraccion_id_extranjera_importacion is not null and fraccion_id_extranjera_exportacion is null))
	and @its_all_ok
	union all
	-- No partes con fracciones mexicanas de expo
	SELECT
		@TARIFA_MX																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_EXPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte	-- 686
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_exportacion
	where (fraccion_id_importacion != fraccion_id_exportacion AND (fraccion_id_extranjera_importacion is not null and fraccion_id_extranjera_exportacion is null))
	and @its_all_ok
	union all
	-- No partes con fracciobes extrangeras de impo
	SELECT
		@TARIFA_US																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte	-- 686
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_extranjera_importacion
	where (fraccion_id_importacion != fraccion_id_exportacion AND (fraccion_id_extranjera_importacion is not null and fraccion_id_extranjera_exportacion is null))
	and @its_all_ok
) as inserts_finales;

-- 3.12 No partes sin fracciones MX y con fracciones extrangeras iguales
insert into a24_ky_dev.parte_fraccion (
	opcion_id_tarifa,parte_id,opcion_id_tipo_fraccion,opcion_id_tipo_operacion,fraccion_id,umc,factor_conversion,umt,tasa_importacion,tasa_exportacion,no_grava_iva,ieps,fecha_inicio,fecha_final
)
SELECT
	@TARIFA_US																															as opcion_id_tarifa,
	(
		select parte_dev.id
		from a24_ky_dev.parte parte_dev
		where parte_dev.noparte = parte.noparte
	) 																																			as parte_id,
	@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
	@TIPO_OPERACION_IMPO_EXPO																								as opcion_id_tipo_operacion,
	fraccion_dev.id					 																								as fraccion_id,
	(										
		select parte_dev.medida_id_mx
		from a24_ky_dev.parte parte_dev
		where parte_dev.noparte = parte.noparte
	) 																																			as umc,
	ifnull(factor_conversion, 1)																						as factor_conversion,
	fraccion_dev.medida_id																									as umt,
	fraccion_dev.tasa_importacion																						as tasa_importacion,
	fraccion_dev.tasa_exportacion																						as tasa_exportacion,
	0 																																			as no_grava_iva,
	0 																																			as ieps,
	if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
	if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
FROM a24_ky_prod.parte	-- 686
left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_extranjera_importacion
where (fraccion_id_importacion is null and fraccion_id_exportacion is null AND (fraccion_id_extranjera_importacion = fraccion_id_extranjera_exportacion))
and @its_all_ok;

-- 3.13 no partes con fraccion mx impo, sin fraccion mx expo y con fracción extrangera de impo y sin fracción extrangera de expo
insert into a24_ky_dev.parte_fraccion (
	opcion_id_tarifa,parte_id,opcion_id_tipo_fraccion,opcion_id_tipo_operacion,fraccion_id,umc,factor_conversion,umt,tasa_importacion,tasa_exportacion,no_grava_iva,ieps,fecha_inicio,fecha_final
)
select
*
from (
	-- No partes con fracción mx impo
	SELECT
		@TARIFA_MX																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte	-- 686
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_importacion
	where (parte.fraccion_id_exportacion is null and parte.fraccion_id_importacion is not NULL and parte.fraccion_id_extranjera_exportacion is null and parte.fraccion_id_extranjera_importacion is not NULL)
	and @its_all_ok
	union all
	-- No partes con fracción extrangeras de impo
	SELECT
		@TARIFA_US																															as opcion_id_tarifa,
		(
			select parte_dev.id
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as parte_id,
		@TIPO_FRACCION_GENERAL																									as opcion_id_tipo_fraccion,
		@TIPO_OPERACION_IMPO																										as opcion_id_tipo_operacion,
		fraccion_dev.id					 																								as fraccion_id,
		(										
			select parte_dev.medida_id_mx
			from a24_ky_dev.parte parte_dev
			where parte_dev.noparte = parte.noparte
		) 																																			as umc,
		ifnull(factor_conversion, 1)																						as factor_conversion,
		fraccion_dev.medida_id																									as umt,
		fraccion_dev.tasa_importacion																						as tasa_importacion,
		fraccion_dev.tasa_exportacion																						as tasa_exportacion,
		0 																																			as no_grava_iva,
		0 																																			as ieps,
		if(LENGTH(fraccion_dev.fraccion) = 10, '2020-12-29', '2015-01-01')			as fecha_inicio,
		if(LENGTH(fraccion_dev.fraccion) = 10, '9999-12-31', '2020-12-28')			as fecha_final 
	FROM a24_ky_prod.parte	-- 686
	left join a24_ky_dev.fraccion	as fraccion_dev on fraccion_dev.id		=	parte.fraccion_id_extranjera_importacion
	where (parte.fraccion_id_exportacion is null and parte.fraccion_id_importacion is not NULL and parte.fraccion_id_extranjera_exportacion is null and parte.fraccion_id_extranjera_importacion is not NULL)
	and @its_all_ok
) as inserts_finales;

