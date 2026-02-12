/**
 * Cliente de Supabase para el frontend
 * 
 * Este módulo proporciona una instancia configurada del cliente de Supabase
 * para usar en toda la aplicación frontend.
 */

import { createClient, SupabaseClient } from '@supabase/supabase-js';

// Validar que las variables de entorno existan
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error(
    'Las credenciales de Supabase no están configuradas. ' +
    'Verifica que NEXT_PUBLIC_SUPABASE_URL y NEXT_PUBLIC_SUPABASE_ANON_KEY ' +
    'estén definidas en el archivo .env.local'
  );
}

/**
 * Cliente de Supabase configurado para el navegador
 * 
 * Este cliente usa las credenciales públicas (anon key) y es seguro
 * para usar en el frontend. Las políticas RLS (Row Level Security)
 * deben estar configuradas en Supabase para proteger los datos.
 * 
 * @example
 * ```tsx
 * import { supabase } from '@/lib/supabase';
 * 
 * // Autenticación
 * const { data, error } = await supabase.auth.signInWithPassword({
 *   email: 'user@example.com',
 *   password: 'password123'
 * });
 * 
 * // Consultas a la base de datos
 * const { data: products } = await supabase
 *   .from('products')
 *   .select('*')
 *   .limit(10);
 * ```
 */
export const supabase: SupabaseClient = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    // Configuración de persistencia de sesión
    persistSession: true,
    autoRefreshToken: true,
    detectSessionInUrl: true,
    
    // Storage personalizado (opcional)
    storage: typeof window !== 'undefined' ? window.localStorage : undefined,
  },
});

/**
 * Hook para obtener la sesión actual del usuario
 * 
 * @returns {Promise<Session | null>} Sesión actual o null si no hay usuario autenticado
 */
export async function getCurrentSession() {
  const { data: { session } } = await supabase.auth.getSession();
  return session;
}

/**
 * Hook para obtener el usuario actual
 * 
 * @returns {Promise<User | null>} Usuario actual o null si no hay usuario autenticado
 */
export async function getCurrentUser() {
  const { data: { user } } = await supabase.auth.getUser();
  return user;
}

/**
 * Función para cerrar sesión
 * 
 * @returns {Promise<void>}
 */
export async function signOut() {
  const { error } = await supabase.auth.signOut();
  if (error) throw error;
}

/**
 * Función helper para subir archivos a Storage
 * 
 * @param bucket - Nombre del bucket
 * @param path - Ruta del archivo en el bucket
 * @param file - Archivo a subir
 * @returns {Promise<string>} URL pública del archivo subido
 */
export async function uploadFile(bucket: string, path: string, file: File): Promise<string> {
  const { data, error } = await supabase.storage
    .from(bucket)
    .upload(path, file, {
      cacheControl: '3600',
      upsert: false
    });
  
  if (error) throw error;
  
  // Obtener URL pública
  const { data: { publicUrl } } = supabase.storage
    .from(bucket)
    .getPublicUrl(data.path);
  
  return publicUrl;
}

/**
 * Función helper para eliminar archivos de Storage
 * 
 * @param bucket - Nombre del bucket
 * @param paths - Ruta(s) del archivo a eliminar
 */
export async function deleteFile(bucket: string, paths: string | string[]) {
  const pathsArray = Array.isArray(paths) ? paths : [paths];
  const { error } = await supabase.storage
    .from(bucket)
    .remove(pathsArray);
  
  if (error) throw error;
}

// Tipos útiles exportados desde Supabase
export type { User, Session } from '@supabase/supabase-js';
