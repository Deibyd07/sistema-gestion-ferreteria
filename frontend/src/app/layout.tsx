import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import { AuthProvider } from "@/contexts/AuthContext";
import { SentryProvider } from "@/components/sentry-provider";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Sistema de Gestión de Ferretería",
  description: "Plataforma profesional para la gestión completa de ferreterías - Multi-tenant SaaS",
  keywords: "ferretería, gestión, inventario, punto de venta, facturación",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="es">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased`}
      >
        <SentryProvider>
          <AuthProvider>
            {children}
          </AuthProvider>
        </SentryProvider>
      </body>
    </html>
  );
}
