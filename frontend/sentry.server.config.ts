import * as Sentry from "@sentry/nextjs";

const tracesSampleRate = parseFloat(
  process.env.SENTRY_TRACES_SAMPLE_RATE ?? "0.1"
);
const profilesSampleRate = parseFloat(
  process.env.SENTRY_PROFILES_SAMPLE_RATE ?? "0.0"
);

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.SENTRY_ENVIRONMENT ?? "development",
  tracesSampleRate,
  profilesSampleRate,
});
