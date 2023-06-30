select * from jugadores;

-- Mostrar el nombre de todos los jugadores ordenados alfabéticamente.

select Nombre
from jugadores
order by Nombre ASC;

/*Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras,
ordenados por nombre alfabéticamente.*/

select Nombre
from jugadores
where Posicion = 'C' and Peso > 200
order by Nombre ASC;

-- Mostrar el nombre de todos los equipos ordenados alfabéticamente.
select Nombre
from equipos
order by Nombre ASC; 

-- Mostrar el nombre de los equipos del este (East).
select Nombre
from equipos
where Conferencia = 'East';

-- Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
select Nombre, Ciudad
from equipos
where Ciudad like 'C%'
order by nombre ASC;

-- Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
select Nombre, nombre_equipo
from jugadores
order by nombre_equipo;

-- Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
select Nombre
from jugadores
where nombre_equipo = 'Raptors'
order by nombre;

-- Mostrar los puntos por partido del jugador ‘Pau Gasol’.
select Puntos_por_partido, jugadores.nombre
from estadisticas, jugadores
where jugadores.nombre = 'Pau Gasol';

-- Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
select Puntos_por_partido, jugadores.nombre
from estadisticas, jugadores
where jugadores.nombre = 'Pau Gasol' and temporada = '04/05';

-- Mostrar el número de puntos de cada jugador en toda su carrera.
select Nombre, Puntos_por_partido, temporada
from estadisticas, jugadores
order by Nombre;

-- Mostrar el número de jugadores de cada equipo.
select count(Nombre_equipo), Nombre_equipo
from jugadores
group by Nombre_equipo;

-- Mostrar el jugador que más puntos ha realizado en toda su carrera. Revisar 
SELECT j.nombre AS jugador, SUM(e.puntos_por_partido) AS total_puntos
FROM jugadores j
JOIN estadisticas e ON j.codigo = e.jugador
GROUP BY j.nombre
ORDER BY total_puntos DESC
LIMIT 1;

-- Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
SELECT e.Nombre AS equipo, e.Conferencia, e.Division
FROM jugadores j
JOIN equipos e ON j.Nombre_equipo = e.Nombre
WHERE j.altura = (
    SELECT MAX(altura)
    FROM jugadores
)
LIMIT 1;

-- Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.
SELECT equipo_local, equipo_visitante, ABS(puntos_local - puntos_visitante) AS diferencia
FROM partidos
ORDER BY diferencia DESC
LIMIT 1;

-- Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), en caso de empate sera null.
SELECT codigo, equipo_local, equipo_visitante,
CASE
WHEN puntos_local > puntos_visitante THEN equipo_local
WHEN puntos_local < puntos_visitante THEN equipo_visitante
ELSE NULL
END AS equipo_ganador
FROM partidos;








