// Script para subir source maps a Sentry después del build
// Este script es necesario porque el plugin automático de Sentry no funciona con Turbopack en Next.js 16

const { execSync } = require('child_process');
const path = require('path');
const dotenv = require('dotenv');

// Cargar variables de .env.local
const envPath = path.join(__dirname, '..', '.env.local');
console.log('📁 Cargando variables de:', envPath);

const result = dotenv.config({ path: envPath });
if (result.error) {
  console.log('⚠️  Error cargando .env.local:', result.error.message);
} else {
  console.log('✓ Variables cargadas correctamente\n');
}

// Leer variables de entorno
const SENTRY_ORG = process.env.SENTRY_ORG;
const SENTRY_PROJECT = process.env.SENTRY_PROJECT;
const SENTRY_AUTH_TOKEN = process.env.SENTRY_AUTH_TOKEN;

// Verificar que las variables estén configuradas
if (!SENTRY_ORG || !SENTRY_PROJECT || !SENTRY_AUTH_TOKEN) {
  console.log('⚠️  Source maps no se subirán: Variables de Sentry no configuradas');
  console.log('   Verifica que .env.local contenga:');
  console.log('   - SENTRY_ORG');
  console.log('   - SENTRY_PROJECT');
  console.log('   - SENTRY_AUTH_TOKEN');
  process.exit(0); // Salir sin error
}

console.log('📤 Subiendo source maps a Sentry...');
console.log(`   Organización: ${SENTRY_ORG}`);
console.log(`   Proyecto: ${SENTRY_PROJECT}\n`);

// Generar o usar release name (puede ser un hash de git, versión del package.json, etc.)
const release = process.env.NEXT_PUBLIC_APP_VERSION || 'development';
console.log(`   Release: ${release}\n`);

try {
  // Subir source maps usando Sentry CLI con release
  const command = `npx sentry-cli sourcemaps upload --org=${SENTRY_ORG} --project=${SENTRY_PROJECT} --release=${release} .next`;
  
  execSync(command, {
    stdio: 'inherit',
    env: {
      ...process.env,
      SENTRY_AUTH_TOKEN: SENTRY_AUTH_TOKEN
    }
  });
  
  console.log('\n✅ Source maps subidos exitosamente');
  console.log(`   Release: ${release}`);
  console.log('   Verifica en: https://sentry.io/organizations/' + SENTRY_ORG + '/projects/' + SENTRY_PROJECT + '/?project=' + SENTRY_PROJECT);
} catch (error) {
  console.error('\n❌ Error al subir source maps');
  console.error('   Verifica:');
  console.error('   - Que el SENTRY_AUTH_TOKEN sea válido');
  console.error('   - Que el token tenga permisos: project:read, project:releases, org:read');
  console.error('   - Que SENTRY_ORG y SENTRY_PROJECT sean correctos');
  process.exit(1);
}
