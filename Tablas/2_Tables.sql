----------------------------------------------------------------------------------------------------
------------------------------ TP 1 - EJERCICIO 2 - CREACION DE TABLAS -----------------------------
----------------------------------------------------------------------------------------------------

create table actor.pais(
id bigint not null,
codigo_pais varchar(3) not null,
nombre_pais varchar(60) not null,
nombre_pais_resumido varchar(20) not null,
gentilicio varchar(255) not null,

constraint pk_pais primary key (id),
constraint ak_codigo unique (codigo_pais)
);

create table actor.actor(
id bigint not null,
codigo_actor integer not null,
cuit_codigo1 smallint null,
cuit_codigo2 integer null,
cuit_codigo3 smallint null,
email_principal varchar(255) null,
fecha_alta date not null,
fecha_baja date null,
telefono_principal varchar(255) null,
id_pais bigint null,

constraint pk_actor primary key(id),
constraint fk_actor_pais foreign key (id_pais) references actor.pais(id),
constraint ak_codigo_actor unique (codigo_actor)
);

create table actor.rol(
id bigint not null,
id_actor bigint not null,
tipo_rol varchar(60) not null,
codigo_rol integer not null,

constraint pk_rol primary key(id),
constraint fk_rol_actor foreign key (id_actor) references actor.actor (id),
constraint uk_rol unique (id_actor,tipo_rol,codigo_rol),
constraint chk_tipo_rol check (tipo_rol in ('INSPECTOR_TRANSITO','MEDICO'))
);


create table actor.usuario(
id bigint not null,
id_usuario varchar(60) not null,
apellido_nombre varchar(255) not null,
fecha_alta DATE not null,
hash varchar(255) null,
time_hash bigint null,
fecha_baja DATE null,

constraint pk_usuario primary key(id),
constraint uk_usuario unique(id_usuario)
);


create table actor.ocupacion(
id bigint not null,
codigo_ocupacion integer not null,
nombre_ocupacion varchar(60) not null,
nombre_ocupacion_resumido varchar(20) not null,

constraint pk_ocupacion primary key (id),
constraint uk_ocupacion unique(codigo_ocupacion)
);

create table actor.funcion(
id bigint not null,
codigo_funcion smallint not null,
nombre_funcion varchar(60) not null,
nombre_funcion_resumido varchar(20) null,

constraint pk_funcion primary key (id),
constraint uk_funcion unique (codigo_funcion)
);

create table actor.tipoPersonaJuridica(
id bigint not null,
codigo_tipo_persona_juridica smallint not null,
nombre_tipo_persona_juridica varchar(60) not null,
nombre_tipo_persona_juridica_resumido varchar(20) not null,

constraint pk_tPJ primary key(id),
constraint uk_tPJ unique (codigo_tipo_persona_juridica)
);

create table actor.personaJuridica(
id bigint not null,
id_actor bigint not null,
id_tipo_persona bigint not null,
nombre_fantasia varchar(255) null,
razon_social varchar(255) not null,

constraint pk_PJ primary key(id),
constraint uk_PK unique(id_actor),
constraint fk_PJ_actor foreign key(id_actor) references actor.actor (id),
constraint fk_PJ_TPJ foreign key (id_tipo_persona) references actor.tipoPersonaJuridica(id)
);

create table actor.personaFisica(
id bigint not null,
id_ocupacion bigint null,
id_actor bigint not null,
documento_identidad_tipo varchar(1) not null,
documento_identidad_numero integer not null,
apellido varchar(255) not null,
fecha_nacimiento DATE not null,
nombre varchar(255) not null,
movil_principal varchar(255) null,
sexo char(1) not null,
apellido_materno varchar(255) null,
donante_organos varchar(255) null,
email_principal varchar(255) null,
identidad_genero varchar(255) null,
estado_civil char(1) not null,

constraint pk_PF primary key (id),
constraint uk_PF unique (id_actor,documento_identidad_tipo,documento_identidad_numero),
constraint fk_PF_actor foreign key (id_actor) references actor.actor(id),
constraint fk_PF_ocupacion foreign key (id_ocupacion) references actor.ocupacion(id),
constraint chk_estado check(estado_civil in('S','C','E','D','V''N'))
);

create table actor.organismo(
id bigint not null,
id_actor bigint not null,
nombre_organismo varchar(255) not null,
sigla varchar(60) null,

constraint pk_organismo primary key (id),
constraint uk_organismo unique(id_actor),
constraint fk_organismo_actor foreign key (id_actor) references actor.actor (id)
);

create table actor.integraOrganismo(
id bigint not null,
id_persona_f bigint not null,
id_funcion bigint not null,
id_organismo bigint not null,
secuencia smallint not null,
fecha_alta DATE not null,
fecha_baja DATE null,

constraint pk_IO primary key(id),
constraint uk_IO unique (id_organismo,secuencia),
constraint fk_personaf_IO foreign key(id_persona_f) references actor.personaFisica(id),
constraint fk_funcion_IO foreign key (id_funcion) references actor.funcion(id),
constraint fk_organismo foreign key (id_organismo) references actor.organismo(id)
);

create table actor.integraPersonaJuridica(
id bigint not null,
id_persona_f bigint not null,
secuencia smallint not null,
id_funcion bigint not null,
id_persona_ju bigint not null,
fecha_alta DATE not null,
fecha_baja DATE null,

constraint pk_iPJ primary key (id),
constraint uk_iPJ unique (secuencia,id_persona_ju),
constraint fk_iPJ_PF foreign key (id_persona_f) references actor.personaFisica (id),
constraint fk_iPJ_PJ foreign key (id_persona_ju) references actor.personaJuridica(id),
constraint fk_iPJ_funcion foreign key (id_funcion) references actor.funcion(id)
);

create table actor.Actor_Usuario(
id bigint not null,
id_actor bigint null,
id_us bigint null,

constraint pk_a_u primary key (id),
constraint uk_a_u unique(id_actor,id_us),
constraint fk_a_u_actor foreign key (id_actor) references actor.actor(id),
constraint fk_a_u_usuario foreign key (id_us) references actor.usuario(id)
);


create table actor.provinciaEstado(
id bigint not null,
id_pais bigint not null,
codigo_provincia integer not null,
nombre_provincia varchar(60) not null,
nombre_provincia_resumido varchar(20) not null,

constraint pk_provinciaEstado primary key (id),
constraint uk_provinciaEstado unique (id_pais,codigo_provincia),
constraint fk_pais_provinciaEstado foreign key (id_pais) references actor.pais(id)
);

create table actor.departamento(
id bigint not null,
id_provincia bigint not null,
secuencia smallint not null,
codigo_departamento smallint not null,
nombre_departamento varchar(60) not null,
nombre_departamento_resumido varchar(20) not null,

constraint pk_departamento primary key (id),
constraint uk_departamento unique(id_provincia,secuencia),
constraint fk_provincia_departamento foreign key (id_provincia) references actor.provinciaEstado(id)
);


create table actor.localidad(
id bigint not null,
id_provincia bigint null,
id_departamento bigint null,
codigo_localidad integer not null,
nombre_localidad varchar(60) not null,
nombre_localiad_resumido varchar(20) not null,
codigo_postal smallint null,

constraint pk_localidad primary key (id),
constraint uk_localidad unique (codigo_localidad),
constraint fk_departamento_localidad foreign key (id_departamento) references actor.departamento(id),
constraint fk_provincia_localidad foreign key (id_provincia) references actor.provinciaEstado(id)
);

create table actor.direccionActor(
id bigint not null,
id_actor bigint not null,
id_localidad bigint  null,
secuencia smallint not null,
domicilio varchar(255) null,
calle varchar(255) null,
departamento varchar(255) null,
numero_portal integer null,
piso varchar(255) null,
edificio varchar(255) null,
manzana varchar(255) null,
monoblock varchar(255) null,
torre varchar(255) null,
vivienda varchar(255) null,
tipo_domicilio varchar(20) null,

constraint pk_direccion primary key (id),
constraint uk_direccion unique(id_actor,secuencia),
constraint fk_direccion_actor foreign key (id_actor) references actor.actor (id),
constraint fk_direccion_localidad foreign key (id_localidad) references actor.localidad(id),
constraint chk_tipo_domicilio check (tipo_domicilio in ('SUCURSAL','LABORAL','CASA_CENTRAL','FISCAL','OTRO','PARTICULAR'))
);

create table solicitud.motivo_rechazo(
id bigint not null,
codigo_motivo_rechazo smallint not null,
descripcion_motivo_rechazo varchar(120) not null,

constraint pk_motivo_rechazo primary key (id),
constraint uk_motivo_rechazo unique (codigo_motivo_rechazo)
);


create table solicitud.clase_licencia_conducir(
id bigint not null,
clase varchar(10) not null,
descripcion_clase varchar(255) not null,
edad_maxima smallint null,
edad_minima smallint not null,
fecha_baja DATE null,
observaciones varchar(255) null,
requiere_examen_psiquiatrico bit not null,
es_profesional bit not null,

constraint pk_clase_licencia primary key (id),
constraint uk_clase_licencia unique (clase)
);

alter table solicitud.clase_licencia_conducir
drop column requiere_examen_psiquiatrico;
alter table solicitud.clase_licencia_conducir
add column requiere_examen_psiquiatrico boolean not null;

alter table solicitud.clase_licencia_conducir
drop column es_profesional;
alter table solicitud.clase_licencia_conducir
add column es_profesional boolean not null;

create table solicitud.clase_licencia_conducir_requerida(
id bigint not null,
secuencia smallint not null,
id_clase_lic_conducir_1 bigint not null,
id_clase_lic_conducir_2 bigint not null,
tenencia_minima smallint not null,

constraint pk_clcr primary key (id),
constraint uk_clcr unique (secuencia,id_clase_lic_conducir_1),
constraint fk_clcr_clc1 foreign key (id_clase_lic_conducir_1) references solicitud.clase_licencia_conducir(id),
constraint fk_clcr_clc2 foreign key (id_clase_lic_conducir_2) references solicitud.clase_licencia_conducir(id)
);

create table solicitud.solicitud_licencia_conductor(
id bigint not null,
numero integer not null,
id_persona_f bigint not null,
id_localidad bigint null,
id_usuario bigint not null,
id_motivo_rechazo bigint null,
domicilio varchar(255) not null,
fecha DATE not null,
libre_multa bit not null,
corresponde_charla varchar(60) not null,
corresponde_psiquiatrico varchar(60) not null,
corresponde_teorico varchar(60) not null,
corresponde_fisico varchar(60) not null,
tipo varchar(60) not null,
calle varchar(255) not null,
departamento varchar(255) not null,
numero_postal integer not null,
piso varchar(255) not null,
fecha_vencimiento DATE null,

constraint pk_slc primary key (id),
constraint uk_slc unique(numero),
constraint fk_slc_persona_f foreign key (id_persona_f) references actor.personaFisica(id),
constraint fk_slc_localidad foreign key (id_localidad) references actor.localidad(id),
constraint fk_slc_usuario foreign key (id_usuario) references actor.usuario(id),
constraint fk_slc_motivo_rechazo foreign key (id_motivo_rechazo) references solicitud.motivo_rechazo(id),
constraint chk_tipo check (tipo in ('PROFESIONAL','COMUN'))
);

alter table solicitud.solicitud_licencia_conductor
drop column libre_multa;
alter table solicitud.solicitud_licencia_conductor
add column libre_multa boolean not null;

create table solicitud.estado_solicitud_licencia_conductor(
id bigint not null,
id_solicitud_licencia bigint not null,
item smallint not null,
tipo varchar(60) not null,

constraint pk_eslc primary key(id),
constraint uk_eslc unique (id_solicitud_licencia,item),
constraint fk_eslc_slc foreign key (id_solicitud_licencia) references solicitud.solicitud_licencia_conductor(id),
constraint chk_tipo check (tipo in ('EXAMEN_PSIQUIATRICO_NO_APTO','EXAMEN_PRACTICO_APROBADO','PRESENTADA','EXAMEN_PRACTICO_PARCIALMENTE_APROBADO',
'APROBADA_SIMUCO','EXAMEN_PSICO_FISICO_INTERCONSULTA','EXAMEN_PRACTICO_REPROBADO_N_VECES','RECHAZADA',
'EXAMEN_PSIQUIATRICO_APTO_PRACTICO_N_VECES','EXAMEN_TEORICO_REPROBADO_N_VECES','EXAMEN_PRACTICO_REPROBADO',
'EXAMEN_PSIQUIATRICO_APTO_TEORICO_N_VECES','EXAMEN_PSICO_FISICO_NO_APTO','EXAMEN_PSICO_FISICO_APTO_CON_RESTRICCIONES','EXAMEN_PSICO_FISICO_APTO',
'APROBADA','EXAMEN_PSIQUIATRICO_APTO','EXAMEN_TEORICO_APROBADO','PARCIALMENTE_APROBADA','EXAMEN_TEORICO_REPROBADO'))
);


create table solicitud.solicitud_licencia_conductor_clase(
id bigint not null,
secuencia smallint not null,
id_solicitud_licencia_conducir bigint not null,
id_clase_licencia_conducir bigint not null,
id_solicitud_rechazo bigint  null,
fecha_rechazo DATE null,
tipo_gestion varchar(60) not null,
fecha_impresion DATE null,
fecha_validacion_final DATE null,
fecha_entrega DATE null,
corresponde_charla varchar(60) not null,
corresponde_fisico varchar(60) not null,
corresponde_psiquiatrico varchar(60) not null,
fecha_practico DATE null,
resultado_practico varchar(60) not null,

constraint pk_slcc primary key (id),
constraint uk_slcc unique (secuencia,id_solicitud_licencia_conducir),
constraint fk_slcc_slc foreign key (id_solicitud_licencia_conducir) references solicitud.solicitud_licencia_conductor(id),
constraint fk_slcc_clc foreign key (id_clase_licencia_conducir) references solicitud.clase_licencia_conducir(id),
constraint fk_slcc_mr foreign key (id_solicitud_rechazo) references solicitud.motivo_rechazo(id),
constraint chk_tipo_gestion check (tipo_gestion in('REVALIDA_ANUAL','EXTRAVIO','RENOVACION','AMPLIACION','NUEVO','PROVINCIAL_A_NACIONAL','CAMBIO_DATOS'))
);


create table solicitud.estado_solicitud_licencia(
id bigint not null,
id_estado bigint null,
id_solicitud bigint null,

constraint pk_esl primary key (id),
constraint uk_esl unique(id_estado,id_solicitud),
constraint fk_esl_slc foreign key (id_solicitud) references solicitud.solicitud_licencia_conductor(id),
constraint fk_esl_eslc foreign key (id_estado) references solicitud.estado_solicitud_licencia_conductor(id)
);

create table solicitud.subtributo(
id bigint not null,
codigo_subtributo smallint not null,
nombre_subtributo varchar(120) null,

constraint pk_sub primary key(id),
constraint uk_sub unique (codigo_subtributo)
);

create table solicitud.concepto_medico(
id bigint not null,
codigo_concepto_medico smallint not null,
nombre_concepto varchar(60) not null,

constraint pk_cm primary key (id),
constraint uk_cm unique(codigo_concepto_medico)
);

create table solicitud.liquidacion_solicitud_licencia_conducir(
id bigint not null,
id_solicitud_licencia bigint not null,
numero integer not null,
id_usuario bigint null,
fecha DATE not null,
fecha_pago DATE null,
fecha_vencimiento DATE not null,
importe_total integer not null,
pagada bit not null,
tipo varchar(60) not null,
tipo_pago varchar(60) not null,

constraint pk_lslc primary key(id),
constraint uk_lslc unique(numero),
constraint fk_lslc_usuario foreign key (id_usuario) references actor.usuario(id),
constraint fk_lslc_solicitud_licencia foreign key (id_solicitud_licencia) references solicitud.solicitud_licencia_conductor(id),
constraint chk_tipo check(tipo in('MEDICO_VENCIMIENTO','MEDICO_COMUN','MEDICO_JUNTA','TASA_ACTUACION_ADMINISTRATIVA_DUPLICADO','TASA_ACTUACION_ADMINISTRATIVA_DIFERENCIAL','TASA_ACTUACION_ADMINISTRATIVA')),
constraint chk_tipo_pago check(tipo_pago in('NO INFORMADO','USUARIO','COMUN'))
);

alter table solicitud.liquidacion_solicitud_licencia_conducir
drop column pagada;
alter table solicitud.liquidacion_solicitud_licencia_conducir
add column pagada boolean not null; 
alter table solicitud.liquidacion_solicitud_licencia_conducir
drop column importe_total;
alter table solicitud.liquidacion_solicitud_licencia_conducir
add column importe_total numeric(19,2) not null;

create table solicitud.detalle_liquidacion_solicitud_licencia_conductor(
id bigint not null,
id_liquidacion_solicitud bigint not null,
secuencia smallint not null,
id_subtributo bigint null,
id_concepto_medico bigint null,
cantidad smallint not null,
importe numeric(19,2) not null,

constraint pk_dlslc primary key(id),
constraint uk_dlslc unique (id_liquidacion_solicitud,secuencia),
constraint fk_dlslc_lslc foreign key(id_liquidacion_solicitud) references solicitud.liquidacion_solicitud_licencia_conducir(id),
constraint fk_dlslc_subtributo foreign key (id_subtributo) references solicitud.subtributo (id),
constraint fk_dlslc_concepto_medico foreign key (id_concepto_medico) references solicitud.concepto_medico (id)
);


create index idx_usuario_ape_nom on actor.usuario(apellido_nombre);
create index idx_persona_juridica_nombre_fantasia on actor.personaJuridica(nombre_fantasia);
create index idx_organismo_nombre_organismo on actor.organismo(nombre_organismo);
create index idx_apellido_nombre_persona_fisica on actor.personaFisica(apellido,nombre);
create index idx_ocupacion_nombre on actor.ocupacion(nombre_ocupacion);
create index idx_funcion_nommbre on actor.funcion(nombre_funcion);
create index idx_localidad_nombre on actor.localidad(nombre_localidad);


