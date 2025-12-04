import "./globals.css";
import type { Metadata } from "next";

import { montserrat, lato } from "@fonts/fonts";
import Providers from "@providers/Providers";

export const metadata: Metadata = {
  title: "Nextract — Automatización de Datos de Facturas",
  description:
    "Software que extrae datos de facturas automáticamente para agilizar la contabilidad y eliminar errores.",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="es" className={`${montserrat.variable} ${lato.variable}`}>
      <body className="font-sans">
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}