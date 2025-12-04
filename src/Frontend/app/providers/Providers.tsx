"use client";

import { Toaster } from "sonner";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { ReactQueryDevtools } from "@tanstack/react-query-devtools";

const queryClient = new QueryClient();

export default function Providers({ children }: { children: React.ReactNode }) {
  return (
    <div suppressHydrationWarning>
      <QueryClientProvider client={queryClient}>
        <Toaster
          position="bottom-right"
          duration={3000}
          richColors
          style={{
            fontSize: 14,
            textAlign: "center",
          }}
        />

        <ReactQueryDevtools />

        {children}
      </QueryClientProvider>
    </div>
  );
}