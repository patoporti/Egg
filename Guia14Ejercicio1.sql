SELECT * FROM empleados;
SELECT * FROM departamentos;
SELECT nombre_depto FROM departamentos;
SELECT nombre, sal_emp FROM empleados;
SELECT comision_emp FROM empleados; 
SELECT * FROM empleados WHERE cargo_emp = 'Secretaria';
SELECT * FROM empleados where cargo_emp = 'Vendedor' order by nombre ASC;
SELECT nombre, cargo_emp, sal_emp FROM empleados order by sal_emp;
SELECT sal_emp, comision_emp FROM empleados WHERE id_depto = 2000 ORDER BY comision_emp ASC;
SELECT nombre, sal_emp + comision_emp + 500 as sumatotal FROM empleados WHERE id_depto = 3000 ORDER BY nombre ASC;
SELECT nombre FROM empleados where nombre like 'j%';
SELECT sal_emp, comision_emp, sal_emp + comision_emp as salario_total, nombre FROM empleados WHERE comision_emp > 1000;
SELECT sal_emp, comision_emp, sal_emp + comision_emp as salario_total, nombre FROM empleados WHERE comision_emp = 0;
SELECT nombre, comision_emp, sal_emp FROM empleados WHERE comision_emp > sal_emp;
SELECT * FROM empleados WHERE comision_emp <= sal_emp * 0.3;
SELECT * FROM empleados WHERE nombre not like '%MA%';
SELECT * FROM departamentos WHERE nombre_depto IN ('Ventas', 'Investigación', 'Mantenimiento');
SELECT * FROM departamentos WHERE nombre_depto not IN ('Ventas', 'Investigación', 'Mantenimiento');
SELECT MAX(sal_emp) AS salario_maximo FROM empleados;
SELECT nombre FROM empleados order by nombre desc limit 1;
SELECT max(sal_emp) as maxsal, min(sal_emp) as minsal, max(sal_emp) - min(sal_emp) as difsal FROM empleados;
SELECT id_depto, AVG(sal_emp) AS salario_promedio FROM empleados GROUP BY id_depto;
SELECT id_depto, COUNT(*) AS cantidad_empleados FROM empleados GROUP BY id_depto HAVING COUNT(*) > 3; 
SELECT id_depto FROM departamentos WHERE id_depto NOT IN (SELECT id_depto FROM empleados);
select * from empleados where sal_emp >= (SELECT AVG(sal_emp) FROM empleados) order by id_depto asc;


