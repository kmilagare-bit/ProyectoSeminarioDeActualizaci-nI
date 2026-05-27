-- -------------------------------------------------------------------------
-- PASO 1: MODIFICACIÓN DE TABLAS (Estructura base del Sistema)
-- -------------------------------------------------------------------------

-- A. Asegurar columna de contraseña en la tabla de usuarios para el Login
ALTER TABLE public.usuarios 
  ADD COLUMN IF NOT EXISTS contrasena VARCHAR(255);

-- B. Agregar campos para GPS y Fotos en la tabla de movimientos
ALTER TABLE public.movimientos 
  ADD COLUMN IF NOT EXISTS latitud DECIMAL(10, 8),
  ADD COLUMN IF NOT EXISTS longitud DECIMAL(11, 8),
  ADD COLUMN IF NOT EXISTS url_foto VARCHAR(500);

-- C. Agregar campo para el QR en la tabla de mercancías/contenedores
ALTER TABLE public.mercancias 
  ADD COLUMN IF NOT EXISTS estado_contenedor VARCHAR(20);


-- -------------------------------------------------------------------------
-- PASO 2: INSERCIÓN DE DATOS DE PRUEBA (Para validar con el Backend)
-- -------------------------------------------------------------------------

-- 1. Insertar el usuario semilla para probar el Login
INSERT INTO public.usuarios (email, rol, contrasena)
VALUES ('admin@puerto.com', 'Administrador', '123456')
ON CONFLICT DO NOTHING;

-- 2. Insertar o actualizar el contenedor de prueba 101 con su estado QR
INSERT INTO public.mercancias (
    id_contenedor, 
    tipo_carga, 
    estado_logistico, 
    aduanero_autorizado, 
    "Id_Bodega", 
    id_tarifa, 
    id_documento, 
    estado_contenedor
) VALUES (
    101, 
    'General', 
    'En Patio', 
    true, 
    1, 
    1, 
    1, 
    'Lleno'
) 
ON CONFLICT (id_contenedor) DO UPDATE 
SET estado_contenedor = EXCLUDED.estado_contenedor;

-- 3. Insertar el movimiento de prueba con coordenadas reales de Buenaventura y foto
INSERT INTO public.movimientos (
    id_movimiento, 
    id_contenedor, 
    tipo_movimiento, 
    fecha_movimiento, 
    cantidad, 
    observaciones, 
    latitud, 
    longitud, 
    url_foto
) VALUES (
    1, 
    101, 
    'Entrada', 
    CURRENT_DATE, 
    1, 
    'Ingreso exitoso con lectura de QR, GPS y captura fotográfica', 
    3.89420000, 
    -77.07240000, 
    'https://api.puerto.com/evidencias/foto_contenedor_101.jpg'
) 
ON CONFLICT (id_movimiento) DO NOTHING;


-- -------------------------------------------------------------------------
-- PASO 3: CONSULTA DE VERIFICACIÓN (La prueba de fuego con JOIN)
-- -------------------------------------------------------------------------
SELECT 
    m.id_movimiento,
    m.tipo_movimiento,
    c.id_contenedor AS numero_contenedor,
    c.tipo_carga AS informacion_carga,
    c.estado_contenedor AS escaneo_qr,
    m.latitud,
    m.longitud,
    m.url_foto
FROM public.movimientos m
JOIN public.mercancias c ON m.id_contenedor = c.id_contenedor;


-- -------------------------------------------------------------------------
-- PASO 4: LIMPIEZA DE DATOS (Opcional)
-- -------------------------------------------------------------------------
-- DELETE FROM public.movimientos WHERE id_movimiento = 1;
-- DELETE FROM public.mercancias WHERE id_contenedor = 101;