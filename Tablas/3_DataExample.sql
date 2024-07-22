-----------------------------------------------------------------------
---------------------- INSERCION DE DATOS -----------------------------
----------------------------------------------------------------------- 

insert into actor.pais values (01,1,'ARGENTINA','ARG','ARGENTINO');
insert into actor.actor (id,codigo_actor,fecha_alta,id_pais) values (01,1,'25/09/2023',01);
insert into actor.usuario values (01,012,'MONGO AURELIO','25-09-2023');
insert into actor.rol values (01,01,'MEDICO',1);
insert into actor.ocupacion values (01,1,'PROFESOR','PRO');
insert into actor.personaFisica values (01,01,01,'D',23019202,'BOTTO','23/01/1999','ALEXIS','3491-501314','M','ZARATE','N','robe@gmail.com','M','S');
insert into actor.tipoPersonaJuridica values(01,1,'sin fines de lucro','sfl');
insert into actor.PersonaJuridica values (01,01,01,'UN MANGUITO POR FAVOR','MANGUITO OSFC');
insert into actor.organismo values (01,01,'PUBLICO');
insert into actor.funcion values (01,1,'SOCIAL');
insert into actor.integraPersonaJuridica values(01,01,1,01,01,'25-09-2023');
insert into actor.integraOrganismo values (01,01,01,01,1,'25-09-2023');
insert into actor.actor_usuario values(01,01);
insert into actor.provinciaEstado values (01,01,1,'SANTA FE','STA.FE');
insert into actor.departamento values (01,01,1,1,'LA CAPITAL','CAP');
insert into actor.localidad values (01,01,01,1,'SANTA FE','STA.FE',3000);
insert into actor.direccionActor (id,id_actor,id_localidad,secuencia,domicilio,tipo_domicilio) values (01,01,01,1,'EL POZO 2800','PARTICULAR');

insert into solicitud.motivo_rechazo values (01,1,'MALA SUERTE');
insert into solicitud.clase_licencia_conducir (id,clase,descripcion_clase,edad_maxima,edad_minima,requiere_examen_psiquiatrico,es_profesional) values (01,'B1','MOTOS',80,18,false,false);
insert into solicitud.clase_licencia_conducir_requerida values (01,1,01,01,4);
insert into solicitud.solicitud_licencia_conductor values (01,1,01,01,01,01,'EL POZO 2800','25-09-2023','NO','NO','NO','NO','COMUN','-','-',3000,'-','25-09-2030',true);
insert into solicitud.solicitud_licencia_conductor_clase(id,secuencia,id_solicitud_licencia_conducir,id_clase_licencia_conducir,tipo_gestion,corresponde_charla,corresponde_fisico,corresponde_psiquiatrico,resultado_practico)
values (01,1,01,01,'NUEVO','NO','NO','NO','APROBADO');
insert into solicitud.estado_solicitud_licencia_conductor values(01,01,1,'APROBADA');
insert into solicitud.estado_solicitud_licencia values (01,01,01);
insert into solicitud.liquidacion_solicitud_licencia_conducir values (01,01,1,01,'25-09-2023','25-09-2023','25-09-2024','TASA_ACTUACION_ADMINISTRATIVA','NO INFORMADO',true,1950.05);
insert into solicitud.subtributo values(01,1,'tributo');
insert into solicitud.concepto_medico values (01,1,'lesion');
insert into solicitud.detalle_liquidacion_solicitud_licencia_conductor values (01,01,1,01,01,1,1950.05);