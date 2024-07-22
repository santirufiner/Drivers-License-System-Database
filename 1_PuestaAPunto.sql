----------------------------------------------------------------------------------------------------
------------------------------- EJERCICIO 1 - TP 2 - PUESTA A PUNTO --------------------------------
----------------------------------------------------------------------------------------------------

-- a) Corrección de errores

-- Cerrar create table de solicitud.detalle_liquidacion_solicitud_licencia_conductor agregando el punto y coma final (corregido)

-- Corregir restricción unique actor.rol
alter table actor.rol drop constraint uk_rol;
alter table actor.rol add constraint uk_rol unique (tipo_rol,codigo_rol);

-- Dropear las relaciones hechas de un modo complejo y rehacerlas de manera más sencilla (Actor-Usuario y SolicitudesLC-EstadoSLC)
drop table actor.Actor_usuario;
alter table actor.usuario add column id_actor bigint null;
alter table actor.usuario add constraint fk_actor_usuario foreign key (id_actor) references actor.actor(id);

drop table solicitud.estado_solicitud_licencia;
alter table solicitud.solicitud_licencia_conductor add column id_estado_actual_solicitudLC bigint null;
alter table solicitud.solicitud_licencia_conductor add constraint fk_solicitud_estadoLC foreign key (id_estado_actual_solicitudLC) references solicitud.estado_solicitud_licencia_conductor(id);

-- Agregar los index de las foreign keys
create index idx_actor_pais on actor.actor (id_pais);
create index idx_rol_actor on actor.rol (id_actor);
create index idx_actor_usuario on actor.usuario (id_actor);
create index idx_PJ_actor on actor.personaJuridica (id_actor);
create index idx_PJ_TPJ on actor.personaJuridica (id_tipo_persona);
create index idx_PF_actor on actor.personaFisica (id_actor);
create index idx_PF_ocupacion on actor.personaFisica (id_ocupacion);
create index idx_organismo_actor on actor.organismo (id_actor);
create index idx_personaf_IO on actor.integraOrganismo (id_persona_f);
create index idx_funcion_IO on actor.integraOrganismo (id_funcion);
create index idx_organismo on actor.integraOrganismo (id_organismo);
create index idx_iPJ_PF on actor.integraPersonaJuridica (id_persona_f);
create index idx_iPJ_PJ on actor.integraPersonaJuridica (id_persona_ju);
create index idx_iPJ_funcion on actor.integraPersonaJuridica (id_funcion);
create index idx_pais_provinciaEstado on actor.provinciaEstado (id_pais);
create index idx_provincia_departamento on actor.departamento (id_provincia);
create index idx_departamento_localidad on actor.localidad (id_departamento);
create index idx_provincia_localidad on actor.localidad (id_provincia);
create index idx_direccion_actor on actor.direccionActor (id_actor);
create index idx_direccion_localidad on actor.direccionActor (id_localidad);
create index idx_clcr_clc1 on solicitud.clase_licencia_conducir_requerida (id_clase_lic_conducir_1);
create index idx_clcr_clc2 on solicitud.clase_licencia_conducir_requerida (id_clase_lic_conducir_2);
create index idx_slc_persona_f on solicitud.solicitud_licencia_conductor (id_persona_f);
create index idx_slc_localidad on solicitud.solicitud_licencia_conductor (id_localidad);
create index idx_slc_usuario on solicitud.solicitud_licencia_conductor (id_usuario);
create index idx_slc_motivo_rechazo on solicitud.solicitud_licencia_conductor (id_motivo_rechazo);
create index idx_eslc_slc on solicitud.estado_solicitud_licencia_conductor (id_solicitud_licencia);
create index idx_slcc_slc on solicitud.solicitud_licencia_conductor_clase (id_solicitud_licencia_conducir);
create index idx_slcc_clc on solicitud.solicitud_licencia_conductor_clase (id_clase_licencia_conducir);
create index idx_slcc_mr on solicitud.solicitud_licencia_conductor_clase (id_solicitud_rechazo);
create index idx_lslc_usuario on solicitud.liquidacion_solicitud_licencia_conducir (id_usuario);
create index idx_lslc_solicitud_licencia on solicitud.liquidacion_solicitud_licencia_conducir (id_solicitud_licencia);
create index idx_dlslc_lslc on solicitud.detalle_liquidacion_solicitud_licencia_conductor (id_liquidacion_solicitud);
create index idx_dlslc_subtributo on solicitud.detalle_liquidacion_solicitud_licencia_conductor (id_subtributo);
create index idx_dlslc_concepto_medico on solicitud.detalle_liquidacion_solicitud_licencia_conductor (id_concepto_medico);


-- Otras correcciones

-- Alteramos los not null de actor.personaFisica para poder ingresar las tuplas de datos que tienen estos datos faltantes
alter table actor.personaFisica alter column fecha_nacimiento drop not null;
alter table actor.personaFisica alter column apellido drop not null;

-- A la constraint chk_estado de actor.personaFisica le faltaba una coma en los estados posibles
alter table actor.personaFisica drop constraint chk_estado;
alter table actor.personaFisica add constraint chk_estado check(estado_civil in('S','C','E','D','V','N'));

-- Cambio el tipo de dato de codigo_motivo_rechazo de la tabla solicitud.motivo_rechazo ya que voy a usar como codigo el mismo id (que es un bigint)
alter table solicitud.motivo_rechazo alter column codigo_motivo_rechazo type bigint;

-- Cambio el tipo de dato de numero_postal de la tabla solicitud.solicitud_licencia_conductor ya que muchos de los datos cargados son de tipo varchar
alter table solicitud.solicitud_licencia_conductor alter column numero_postal type varchar(50);

-- Cambio el check de tipo ya que en la hoja de calculo existen tipos de estado que no estaban en los check del MCD
alter table solicitud.estado_solicitud_licencia_conductor drop constraint chk_tipo;
alter table solicitud.estado_solicitud_licencia_conductor add constraint chk_tipo check (tipo in ('EXAMEN_PSIQUIATRICO_NO_APTO','EXAMEN_PRACTICO_APROBADO','PRESENTADA','EXAMEN_PRACTICO_PARCIALMENTE_APROBADO',
'APROBADA_SIMUCO','EXAMEN_PSICO_FISICO_INTERCONSULTA','EXAMEN_PRACTICO_REPROBADO_N_VECES','RECHAZADA',
'EXAMEN_PSIQUIATRICO_APTO_PRACTICO_N_VECES','EXAMEN_TEORICO_REPROBADO_N_VECES','EXAMEN_PRACTICO_REPROBADO',
'EXAMEN_PSIQUIATRICO_APTO_TEORICO_N_VECES','EXAMEN_PSICO_FISICO_NO_APTO','EXAMEN_PSICO_FISICO_APTO_CON_RESTRICCIONES','EXAMEN_PSICO_FISICO_APTO',
'APROBADA','EXAMEN_PSIQUIATRICO_APTO','EXAMEN_TEORICO_APROBADO','PARCIALMENTE_APROBADA','EXAMEN_TEORICO_REPROBADO','EXAMEN_PSICO_FISICO_NO_APTO_TEMPORARIO'));
alter table solicitud.estado_solicitud_licencia_conductor drop constraint chk_tipo; -- Dropeo igual check porque todavia tengo el mismo problema, hay checks que no estaban en el MCD

-- Dropeo los not null de las columnas de la tabla solicitud.solicitud_licencia_conductor que interfieren en la carga de datos (y que no son necesarios) 
alter table solicitud.solicitud_licencia_conductor alter column calle drop not null; 
alter table solicitud.solicitud_licencia_conductor alter column piso drop not null; 
alter table solicitud.solicitud_licencia_conductor alter column departamento drop not null;


-- b) Limpieza de datos

-- Deletes de datos de las tablas creadas en el tp N°1
delete from actor.direccionActor;
delete from solicitud.detalle_liquidacion_solicitud_licencia_conductor;
delete from solicitud.concepto_medico;
delete from solicitud.subtributo;
delete from solicitud.liquidacion_solicitud_licencia_conducir;
delete from solicitud.estado_solicitud_licencia_conductor;
delete from solicitud.solicitud_licencia_conductor_clase;
delete from solicitud.solicitud_licencia_conductor;
delete from solicitud.clase_licencia_conducir_requerida;
delete from solicitud.clase_licencia_conducir;
delete from solicitud.motivo_rechazo;
delete from actor.localidad;
delete from actor.departamento;
delete from actor.provinciaEstado;
delete from actor.integraOrganismo;
delete from actor.integraPersonaJuridica;
delete from actor.funcion;
delete from actor.organismo;
delete from actor.PersonaJuridica;
delete from actor.tipoPersonaJuridica;
delete from actor.personaFisica;
delete from actor.ocupacion;
delete from actor.rol;
delete from actor.usuario;
delete from actor.actor;
delete from actor.pais;