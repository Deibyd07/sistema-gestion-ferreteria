export async function register() {
  if (process.env.NEXT_RUNTIME === "nodejs") {
    await import("../sentry.server.config");
  }

  if (process.env.NEXT_RUNTIME === "edge") {
    await import("../sentry.edge.config");
  }
}

export const onRequestError = async (err: unknown, request: Request) => {
  const Sentry = await import("@sentry/nextjs");
  Sentry.captureException(err, {
    contexts: {
      request: {
        url: request.url,
        method: request.method,
      },
    },
  });
};
