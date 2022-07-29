-- 7. cliente.sql
set @TIPO_ENTIDAD_AMBOS = 7, @TIPO_ENTIDAD_CLIENTE = 8, @TIPO_ENTIDAD_CLIENTE = 9;
set @METODO_VALORACION_VALOR_COMERCIAL = 1;
SET @TIPO_EMPRESA_EXTRANGERA_OLD = 18, @TIPO_EMPRESA_EXTRANGERA_NEW = 409, @TIPO_EMPRESA_NACIONAL = 15, @TIPO_EMPRESA_COMERCIALIZADORA = 401;
set @NO_ES_COORPORATIVO = 0;
set @PROCEDENCIA_NACIONAL = 348;
set @TIPO_IDENTIFICADOR_RFC = 344;
set @its_all_ok = true;

delete from a24_ky_dev.cliente where @its_all_ok;
ALTER TABLE a24_ky_dev.cliente AUTO_INCREMENT = 1;

INSERT INTO a24_ky_dev.cliente (
	razon_social,nombre_corto,tipo_entidad_id,opcion_id_empresa,opcion_id_tipo_productor,actividad_principal,agencia_usa,agencia_mx,rep_legal_nombre,rep_legal_apPaterno,rep_legal_apMaterno,rep_legal_rfc,rep_legal_curp,rep_legal_tel,rep_legal_fax,rep_legal_email,opcion_id_rep_puesto,activo,logo,corporativo,metodo_valoracion_id,opcion_id_procedencia,opcion_id_tipo_identificador,numero_identificacion
)
select
razon_social
, nombre_corto
	, opcion_id_cliente																																								as tipo_entidad_id
, CASE
		WHEN opcion_id_empresa = @TIPO_EMPRESA_EXTRANGERA_OLD THEN @TIPO_EMPRESA_EXTRANGERA_NEW
		WHEN opcion_id_empresa = @TIPO_EMPRESA_NACIONAL THEN @TIPO_EMPRESA_COMERCIALIZADORA
		ELSE opcion_id_empresa
	END 																																															as opcion_id_empresa
, opcion_id_tipo_productor
, actividad_principal
, agencia_usa
, agencia_mx
, rep_legal_nombre
, rep_legal_apPaterno
, rep_legal_apMaterno
, rep_legal_rfc
, rep_legal_curp
, rep_legal_tel
, rep_legal_fax
, rep_legal_email
, opcion_id_rep_puesto
, activo
, logo
, @NO_ES_COORPORATIVO																																								as corporativo
, @METODO_VALORACION_VALOR_COMERCIAL 																																as metodo_valoracion_id
, @PROCEDENCIA_NACIONAL 																 																						as opcion_id_procedencia
, @TIPO_IDENTIFICADOR_RFC																 																						as opcion_id_tipo_identificador
, cliente_prod.rfc																			 																						as numero_identificacion
from a24_ky_prod.cliente cliente_prod
where @its_all_ok;


