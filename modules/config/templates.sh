#!/bin/bash

# Create base template files
create_templates() {
  log_step "Creating template files"

  create_layout
  create_page
  create_global_css

  log_success "Template files created successfully"
}

create_layout() {
  log_info "Creating layout component..."

  cat > src/app/layout.tsx << EOF
import { ReactNode } from 'react';
import { Metadata } from 'next';
import { Inter } from 'next/font/google';
import '@/assets/styles/globals.css';

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
  title: '${project_name:-Next.js Application}',
  description: '${project_description:-A modern Next.js application}',
};

export default function RootLayout({
  children,
}: {
  children: ReactNode;
}) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <main className="container mx-auto py-10 min-h-screen px-4">
          {children}
        </main>
      </body>
    </html>
  );
}
EOF

  # Remove .gitkeep since we now have actual files
  rm -f src/app/.gitkeep

  log_success "Layout file created"
}

create_page() {
  log_info "Creating home page..."

  cat > src/app/page.tsx << EOF
export default function Home() {
  return (
    <div className="flex flex-col items-center justify-center min-h-screen py-16">
      <div className="max-w-5xl w-full mx-auto px-6">
          <h1 className="text-6xl font-black tracking-tight text-center mb-8">
              Welcome to
              <span className="bg-clip-text text-transparent bg-gradient-to-r from-blue-600 via-indigo-500 to-teal-400 mx-2">
                  ${project_name:-Next.js}
              </span>
              ! 👋
          </h1>

          <p className="text-2xl text-center mb-12 max-w-3xl mx-auto">
              A modern web development playground built with cutting-edge technologies
          </p>

          <h2 className="text-3xl font-bold mb-8 text-center relative">
              <span className="relative z-10">Technology Stack</span>
              <span className="absolute bottom-0 left-1/2 transform -translate-x-1/2 h-1 w-24 bg-gradient-to-r from-blue-500 to-teal-400"></span>
          </h2>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-16">
              {/* Next.js */}
              <a
                  href="https://nextjs.org"
                  className="group bg-white text-black rounded-xl shadow-sm hover:shadow-xl transition-all flex flex-col items-center p-8 border border-gray-100 hover:border-black relative overflow-hidden"
              >
                  <div className="absolute inset-0 bg-black/5 opacity-0 group-hover:opacity-100 transition-opacity"></div>
                  <span className="text-2xl font-bold mb-3 relative z-10">Next.js</span>
                  <span className="text-gray-600 text-center relative z-10">The React Framework for the Web</span>
              </a>

              {/* React */}
              <a
                  href="https://reactjs.org"
                  className="group bg-white text-blue-600 rounded-xl shadow-sm hover:shadow-xl transition-all flex flex-col items-center p-8 border border-gray-100 hover:border-blue-600 relative overflow-hidden"
              >
                  <div className="absolute inset-0 bg-blue-600/5 opacity-0 group-hover:opacity-100 transition-opacity"></div>
                  <span className="text-2xl font-bold mb-3 relative z-10">React</span>
                  <span className="text-gray-600 text-center relative z-10">
                      A JavaScript library for building user interfaces
                  </span>
              </a>

              {/* Tailwind CSS */}
              <a
                  href="https://tailwindcss.com"
                  className="group bg-white text-teal-500 rounded-xl shadow-sm hover:shadow-xl transition-all flex flex-col items-center p-8 border border-gray-100 hover:border-teal-500 relative overflow-hidden"
              >
                  <div className="absolute inset-0 bg-teal-500/5 opacity-0 group-hover:opacity-100 transition-opacity"></div>
                  <span className="text-2xl font-bold mb-3 relative z-10">Tailwind CSS</span>
                  <span className="text-gray-600 text-center relative z-10">Utility-first CSS framework</span>
              </a>

              {/* Prettier */}
              <a
                  href="https://prettier.io"
                  className="group bg-white text-pink-500 rounded-xl shadow-sm hover:shadow-xl transition-all flex flex-col items-center p-8 border border-gray-100 hover:border-pink-500 relative overflow-hidden"
              >
                  <div className="absolute inset-0 bg-pink-500/5 opacity-0 group-hover:opacity-100 transition-opacity"></div>
                  <span className="text-2xl font-bold mb-3 relative z-10">Prettier</span>
                  <span className="text-gray-600 text-center relative z-10">Opinionated code formatter</span>
              </a>

              {/* ESLint */}
              <a
                  href="https://eslint.org"
                  className="group bg-white text-purple-600 rounded-xl shadow-sm hover:shadow-xl transition-all flex flex-col items-center p-8 border border-gray-100 hover:border-purple-600 relative overflow-hidden"
              >
                  <div className="absolute inset-0 bg-purple-600/5 opacity-0 group-hover:opacity-100 transition-opacity"></div>
                  <span className="text-2xl font-bold mb-3 relative z-10">ESLint</span>
                  <span className="text-gray-600 text-center relative z-10">Static code analysis tool</span>
              </a>

              {/* TypeScript */}
              <a
                  href="https://typescriptlang.org"
                  className="group bg-white text-blue-800 rounded-xl shadow-sm hover:shadow-xl transition-all flex flex-col items-center p-8 border border-gray-100 hover:border-blue-800 relative overflow-hidden"
              >
                  <div className="absolute inset-0 bg-blue-800/5 opacity-0 group-hover:opacity-100 transition-opacity"></div>
                  <span className="text-2xl font-bold mb-3 relative z-10">TypeScript</span>
                  <span className="text-gray-600 text-center relative z-10">JavaScript with syntax for types</span>
              </a>
          </div>

          <div className="text-lg text-gray-700 dark:text-gray-300 flex items-center justify-center space-x-2">
              <span>Built with ❤️ by</span>
              <a
                  href="https://github.com/vercel/next.js/tree/canary/packages/create-next-app"
                  className="text-blue-600 hover:text-blue-800 font-semibold hover:underline transition-colors"
              >
                  next-starter
              </a>
          </div>
      </div>
  </div>
  );
}
EOF

  log_success "Home page created"
}

create_global_css() {
  log_info "Creating global CSS file..."

  cat > src/assets/styles/globals.css << EOF
@import "tailwindcss";

:root {
  --foreground-rgb: 0, 0, 0;
  --background-rgb: 255, 255, 255;
}

@media (prefers-color-scheme: dark) {
  :root {
    --foreground-rgb: 255, 255, 255;
    --background-rgb: 0, 0, 0;
  }
}

body {
  color: rgb(var(--foreground-rgb));
  background: rgb(var(--background-rgb));
}

@layer components {
  .container {
    @apply max-w-7xl mx-auto;
  }
}
EOF

  # Remove .gitkeep since we now have actual files
  rm -f src/assets/styles/.gitkeep

  log_success "Global CSS file created"
}