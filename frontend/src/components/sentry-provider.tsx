"use client";

import { useEffect } from "react";
import * as Sentry from "@sentry/nextjs";

export function SentryProvider({ children }: { children: React.ReactNode }) {
  useEffect(() => {
    // Inicializar Sentry en el cliente
    const dsn = process.env.NEXT_PUBLIC_SENTRY_DSN;
    
    if (dsn && !Sentry.isInitialized()) {
      Sentry.init({
        dsn,
        environment: process.env.NEXT_PUBLIC_SENTRY_ENVIRONMENT ?? "development",
        tracesSampleRate: parseFloat(
          process.env.NEXT_PUBLIC_SENTRY_TRACES_SAMPLE_RATE ?? "1.0"
        ),
        integrations: [
          Sentry.replayIntegration({
            maskAllText: true,
            blockAllMedia: true,
          }),
        ],
        replaysSessionSampleRate: 0.1,
        replaysOnErrorSampleRate: 1.0,
      });
      
      console.log("✅ Sentry inicializado en el cliente");
    }
  }, []);

  return <>{children}</>;
}
