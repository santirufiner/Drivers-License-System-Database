----------------------------------------------------------------------------------------------------
----------------------------- EJERCICIO 4 - TP 2 - CREACION DE TRIGGERS ----------------------------
----------------------------------------------------------------------------------------------------

create schema auditoria;


create table auditoria.localidad(
id_fila_afectada bigint not null,
usuario varchar (255) not null,
momento date not null,
instruccion varchar(255) not null,

id_nuevo bigint null,
id_provincia_nuevo bigint null,
id_departamento_nuevo bigint null,
codigo_localidad_nuevo integer null,
nombre_localidad_nuevo varchar(60)  null,
nombre_localiad_resumido_nuevo varchar(20) null,
codigo_postal_nuevo smallint null,

id_viejo bigint null,
id_provincia_viejo bigint null,
id_departamento_viejo bigint null,
codigo_localidad_viejo integer  null,
nombre_localidad_viejo varchar(60)  null,
nombre_localiad_resumido_viejo varchar(20)  null,
codigo_postal_viejo smallint null
);

create table auditoria.solicitud_licencia_conductor(
id_fila_afectada bigint not null,
usuario varchar (255) not null,
momento date not null,
instruccion varchar(255) not null,

id_nuevo bigint  null,
numero_nuevo integer  null,
id_persona_f_nuevo bigint  null,
id_localidad_nuevo bigint null,
id_usuario_nuevo bigint  null,
id_motivo_rechazo_nuevo bigint null,
domicilio_nuevo varchar(255) null,
fecha_nuevo DATE null,
libre_multa_nuevo bit  null,
corresponde_charla_nuevo varchar(60)  null,
corresponde_psiquiatrico_nuevo varchar(60)  null,
corresponde_teorico_nuevo varchar(60)  null,
corresponde_fisico_nuevo varchar(60)  null,
tipo_nuevo varchar(60) null,
calle_nuevo varchar(255)  null,
departamento_nuevo varchar(255)  null,
numero_postal_nuevo integer  null,
piso_nuevo varchar(255)  null,
fecha_vencimiento_nuevo DATE null,
id_estado_actual_solicitudLC_nuevo bigint null,

id_viejo bigint  null,
numero_viejo integer  null,
id_persona_f_viejo bigint  null,
id_localidad_viejo bigint null,
id_usuario_viejo bigint null,
id_motivo_rechazo_viejo bigint null,
domicilio_viejo varchar(255)  null,
fecha_viejo DATE  null,
libre_multa_viejo bit  null,
corresponde_charla_viejo varchar(60)  null,
corresponde_psiquiatrico_viejo varchar(60)  null,
corresponde_teorico_viejo varchar(60)  null,
corresponde_fisico_viejo varchar(60)  null,
tipo_viejo varchar(60)  null,
calle_viejo varchar(255)  null,
departamento_viejo varchar(255)  null,
numero_postal_viejo integer  null,
piso_viejo varchar(255)  null,
fecha_vencimiento_viejo DATE null,
id_estado_actual_solicitudLC_viejo bigint null
);



create table auditoria.persona_fisica(
id_fila_afectada bigint not null,
usuario varchar (255) not null,
momento date not null,
instruccion varchar(255) not null,

id_nuevo bigint  null,
id_ocupacion_nuevo bigint null,
id_actor_nuevo bigint  null,
documento_identidad_tipo_nuevo varchar(1) null,
documento_identidad_numero_nuevo integer  null,
apellido_nuevo varchar(255) null,
fecha_nacimiento_nuevo DATE  null,
nombre_nuevo varchar(255) null,
movil_principal_nuevo varchar(255) null,
sexo_nuevo char(1)  null,
apellido_materno_nuevo varchar(255) null,
donante_organos_nuevo varchar(255) null,
email_principal_nuevo varchar(255) null,
identidad_genero_nuevo varchar(255) null,
estado_civil_nuevo char(1)  null,

id_viejo bigint  null,
id_ocupacion_viejo bigint null,
id_actor_viejo bigint  null,
documento_identidad_tipo_viejo varchar(1)  null,
documento_identidad_numero_viejo integer  null,
apellido_viejo varchar(255)  null,
fecha_nacimiento_viejo DATE null,
nombre_viejo varchar(255)  null,
movil_principal_viejo varchar(255) null,
sexo_viejo char(1)  null,
apellido_materno_viejo varchar(255) null,
donante_organos_viejo varchar(255) null,
email_principal_viejo varchar(255) null,
identidad_genero_viejo varchar(255) null,
estado_civil_viejo char(1)  null

);


---Funciones trigger insert para las tablas

create or replace function auditoria_insert_localidad()
returns trigger
language plpgsql
as
$$
declare
begin
insert into auditoria.localidad values (new.id,session_user,current_timestamp,'INSERT',new.id,new.id_provincia,
new.id_departamento,new.codigo_localidad,new.nombre_localidad,new.nombre_localiad_resumido,new.codigo_postal,null,null,null,null,null,null,null); 
return new;
end;
$$;

create or replace function auditoria_insert_solicitud_licencia_conductor()
returns trigger
language plpgsql
as
$$
declare
begin
insert into auditoria.solicitud_licencia_conductor values (new.id,session_user,current_timestamp,'INSERT',new.id,new.numero,new.id_persona_f, new.id_localidad,new.id_usuario,new.id_motivo_rechazo,
new.domicilio,new.fecha,new.libre_multa,new.corresponde_charla,new.corresponde_psiquiatrico, new.corresponde_teorico,new.corresponde_fisico,new.tipo,new.calle,new.departamento,new.numero_postal,
new.piso,new.fecha_vencimiento,new.id_estado_actual_solicitudLC,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null); 
return new;
end;
$$;


create or replace function auditoria_insert_persona_fisica()
returns trigger
language plpgsql
as
$$
declare
begin
insert into auditoria.persona_fisica values (new.id,session_user,current_timestamp,'INSERT',new.id,new.id_ocupacion,new.id_actor,new.documento_identidad_tipo,new.documento_identidad_numero,new.apellido,
new.fecha_nacimiento,new.nombre,new.movil_principal,new.sexo,new.apellido_materno,new.donante_organos,new.email_principal,new.identidad_genero,new.estado_civil,null,null,null,null,null,null,null,null,null,
null,null,null,null,null,null); 
return new;
end;
$$;

---Funciones trigger delete para tablas

create or replace function auditoria_delete_localidad()
returns trigger
language plpgsql
as
$$
declare 
begin
insert into auditoria.localidad values (old.id,session_user,current_timestamp,'DELETE',null,null,null,null,null,null,null,old.id,old.id_provincia,
old.id_departamento,old.codigo_localidad,old.nombre_localidad,old.nombre_localiad_resumido,old.codigo_postal); 
return old;
end;
$$;

create or replace function auditoria_delete_solicitud_licencia_conductor()
returns trigger
language plpgsql
as
$$
declare 
begin
insert into auditoria.solicitud_licencia_condcuctor values (old.id,session_user,current_timestamp,'DELETE',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,
old.id,old.numero,old.id_persona_f, old.id_localidad,old.id_usuario,old.id_motivo_rechazo,old.domicilio,old.fecha,old.libre_multa,old.corresponde_charla,old.corresponde_psiquiatrico, 
old.corresponde_teorico,old.corresponde_fisico,old.tipo,old.calle,old.departamento,old.numero_postal,old.piso,old.fecha_vencimiento,old.id_estado_actual_solicitudLC); 
return old;
end;
$$;

create or replace function auditoria_delete_persona_fisica()
returns trigger
language plpgsql
as
$$
declare
begin
insert into auditoria.persona_fisica values (old.id,session_user,current_timestamp,'DELETE',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,old.id,old.id_ocupacion,old.id_actor,
old.documento_identidad_tipo,old.documento_identidad_numero,old.apellido,old.fecha_nacimiento,old.nombre,old.movil_principal,old.sexo,old.apellido_materno,
old.donante_organos,old.email_principal,old.identidad_genero,old.estado_civil);
return old;
end;
$$;


---Funciones trigger update para tablas

create or replace function auditoria_update_localidad()
returns trigger
language plpgsql
as
$$
declare 
begin
insert into auditoria.localidad values (new.id,session_user,current_timestamp,'UPDATE',new.id,new.id_provincia,
new.id_departamento,new.codigo_localidad,new.nombre_localidad,new.nombre_localiad_resumido,new.codigo_postal,old.id,old.id_provincia,
old.id_departamento,old.codigo_localidad,old.nombre_localidad,old.nombre_localiad_resumido,old.codigo_postal); 
return new;
end
$$;



create or replace function auditoria_update_solicitud_licencia_conductor()
returns trigger
language plpgsql
as
$$
declare
begin
insert into auditoria.solicitud_licencia_conductor values (new.id,session_user,current_timestamp,'UPDATE',new.id,new.numero,new.id_persona_f, new.id_localidad,new.id_usuario,new.id_motivo_rechazo,
new.domicilio,new.fecha,new.libre_multa,new.corresponde_charla,new.corresponde_psiquiatrico, new.corresponde_teorico,new.corresponde_fisico,new.tipo,new.calle,new.departamento,new.numero_postal,
new.piso,new.fecha_vencimiento,new.id_estado_actual_solicitudLC,old.id,old.numero,old.id_persona_f, old.id_localidad,old.id_usuario,old.id_motivo_rechazo,old.domicilio,old.fecha,old.libre_multa,old.corresponde_charla,old.corresponde_psiquiatrico, 
old.corresponde_teorico,old.corresponde_fisico,old.tipo,old.calle,old.departamento,old.numero_postal,old.piso,old.fecha_vencimiento,old.id_estado_actual_solicitudLC); 
return new;
end
$$;

create or replace function auditoria_update_persona_fisica()
returns trigger
language plpgsql
as
$$
declare 
begin
insert into auditoria.persona_fisica values (new.id,session_user,current_timestamp,'UPDATE',new.id,new.id_ocupacion,new.id_actor,new.documento_identidad_tipo,new.documento_identidad_numero,new.apellido,
new.fecha_nacimiento,new.nombre,new.movil_principal,new.sexo,new.apellido_materno,new.donante_organos,new.email_principal,new.identidad_genero,new.estado_civil,old.id,old.id_ocupacion,old.id_actor,
old.documento_identidad_tipo,old.documento_identidad_numero,old.apellido,old.fecha_nacimiento,old.nombre,old.movil_principal,old.sexo,old.apellido_materno,
old.donante_organos,old.email_principal,old.identidad_genero,old.estado_civil); 
return new;
end
$$;



---TRIGGER TABLAS PARA INSERT
create trigger tr_auditoria_localidad_insert
before insert on actor.localidad for each row
execute procedure auditoria_insert_localidad();

create trigger tr_auditoria_solicitud_licencia_conductor_insert
before insert on solicitud.solicitud_licencia_conductor for each row
execute procedure auditoria_insert_solicitud_licencia_conductor();

create trigger tr_auditoria_persona_fisica_insert
before insert on actor.personafisica for each row
execute procedure auditoria_insert_persona_fisica();

---TRIGGER TABLAS PARA DELETE
create trigger tr_auditoria_localidad_delete
before delete on actor.localidad for each row
execute procedure auditoria_delete_localidad();

create trigger tr_auditoria_solicitud_licencia_conductor_delete
before delete on solicitud.solicitud_licencia_conductor for each row
execute procedure auditoria_delete_solicitud_licencia_conductor();

create trigger tr_auditoria_persona_fisica_delete
before delete on actor.personafisica for each row
execute procedure auditoria_delete_persona_fisica();


---TRIGGER TABLAS PARA UPDATE 

create trigger tr_auditoria_localidad_update
before update on actor.localidad for each row
execute procedure auditoria_update_localidad();

create trigger tr_auditoria_solicitud_licencia_conductor_update
before update on solicitud.solicitud_licencia_conductor for each row
execute procedure auditoria_update_solicitud_licencia_conductor();

create trigger tr_auditoria_persona_fisica_update
before update on actor.personafisica for each row
execute procedure auditoria_update_persona_fisica();

