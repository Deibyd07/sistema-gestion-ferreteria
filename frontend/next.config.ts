import type { NextConfig } from "next";
import { withSentryConfig } from "@sentry/nextjs";

const nextConfig: NextConfig = {
  /* config options here */
};

// Configuración para Sentry v9+
export default withSentryConfig(nextConfig, {
  // Configuración de upload de source maps
  org: process.env.SENTRY_ORG,
  project: process.env.SENTRY_PROJECT,
  authToken: process.env.SENTRY_AUTH_TOKEN,
  
  // Mostrar logs para debugging (cambiar a true en producción)
  silent: false,
  
  // Subir source maps automáticamente
  widenClientFileUpload: true,
  
  // Ocultar source maps en producción
  sourcemaps: {
    disable: false,  // Generar source maps
    deleteSourcemapsAfterUpload: true,  // Eliminarlos después de subir
  },
});
