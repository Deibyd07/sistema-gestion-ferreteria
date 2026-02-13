-- =====================================================
-- TRIGGER PARA CREAR USUARIOS AUTOMÁTICAMENTE
-- Cuando un usuario se registra en auth.users, se crea automáticamente
-- un registro en la tabla usuarios
-- =====================================================

-- Crear función de trigger
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.usuarios (id, email, nombre_completo, activo, es_super_admin)
  VALUES (
    new.id,
    new.email,
    COALESCE(new.raw_user_meta_data->>'full_name', new.email),
    true,
    false
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Crear trigger en la tabla auth.users
-- ⚠️ NOTA: Este trigger solo funciona en Supabase
-- Si usas PostgreSQL local, la tabla auth.users puede no existir
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


-- =====================================================
-- POLÍTICAS DE RLS PARA LA TABLA USUARIOS
-- =====================================================

-- Habilitar RLS en la tabla usuarios
ALTER TABLE public.usuarios ENABLE ROW LEVEL SECURITY;

-- Eliminar políticas existentes si existen
DROP POLICY IF EXISTS "Usuarios pueden ver su perfil" ON public.usuarios;
DROP POLICY IF EXISTS "Usuarios pueden actualizar su perfil" ON public.usuarios;
DROP POLICY IF EXISTS "Admins pueden ver todos los usuarios" ON public.usuarios;
DROP POLICY IF EXISTS "Trigger puede insertar usuarios" ON public.usuarios;

-- Política: Los usuarios pueden ver su propio perfil
CREATE POLICY "Usuarios pueden ver su perfil" ON public.usuarios
  FOR SELECT
  USING (auth.uid() = id);

-- Política: Los usuarios pueden actualizar su propio perfil
CREATE POLICY "Usuarios pueden actualizar su perfil" ON public.usuarios
  FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Política: Admin puede ver todos los usuarios
CREATE POLICY "Admins pueden ver todos los usuarios" ON public.usuarios
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.usuarios u
      WHERE u.id = auth.uid() AND u.es_super_admin = true
    )
  );

-- Política: Inserción de usuarios por el trigger del auth
CREATE POLICY "Trigger puede insertar usuarios" ON public.usuarios
  FOR INSERT
  WITH CHECK (true);
