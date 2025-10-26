SELECT '=== CARRERAS ===' as info;
SELECT * FROM carreras;

SELECT '=== MATERIAS ===' as info;
SELECT * FROM materias join carreras on carreras.id=materias.carrera_id;