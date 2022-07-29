-- 4. parte.sql

set @TIPO_CATALOGO_MATERIA_PRIMA = 163, @TIPO_CATALOGO_PT_SUB = 164, @TIPO_CATALOGO_MAQUINARIA_Y_EQUIPO = 165;
set @TIPO_ADQUISICION_COMPRADO = 353, @TIPO_ADQUISICION_MANUFACTURADO = 351;
SET @MEDIDA_AREA = 2, @MEDIDA_PIEZA = 19, @MEDIDA_KILOMETRO = 37, @MEDIDA_KILOGRAMO = 36, @MEDIDA_YARDA = 70, @MEDIDA_METRO_LINEAL = 176, @MEDIDA_ROLLO = 73;
set @its_all_ok = true;

delete from a24_ky_dev.parte where @its_all_ok;
ALTER TABLE a24_ky_dev.parte AUTO_INCREMENT = 1;

insert into a24_ky_dev.parte (
	noparte,
	tipo_material_id,
	descripcion_esp,
	descripcion_ing,
	peso_unitario_kg,
	medida_id_mx,
	pais_id_origen,
	eccn,
	fecha_ultima_modificacion,
	fecha_creacion,
	marca,
	modelo,
	serie,
	numero_activo,
	ubicacion,
	vida_util,
	etiqueto,
	foto,
	tipo_catalogo_id,
	medida_id_extranjera,
	factor_conversion,
	costo_unitario_dll,
	activo,
	tipo_adquisicion_id,
	peso_libras,
	ext_art_25
)
SELECT
	noparte,
	tipo_material_id,
	descripcion_esp,
	descripcion_ing,
	peso_unitario_kg,
		CASE
		WHEN medida_id_mx = @MEDIDA_AREA THEN @MEDIDA_PIEZA
		WHEN medida_id_mx = @MEDIDA_KILOMETRO THEN @MEDIDA_KILOGRAMO
		WHEN medida_id_mx = @MEDIDA_ROLLO THEN @MEDIDA_PIEZA
		else medida_id_mx
	END 																																												as medida_id_mx,
	pais_id_origen,
	eccn,
	fecha_ultima_modificacion,
	fecha_creacion,
	marca,
	modelo,
	serie,
	numero_activo,
	ubicacion,
	vida_util,
	etiqueto,
	foto,
	opcion_id_material																																					as tipo_catalogo_id,
	medida_id_extranjera,
	factor_conversion,
	ifnull(costo_unitario_dll, 1)																																as costo_unitario_dll,
	activo,
	CASE
		WHEN opcion_id_material = @TIPO_CATALOGO_MATERIA_PRIMA THEN @TIPO_ADQUISICION_COMPRADO
		WHEN opcion_id_material = @TIPO_CATALOGO_PT_SUB THEN @TIPO_ADQUISICION_MANUFACTURADO
		WHEN opcion_id_material = @TIPO_CATALOGO_MAQUINARIA_Y_EQUIPO THEN @TIPO_ADQUISICION_COMPRADO
	END 																																												'tipo_adquisicion_id',
	peso_unitario_kg * 2.20462 																																	'peso_libras',
	ext_art_303 																																								'ext_art_25'
FROM
	a24_ky_prod.parte
where @its_all_ok;
