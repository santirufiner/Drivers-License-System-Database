----------------------------------------------------------------------------------------------------
----------------- EJERCICIO 2 - TP 2 - IMPORTACION DE DATOS DESDE HOJAS DE CALCULO -----------------
----------------------------------------------------------------------------------------------------

-- Creacion de esquema temporal para agrupar las tablas temporales
create schema tmp;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creacion tabla temporal de entidad actor

create table tmp.copy_actor (

	tipo char null, -- para decidir si es PF o PJ (si es null tendria que descartarlo)
	id bigint not null, -- de actor.actor
	apellido varchar(255) null, -- de actor.personaFisica
	codigo_actor integer null, -- de actor.actor
	cuit_codigo1 smallint null, -- de actor.actor
	cuit_codigo2 integer null, -- de actor.actor
	cuit_codigo3 smallint null, -- de actor.actor
	documento_identidad_tipo varchar(1) null, -- de actor.personaFisica
	documento_identidad_numero integer null, -- de actor.personaFisica
	email_principal varchar(255) null, -- de actor.actor
	estado_civil char(1) null, -- de actor.personaFisica
	fecha_alta date null, -- de actor.actor
	fecha_baja date null, -- de actor.actor
	fecha_nacimiento DATE null, -- de actor.personaFisica
	movil_principal varchar(255) null, -- de actor.personaFisica
	nombre varchar(255) null, -- de actor.personaFisica 
	nombre_fantasia varchar(255) null, -- de actor.personaJuridica
	nombre_organismo varchar(255) null, -- de actor.organismo
	razon_social varchar(255) null, -- de actor.personaJuridica
	sexo char(1) null, -- de actor.personaFisica
	sigla varchar(60) null, -- de actor.organismo
	telefono_principal varchar(255) null, -- de actor.actor
	id_pais bigint null, -- de actor.actor
	id_tipo_persona_juridica bigint null, -- de actor.tipoPersonaJuridica
	apellido_materno varchar(255) null, -- de actor.personaFisica 
	id_ocupacion bigint null, -- de actor.personaFisica 
	factor_sanguineo varchar(255) null, -- de NINGUNO (IGNORAR)
	grupo_sanguineo varchar(255) null, -- de NINGUNO (IGNORAR)
	donante_organos varchar(255) null, -- de actor.personaFisica 
	email_personal varchar(255) null, -- de actor.personaFisica 
	identidad_genero varchar(255) null, -- de actor.personaFisica
	id_pais2 bigint null, -- de actor.actor
	codigo_pais varchar(3) null, -- de actor.pais
	nombre_pais varchar(60) null, -- de actor.pais	
	nombre_pais_resumido varchar(20) null, -- de actor.pais
	gentilicio varchar(255) null, -- de actor.pais
	id_tipo_pj bigint null, -- de actor.tipoPersonaJuridica
	codigo_tipo_persona_juridica smallint null, -- de actor.tipoPersonaJuridica
	nombre_tipo_persona_juridica varchar(60) null, -- de actor.tipoPersonaJuridica
	nombre_tipo_persona_juridica_resumido varchar(20) null, -- de actor.tipoPersonaJuridica
	id_ocupacion2 bigint null, -- de actor.ocupacion
	codigo_ocupacion integer null, -- de actor.ocupacion
	nombre_ocupacion varchar(60) null, -- de actor.ocupacion
	nombre_ocupacion_resumido varchar(20) null, -- de actor.ocupacion
	no_usar char null -- de NINGUNO (IGNORAR)
);

-- Copia de datos de entidad temporal actor desde hoja de calculo (CAMBIAR URL SI SE UTILIZA EN OTRA PC)
	COPY tmp.copy_actor FROM 'C:\tmp\Actor-1698954423477.csv'
	WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL '');

SELECT * FROM tmp.copy_actor;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creacion tabla temporal de entidad localidad

create table tmp.copy_localidad (

	id bigint not null, -- de actor.localidad
	codigo_localidad integer null, -- de actor.localidad
	codigo_postal smallint null, -- de actor.localidad
	nombre_localidad varchar(60) null, -- de actor.localidad
	nombre_localidad_resumido varchar(20) null, -- de actor.localidad
	id_departamento bigint null, -- de actor.localidad
	id_provincia bigint null, -- de actor.localidad
	ver char(3) null -- de NINGUNO (IGNORAR)
);

-- Copia de datos de entidad temporal localidad desde hoja de calculo (CAMBIAR URL SI SE UTILIZA EN OTRA PC)
	COPY tmp.copy_localidad FROM 'C:\tmp\Localidad-1698869697208.csv'
	WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL '');

SELECT * FROM tmp.copy_localidad;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creacion tabla temporal de entidad pais_provincia_dpto

create table tmp.copy_pais_provincia_dpto (

	pais_id bigint not null, -- de actor.pais
	codigo_pais varchar(3) null, -- de actor.pais
	nombre_pais varchar(60) null, -- de actor.pais
	nombre_pais_resumido varchar(20) null, -- de actor.pais
	gentilicio varchar(255) null, -- de actor.pais
	sin_uso char(3) null, -- de NINGUNO (IGNORAR) 
	provincia_id bigint null, -- de actor.provinciaEstado
	codigo_provincia integer null, -- de actor.provinciaEstado
	nombre_provincia varchar(60) null, -- de actor.provinciaEstado
	nombre_provincia_resumido varchar(20) null, -- de actor.provinciaEstado
	provincia_id_pais bigint null, -- de actor.provinciaEstado
	departamento_id bigint null, -- de actor.departamento
	codigo_departamento smallint null, -- de actor.departamento
	nombre_departamento varchar(60) null, -- de actor.departamento
	nombre_departamento_resumido varchar(20) null, -- de actor.departamento
	departamento_id_provincia bigint null, -- de actor.departamento
	secuencia smallint null -- de actor.departamento

);

-- Copia de datos de entidad temporal pais_provincia_dpto desde hoja de calculo (CAMBIAR URL SI SE UTILIZA EN OTRA PC)
	COPY tmp.copy_pais_provincia_dpto FROM 'C:\tmp\PaisProvinciaDepto-1698684570770.csv'
	WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL '');

SELECT * FROM tmp.copy_pais_provincia_dpto;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creacion tabla temporal de entidad rol

create table tmp.copy_rol (

	tipo_rol varchar(60) null, -- de actor.rol
	id bigint not null, -- de actor.rol
	codigo_rol integer null, -- de actor.rol
	a_id bigint null, -- id_actor de actor.rol
	version char(2) null -- de NINGUNO (IGNORAR)
);

-- Copia de datos de entidad temporal rol desde hoja de calculo (CAMBIAR URL SI SE UTILIZA EN OTRA PC)
	COPY tmp.copy_rol FROM 'C:\tmp\Rol-1698950878517.csv'
	WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL '');

SELECT * FROM tmp.copy_rol;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creacion tabla temporal de entidad solicitud_licencia_conductor

create table tmp.copy_solicitud_licencia_conductor (

	id bigint not null, -- de solicitud.solicitud_licencia_conductor
	domicilio varchar(255) null, -- de solicitud.solicitud_licencia_conductor
	fecha date null, -- de solicitud.solicitud_licencia_conductor
	libre_multa boolean null, -- de solicitud.solicitud_licencia_conductor
	numero integer null, -- de solicitud.solicitud_licencia_conductor
	id_localidad bigint null, -- de solicitud.solicitud_licencia_conductor
	id_estado_actual bigint null, -- de solicitud_solicitud_licencia_conductor
	id_persona bigint null, -- de solicitud.solicitud_licencia_conductor
	id_usuario_receptor bigint null, -- de solicitud.solicitud_licencia_conductor
	corresponde_charla varchar(60) null, -- de solicitud.solicitud_licencia_conductor
	corresponde_psiquiatrico varchar(60) null, -- de solicitud.solicitud_licencia_conductor
	corresponde_teorico varchar(60) null, -- de solicitud.solicitud_licencia_conductor
	id_motivo_rechazo bigint null, -- de solicitud.solicitud_licencia_conductor
	corresponde_fisico varchar(60) null, -- de solicitud.solicitud_licencia_conductor
	tipo varchar(60) null, -- de solicitud.solicitud_licencia_conductor
	calle varchar(255) null, -- de solicitud.solicitud_licencia_conductor
	departamento varchar(255) null, -- de solicitud.solicitud_licencia_conductor
	numero_postal varchar(255) null, -- de solicitud.solicitud_licencia_conductor (OJO ACA QUE ES INTEGER EL DATO EN REALIDAD)
	piso varchar(255) null, -- de solicitud.solicitud_licencia_conductor
	fecha_vencimiento date null, -- de solicitud.solicitud_licencia_conductor
	tipo2 varchar(60) null, -- de solicitud.estado_solicitud_licencia_conductor
	id2 bigint null, -- de solicitud.estado_solicitud_licencia_conductor
	fecha2 timestamp null, -- de solicitud.estado_solicitud_licencia_conductor
	item smallint null, -- de solicitud.estado_solicitud_licencia_conductor
	id_solicitud bigint null, -- de solicitud.estado_solicitud_licencia_conductor
	vot char(2) null, -- de NINGUNO (IGNORAR)
	id3 bigint null, -- de solicitud.motivo_rechazo
	descripcion_motivo_rechazo varchar(120) null -- de solicitud.motivo_rechazo
);

-- Copia de datos de entidad temporal solicitud_licencia_conductor desde hoja de calculo (CAMBIAR URL SI SE UTILIZA EN OTRA PC)
	COPY tmp.copy_solicitud_licencia_conductor FROM 'C:\tmp\SolLicCond-1698956393176.csv'
	WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL '');

SELECT * FROM tmp.copy_solicitud_licencia_conductor;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creacion tabla temporal de entidad usuario

create table tmp.copy_usuario (

	id bigint not null, -- de actor.usuario
	id_usuario_ficticio varchar(60) null, -- de actor.usuario
	apellido_nombre varchar(255) null, -- de actor.usuario
	fecha_alta date null, -- de actor.usuario
	version char(2) null, -- de NINGUNO (IGNORAR)
	a_id bigint null, -- de actor.usuario
	hash varchar(255) null, -- de actor.usuario
	time_hash bigint null, -- de actor.usuario
	chapa_inspector varchar(255) null, -- de NINGUNO (IGNORAR)
	reparticion varchar(255) null -- de NINGUNO (IGNORAR)
	-- fecha_baja NO ESPECIFICADO (las paso como NULL)

);

-- Copia de datos de entidad temporal usuario desde hoja de calculo (CAMBIAR URL SI SE UTILIZA EN OTRA PC)
	COPY tmp.copy_usuario FROM 'C:\tmp\Usuario-1698951976224.csv'
	WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL '');

SELECT * FROM tmp.copy_usuario;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CREACION FUNCIONES DE CARGA DE DATOS

CREATE OR REPLACE FUNCTION agregarDatosPais_provincia_dpto()
	RETURNS void
	AS
	$$
	BEGIN
		
		-- Insert de datos en la tabla actor.pais donde gentilicio no es NULL
		INSERT INTO actor.pais (id, codigo_pais, nombre_pais, nombre_pais_resumido, gentilicio)
		SELECT DISTINCT ppd.pais_id, ppd.codigo_pais, ppd.nombre_pais, ppd.nombre_pais_resumido, ppd.gentilicio FROM tmp.copy_pais_provincia_dpto ppd WHERE ppd.gentilicio IS NOT NULL;

		-- Insert de datos en la tabla actor.pais donde gentilicio = NULL (pasamos como parametro la cadena 'No especifica' ya que en la tabla actor.pais no se admite NULL en gentilicio)
		INSERT INTO actor.pais (id, codigo_pais, nombre_pais, nombre_pais_resumido, gentilicio)
		SELECT DISTINCT ppd.pais_id, ppd.codigo_pais, ppd.nombre_pais, ppd.nombre_pais_resumido, 'No especifica' FROM tmp.copy_pais_provincia_dpto ppd WHERE ppd.gentilicio IS NULL;

		-- Insert de datos en la tabla actor.provinciaEstado donde id_provincia no es NULL
		INSERT INTO actor.provinciaEstado (id, id_pais, codigo_provincia, nombre_provincia, nombre_provincia_resumido)
		SELECT DISTINCT ppd.provincia_id, ppd.pais_id, ppd.codigo_provincia, ppd.nombre_provincia, ppd.nombre_provincia_resumido FROM tmp.copy_pais_provincia_dpto ppd WHERE ppd.provincia_id IS NOT NULL;

		-- No insertamos los datos en la tabla actor.provinciaEstado donde id_provincia = NULL (ya que todas las columnas son NULL)

		-- Insert de datos en la tabla actor.departamento donde departamento_id no es NULL
		INSERT INTO actor.departamento (id, id_provincia, secuencia, codigo_departamento, nombre_departamento, nombre_departamento_resumido)
		SELECT DISTINCT ppd.departamento_id, ppd.departamento_id_provincia, ppd.secuencia, ppd.codigo_departamento, ppd.nombre_departamento, ppd.nombre_departamento_resumido FROM tmp.copy_pais_provincia_dpto ppd WHERE ppd.departamento_id IS NOT NULL;

		-- No insertamos los datos en la tabla actor.departamento donde departamento_id = NULL (ya que todas las columnas son NULL)
		
	END;
	$$
	LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION agregarDatosLocalidad()
	RETURNS void
	AS
	$$
	BEGIN

		-- Insert de datos en la tabla actor.localidad
		INSERT INTO actor.localidad (id, id_provincia, id_departamento, codigo_localidad, nombre_localidad, nombre_localiad_resumido, codigo_postal)
		SELECT loc.id, loc.id_provincia, loc.id_departamento, loc.codigo_localidad, loc.nombre_localidad, loc.nombre_localidad_resumido, loc.codigo_postal FROM tmp.copy_localidad loc;	
	
	END;
	$$
	LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION agregarDatosActor()
	RETURNS void
	AS
	$$
	DECLARE
		tipoPFoPJ char;
		cursorTipo CURSOR FOR SELECT tipo FROM tmp.copy_actor;
		
	BEGIN

		-- Insert de datos en la tabla actor.actor
		INSERT INTO actor.actor(id, codigo_actor, cuit_codigo1, cuit_codigo2, cuit_codigo3, email_principal, fecha_alta, fecha_baja, telefono_principal, id_pais)
		SELECT A.id, A.codigo_actor, A.cuit_codigo1, A.cuit_codigo2, A.cuit_codigo3, A.email_principal, A.fecha_alta, A.fecha_baja, A.movil_principal, A.id_pais FROM tmp.copy_actor A;
		
		-- Insert de datos en la tabla actor.ocupacion
		INSERT INTO actor.ocupacion(id, codigo_ocupacion, nombre_ocupacion, nombre_ocupacion_resumido)
		SELECT DISTINCT A.id_ocupacion2, A.codigo_ocupacion, A.nombre_ocupacion, A.nombre_ocupacion_resumido FROM tmp.copy_actor A WHERE A.id_ocupacion IS NOT NULL;
		INSERT INTO actor.ocupacion(id, codigo_ocupacion, nombre_ocupacion, nombre_ocupacion_resumido) VALUES(0, 0, 'No especifica', 'No especifica');
		
		-- Insert de datos en la tabla actor.tipoPersonaJuridica
		INSERT INTO actor.tipoPersonaJuridica(id, codigo_tipo_persona_juridica, nombre_tipo_persona_juridica, nombre_tipo_persona_juridica_resumido)
		SELECT DISTINCT A.id_tipo_pj, A.codigo_tipo_persona_juridica, A.nombre_tipo_persona_juridica, A.nombre_tipo_persona_juridica_resumido FROM tmp.copy_actor A WHERE A.id_tipo_pj IS NOT NULL;

		-- Alterar fk para hacer id's serial de pf y pj (ya que no los tenemos en las hojas de calculo)
		alter table actor.integraorganismo drop constraint fk_personaf_io;
		alter table actor.integrapersonajuridica drop constraint fk_ipj_pf;
		alter table solicitud.solicitud_licencia_conductor drop constraint fk_slc_persona_f;
		alter table actor.personaFisica drop column id;
		alter table actor.personaFisica add column id SERIAL;
		alter table actor.personaFisica add constraint pk_PF primary key(id);
		
		alter table actor.integrapersonajuridica drop constraint fk_ipj_pj;
		alter table actor.personaJuridica drop column id;
		alter table actor.personaJuridica add column id SERIAL;
		alter table actor.personaJuridica add constraint pk_PJ primary key(id);

		-- Insert de datos en las tablas actor.personaFisica y actor.personaJuridica por medio de un cursor
		OPEN cursorTipo;
		
		LOOP
			FETCH NEXT FROM cursorTipo INTO tipoPFoPJ;
			
			EXIT WHEN NOT FOUND;

				IF tipoPFoPJ = 'F' THEN
					INSERT INTO actor.personaFisica(id_ocupacion, id_actor, documento_identidad_tipo, documento_identidad_numero, apellido, fecha_nacimiento, nombre, movil_principal, sexo, apellido_materno, donante_organos, email_principal, identidad_genero, estado_civil)
					SELECT A.id_ocupacion, A.id, A.documento_identidad_tipo, A.documento_identidad_numero, A.apellido, A.fecha_nacimiento, A.nombre, A.telefono_principal, A.sexo, A.apellido_materno, A.donante_organos, A.email_personal, A.identidad_genero, A.estado_civil FROM tmp.copy_actor A
					WHERE NOT EXISTS (SELECT id_actor FROM actor.personaFisica) AND A.documento_identidad_numero IS NOT NULL AND A.estado_civil IS NOT NULL;
					
				ELSIF tipoPFoPJ = 'J' THEN
					INSERT INTO actor.personaJuridica(id_actor, id_tipo_persona, nombre_fantasia, razon_social)
					SELECT A.id, 1, A.nombre_fantasia, A.razon_social FROM tmp.copy_actor A
					WHERE NOT EXISTS (SELECT id_actor FROM actor.personaJuridica) AND A.razon_social IS NOT NULL;
					
				END IF;
			
		END LOOP;

		CLOSE cursorTipo;

		-- Volver a colocar fk en las tablas correspondientes
		alter table actor.integraorganismo add constraint fk_personaf_io foreign key(id_persona_f) references actor.personaFisica(id);
		alter table actor.integrapersonajuridica add constraint fk_iPJ_PF foreign key (id_persona_f) references actor.personaFisica (id);
		alter table solicitud.solicitud_licencia_conductor add constraint fk_slc_persona_f foreign key (id_persona_f) references actor.personaFisica(id);
		alter table actor.integrapersonajuridica add constraint fk_iPJ_PJ foreign key (id_persona_ju) references actor.personaJuridica(id);
		
		
	END;
	$$
	LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION agregarDatosUsuario()
	RETURNS void
	AS
	$$
	BEGIN
		-- Insert de datos en la tabla actor.usuario
		INSERT INTO actor.usuario(id, id_usuario, apellido_nombre, fecha_alta, hash, time_hash, fecha_baja, id_actor)
		SELECT U.id, U.id_usuario_ficticio, 'No especificado', U.fecha_alta, U.hash, U.time_hash, NULL, U.a_id FROM tmp.copy_usuario U;	
	END;
	$$
	LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION agregarDatosRol()
	RETURNS void
	AS
	$$
	BEGIN
		-- Insert de datos en la tabla actor.rol
		INSERT INTO actor.rol(id, id_actor, tipo_rol, codigo_rol)
		SELECT R.id, R.a_id, R.tipo_rol, R.codigo_rol FROM tmp.copy_rol R;
		
	END;
	$$
	LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION agregarDatosSolicitudesLC()
	RETURNS void
	AS
	$$
	DECLARE	
	BEGIN
		-- Insert de datos en la tabla solicitud.motivo_rechazo (usamos el propio id como codigo_motivo_rechazo)
		INSERT INTO solicitud.motivo_rechazo(id, codigo_motivo_rechazo, descripcion_motivo_rechazo)
		SELECT DISTINCT SLC.id_motivo_rechazo, SLC.id3, SLC.descripcion_motivo_rechazo FROM tmp.copy_solicitud_licencia_conductor SLC
		WHERE SLC.id_motivo_rechazo IS NOT NULL;

		-- Insert de datos en la tabla solicitud.solicitud_licencia_conductor (con id_estado_actual_solicitudLC = NULL)
		INSERT INTO solicitud.solicitud_licencia_conductor(id, numero, id_persona_f, id_localidad, id_usuario, id_motivo_rechazo, domicilio, fecha, corresponde_charla, corresponde_psiquiatrico, corresponde_teorico, corresponde_fisico, tipo, calle, departamento, numero_postal, piso, fecha_vencimiento, libre_multa, id_estado_actual_solicitudLC)
		SELECT SLC.id, SLC.numero, SLC.id_persona, SLC.id_localidad, SLC.id_usuario_receptor, SLC.id_motivo_rechazo, SLC.domicilio, SLC.fecha, SLC.corresponde_charla, SLC.corresponde_psiquiatrico, SLC.corresponde_teorico, SLC.corresponde_fisico, SLC.tipo, SLC.calle, SLC.departamento, SLC.numero_postal, SLC.piso, SLC.fecha_vencimiento, SLC.libre_multa, NULL FROM tmp.copy_solicitud_licencia_conductor SLC
		-- Colocamos un EXISTS porque nos tiraba que existian id_persona_f que no se encontraban en ningún id de autor.personaFisica
		WHERE EXISTS (SELECT id FROM actor.personaFisica WHERE SLC.id_persona = id);
		
		-- Insert de datos en la tabla solicitud.estado_solicitud_licencia_conductor
		ALTER TABLE solicitud.estado_solicitud_licencia_conductor drop constraint fk_eslc_slc; -- Dropeamos la fk porque nos pasaba algo similar que con el id_persona
		INSERT INTO solicitud.estado_solicitud_licencia_conductor(id, id_solicitud_licencia, item, tipo)
		SELECT SLC.id_solicitud, SLC.id, SLC.item, SLC.tipo2 FROM tmp.copy_solicitud_licencia_conductor SLC;
	
		-- Hacemos el update del dato de id_estado_actual en la tabla solicitud.estado_solicitud_licencia_conductor
		ALTER TABLE solicitud.solicitud_licencia_conductor DROP CONSTRAINT fk_solicitud_estadolc; -- Dropeamos esta constraint por mismo motivo que las anteriores
		UPDATE solicitud.solicitud_licencia_conductor
			SET id_estado_actual_solicitudLC = SLC.id_estado_actual
				FROM tmp.copy_solicitud_licencia_conductor SLC
			WHERE solicitud.solicitud_licencia_conductor.id = SLC.id;
	
	END;
	$$
	LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LLAMADA DE FUNCIONES DE INSERCIÓN

SELECT agregarDatosPais_provincia_dpto();
SELECT agregarDatosLocalidad();
SELECT agregarDatosActor();
SELECT agregarDatosUsuario();
SELECT agregarDatosRol();
SELECT agregarDatosSolicitudesLC();
