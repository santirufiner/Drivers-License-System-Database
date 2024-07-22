----------------------------------------------------------------------------------------------------
----------------------- EJERCICIO 3 - TP 2 - CONSULTAS SOBRE DATOS IMPORTADOS ----------------------
----------------------------------------------------------------------------------------------------

-- 1. Cantidad total de actores, agrupados y ordenados por tipo PF O PJ.

SELECT 'PF' AS tipo_actor, COUNT(*) AS "TOTAL actores"
	FROM actor.actor A INNER JOIN actor.personaFisica PF 
		ON A.id = PF.id_actor
	UNION
SELECT 'PJ' AS tipo_actor, COUNT(*) AS "TOTAL actores"
	FROM actor.actor A INNER JOIN actor.personaJuridica PJ 
		ON A.id = PJ.id_actor
ORDER BY tipo_actor;

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Clasificación de personas por ocupación: informar total por ocupación, ordenado por ocupación.

SELECT nombre_ocupacion, COUNT(*) AS "TOTAL personas"
	FROM actor.personaFisica PF INNER JOIN actor.ocupacion OC 
		ON PF.id_ocupacion = OC.id
	GROUP BY nombre_ocupacion
	ORDER BY nombre_ocupacion;
	
-- La salida cuenta pocas personas fisicas porque en la gran mayoria no está especificada la ocupación

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3. Cantidad de solicitudes presentadas por período (año/mes). Codificar una función que permita pasar como parámetros “año-mes desde” y “año-mes hasta”. 
-- La función debe retornar una fila para cada año-mes dentro del rango pasado como parámetros.

-- Creamos el tipo de dato cantidadSolicitudesLCxPeriodo para guardarnos la fecha y la cantidad de solicitudes x fecha 
CREATE TYPE cantidadSolicitudesLCxPeriodo AS (

	fecha date,
	cantidad_solicitudes_LC integer
	
);

CREATE OR REPLACE FUNCTION verCantidadSolicitudesLC(IN año_mes_desde date, IN año_mes_hasta date)

	RETURNS setof cantidadSolicitudesLCxPeriodo
	AS
	$$
	DECLARE
		-- Creamos el dato fecha_inicio para utilizarlo como contador en el bucle, la fecha_fin como cond de stop y el dato fila del tipo que definimos previamente
		fecha_inicio date := año_mes_desde;
		fecha_fin date := año_mes_hasta;
		fila cantidadSolicitudesLCxPeriodo;
		
	BEGIN
	
		WHILE fecha_inicio <= fecha_fin LOOP
		
			-- Usamos la función DATE_TRUNC para truncar la fecha y quedarnos solo con el mes de cada una
			SELECT DATE_TRUNC('month', fecha_inicio), COUNT(*) INTO fila.fecha, fila.cantidad_solicitudes_LC
				FROM solicitud.solicitud_licencia_conductor
					WHERE DATE_TRUNC('month', fecha) = DATE_TRUNC('month', fecha_inicio)
				GROUP BY DATE_TRUNC('month', fecha);

			-- Retornamos la fila del mes-año correspondiente
			RETURN NEXT fila;

			-- Actualizamos el contador de la fecha para avanzar al mes siguiente
			fecha_inicio := fecha_inicio + INTERVAL '1 month';
			
		END LOOP;
		
	END;
	$$
	LANGUAGE plpgsql

-- Llamada de la función
SELECT * FROM verCantidadSolicitudesLC('2016-01-01'::date, '2023-06-01'::date);

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4. Clasificación de las solicitudes por estado. Codificar una función que permita pasar como parámetros “año-mes desde” y “año-mes hasta”. 
-- La función debe retornar una fila para cada año-mes dentro del rango pasado como parámetros. La salida debe incluir para cada mes,
-- una columna para cada estado distinto, donde se muestre la cantidad total de solicitudes que se encuentran en cada estado. Considerar unicamente el estado actual.

CREATE OR REPLACE FUNCTION verCantidadSolicitudesLCPorEstado(in año_mes_desde date, in año_mes_hasta date) 

	RETURNS TABLE (
		anio_mes varchar(7),
		examen_psiquiatrico_no_apto bigint,
		examen_practico_aprobado bigint,
		presentada bigint,
		examen_practico_parcialmente_aprobado bigint,
		aprobada_simuco bigint,
		examen_psico_fisico_interconsulta bigint,
		examen_practico_reprobado_n_veces bigint,
		rechazada bigint,
		examen_psiquiatrico_apto_practico_n_veces bigint,
		examen_teorico_reprobado_n_veces bigint,
		examen_practico_reprobado bigint,
		examen_psiquiatrico_apto_teorico_n_veces bigint,
		examen_psico_fisico_no_apto bigint,
		examen_psico_fisico_apto_con_restricciones bigint,
		examen_psico_fisico_apto bigint,
		aprobada bigint,
		examen_psiquiatrico_apto bigint,
		examen_teorico_aprobado bigint,
		parcialmente_aprobada bigint,
		examen_teorico_reprobado bigint
	) 
	AS 
	$$
	DECLARE
		-- Creamos el dato fecha_inicio para utilizarlo como contador en el bucle, la fecha_fin como cond de stop y el anio_mes_actual para ir imprimiendolo en la columna de anio_mes
		fecha_inicio date := DATE_TRUNC('month', año_mes_desde);
		fecha_fin date := DATE_TRUNC('month', año_mes_hasta);
		anio_mes_actual varchar(7);

	BEGIN

		WHILE fecha_inicio <= fecha_fin LOOP

			anio_mes_actual := to_char(fecha_inicio, 'YYYY-MM');

		RETURN QUERY
			SELECT anio_mes_actual,
			-- Por cada ocurrencia que encuentre sumamos 1 al contador de cada tipo de estado de solicitud
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_PSIQUIATRICO_NO_APTO' THEN 1 END) AS examen_psiquiatrico_no_apto,
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_PRACTICO_APROBADO' THEN 1 END) AS examen_practico_aprobado,
			COUNT(CASE WHEN estadoSLC.tipo = 'PRESENTADA' THEN 1 END) AS presentada,
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_PRACTICO_PARCIALMENTE_APROBADO' THEN 1 END) AS examen_practico_parcialmente_aprobado,
			COUNT(CASE WHEN estadoSLC.tipo = 'APROBADA_SIMUCO' THEN 1 END) AS aprobada_simuco,
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_PSICO_FISICO_INTERCONSULTA' THEN 1 END) AS examen_psico_fisico_interconsulta,
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_PRACTICO_REPROBADO_N_VECES' THEN 1 END) AS examen_practico_reprobado_n_veces,
			COUNT(CASE WHEN estadoSLC.tipo = 'RECHAZADA' THEN 1 END) AS rechazada,
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_PSIQUIATRICO_APTO_PRACTICO_N_VECES' THEN 1 END) AS examen_psiquiatrico_apto_practico_n_veces,
			COUNT(CASE WHEN estadoSLC.tipo= 'EXAMEN_TEORICO_REPROBADO_N_VECES' THEN 1 END) AS examen_teorico_reprobado_n_veces,
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_PRACTICO_REPROBADO' THEN 1 END) AS examen_practico_reprobado,
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_PSIQUIATRICO_APTO_TEORICO_N_VECES' THEN 1 END) AS examen_psiquiatrico_apto_teorico_n_veces,
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_PSICO_FISICO_NO_APTO' THEN 1 END) AS examen_psico_fisico_no_apto,
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_PSICO_FISICO_APTO_CON_RESTRICCIONES' THEN 1 END) AS examen_psico_fisico_apto_con_restricciones,
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_PSICO_FISICO_APTO' THEN 1 END) AS examen_psico_fisico_apto,
			COUNT(CASE WHEN estadoSLC.tipo = 'APROBADA' THEN 1 END) AS aprobada,
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_PSIQUIATRICO_APTO' THEN 1 END) AS examen_psiquiatrico_apto,
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_TEORICO_APROBADO' THEN 1 END) AS examen_teorico_aprobado,
			COUNT(CASE WHEN estadoSLC.tipo = 'PARCIALMENTE_APROBADA' THEN 1 END) AS parcialmente_aprobada,
			COUNT(CASE WHEN estadoSLC.tipo = 'EXAMEN_TEORICO_REPROBADO' THEN 1 END) AS examen_teorico_reprobado
				FROM solicitud.estado_solicitud_licencia_conductor estadoSLC INNER JOIN solicitud.solicitud_licencia_conductor SLC 
					ON estadoSLC.id_solicitud_licencia = SLC.id
				-- Como DATE_TRUNC redondea la fecha al primer dia del mes, agregamos el intervalo de 1 mes - 1 dia, asi cubrimos el mes completo
				WHERE SLC.fecha BETWEEN fecha_inicio AND fecha_inicio + INTERVAL '1 month' - INTERVAL '1 day';

			-- Actualizamos el contador de la fecha para avanzar al mes siguiente
			fecha_inicio := fecha_inicio + INTERVAL '1 month';

		END LOOP;
	END; 
	$$ 
	LANGUAGE plpgsql

-- Llamada de la función
SELECT * FROM verCantidadSolicitudesLCPorEstado('2016-01-01'::date, '2023-06-01'::date);
