import { Montserrat, Lato } from "next/font/google";

export const montserrat = Montserrat({
  subsets: ["latin"],
  variable: "--font-primary",
  display: "swap",
  weight: ["500"],
  style: ["normal"],
});

export const lato = Lato({
  subsets: ["latin"],
  variable: "--font-secondary",
  display: "swap",
  weight: ["400"],
  style: ["normal"],
});