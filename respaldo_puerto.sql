-- ====================================================================
--              PROYECTO BASE DE DATOS: PUERTO_DB
-- ====================================================================

-- --------------------------------------------------------------------
-- PARTE 1: VERIFICACIÓN DE COLUMNAS REALES (Estructura de las tablas)
-- --------------------------------------------------------------------
-- Ejecuta estos comandos si necesitas recordar cómo se llaman tus campos:
SELECT * FROM public.mercancias;
SELECT * FROM public.bodegas;
SELECT * FROM public.tarifas;
SELECT * FROM public.documentos;
SELECT * FROM public.movimientos;


-- --------------------------------------------------------------------
-- PARTE 2: INSERCIÓN DE DATOS DE PRUEBA REALES
-- --------------------------------------------------------------------
-- 1. Registrar Bodega Principal (Columna real: "nombre")
INSERT INTO public.bodegas (id_bodega, nombre) 
VALUES (1, 'Bodega Principal Puerto')
ON CONFLICT (id_bodega) DO NOTHING;

-- 2. Registrar Tarifa en Dólares (Columnas reales: "valor_diario_usd", "tipo_carga", "dias_gracia")
INSERT INTO public.tarifas (id_tarifa, tipo_carga, valor_diario_usd, dias_gracia) 
VALUES (1, 'General', 120.50, 5)
ON CONFLICT (id_tarifa) DO NOTHING;

-- 3. Registrar Documento de Soporte (Columnas reales: "tipo_documento", "url_archivo", "esta_aprobado")
INSERT INTO public.documentos (id_documento, tipo_documento, url_archivo, esta_aprobado) 
VALUES (1, 'Declaración de Importación', 'http://puerto.com/archivos/di-99.pdf', true)
ON CONFLICT (id_documento) DO NOTHING;

-- 4. Registrar la Mercancía amarrada a los IDs anteriores (Llave foránea: "Id_Bodega")
INSERT INTO public.mercancias (id_contenedor, tipo_carga, estado_logistico, aduanero_autorizado, "Id_Bodega", id_tarifa, id_documento) 
VALUES (101, 'General', 'En Patio', true, 1, 1, 1)
ON CONFLICT (id_contenedor) DO NOTHING;

-- 5. Registrar el Movimiento logístico del contenedor
INSERT INTO public.movimientos (id_movimiento, id_contenedor, tipo_movimiento, fecha_movimiento, cantidad, observaciones) 
VALUES (1, 101, 'Entrada', CURRENT_DATE, 1, 'Ingreso exitoso validado con JOIN')
ON CONFLICT (id_movimiento) DO NOTHING;


-- --------------------------------------------------------------------
-- PARTE 3: CONSULTA RELACIONAL GENERAL (REPORTE UNIFICADO)
-- --------------------------------------------------------------------
-- Este comando une todas las tablas usando las llaves foráneas corregidas (JOINs):
SELECT 
    m.id_contenedor,
    m.tipo_carga,
    m.estado_logistico,
    b.nombre AS nombre_bodega,
    t.valor_diario_usd,
    d.tipo_documento,
    d.esta_aprobado,
    mov.tipo_movimiento,
    mov.fecha_movimiento
FROM public.mercancias m
JOIN public.bodegas b ON m."Id_Bodega" = b.id_bodega
JOIN public.tarifas t ON m.id_tarifa = t.id_tarifa
JOIN public.documentos d ON m.id_documento = d.id_documento
JOIN public.movimientos mov ON m.id_contenedor = mov.id_contenedor;


-- --------------------------------------------------------------------
-- PARTE 4: ACTUALIZACIÓN PARA EL LOGIN (NUEVO)
-- --------------------------------------------------------------------
-- Esto asegura que la tabla usuarios tenga la columna contrasena y un admin de prueba
ALTER TABLE public.usuarios 
ADD COLUMN IF NOT EXISTS contrasena VARCHAR(255);

INSERT INTO public.usuarios (email, rol, contrasena)
VALUES ('admin@puerto.com', 'Administrador', '123456');

-- Consultar para verificar los usuarios existentes
SELECT * FROM public.usuarios;