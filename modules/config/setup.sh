#!/bin/bash

# Apply configurations and setup
apply_configurations() {
  log_step "Applying project configurations"

  # Setup ESLint configuration
  setup_eslint

  # Setup Prettier configuration
  setup_prettier

  # Setup VSCode configuration
  setup_vscode

  # Apply template files
  create_templates

  log_success "Project configurations applied successfully"
}

setup_eslint() {
    log_info "Setting up ESLint configuration..."

  # Always recreate eslint.config.mjs with Prettier integration
  log_info "Creating ESLint configuration with Prettier integration..."

  cat > eslint.config.mjs << 'EOF'
import { dirname } from "path";
import { fileURLToPath } from "url";
import { FlatCompat } from "@eslint/eslintrc";
import eslintPluginPrettier from "eslint-plugin-prettier";
import prettierConfig from "eslint-config-prettier";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const compat = new FlatCompat({
  baseDirectory: __dirname,
});

const eslintConfig = [
  // Prettier must come first to override other configs
  prettierConfig,

  // Base configs
  ...compat.extends("next/core-web-vitals", "next/typescript"),

  // Prettier plugin
  {
    plugins: {
      prettier: eslintPluginPrettier,
    },
    rules: {
      ...eslintPluginPrettier.configs.recommended.rules,
      "prettier/prettier": "error",
      "no-unused-vars": "off",
      "@typescript-eslint/no-unused-vars": ["error"],
      "prefer-const": "error",
      "@typescript-eslint/no-explicit-any": "warn"
    }
  }
];

export default eslintConfig;
EOF

  log_success "ESLint configuration created with Prettier integration"
}

setup_prettier() {
  log_info "Setting up Prettier configuration..."

  # Create .prettierrc.json if it doesn't exist
  if [ ! -f ".prettierrc.json" ]; then
    cat > .prettierrc.json << 'EOF'
{
    "plugins": ["prettier-plugin-tailwindcss"],
    "semi": false,
    "singleQuote": true,
    "trailingComma": "none",
    "tabWidth": 4,
    "arrowParens": "always",
    "endOfLine": "lf",
    "overrides": [
        {
            "files": ["*.jsx", "*.js", "*.tsx", "*.ts"],
            "options": {
                "printWidth": 125
            }
        }
    ]
}
EOF
    log_success "Prettier configuration created"
  else
    log_info "Prettier configuration already exists"
  fi

  # Create .prettierignore if it doesn't exist
  if [ ! -f ".prettierignore" ]; then
    cat > .prettierignore << 'EOF'
node_modules
.next
build
dist
.vercel
EOF
    log_success "Prettier ignore file created"
  else
    log_info "Prettier ignore file already exists"
  fi
}

setup_vscode() {
  log_info "Setting up VSCode configuration..."

  # Create .vscode directory if it doesn't exist
  mkdir -p .vscode

  # Create settings.json with the specified configuration
  cat > .vscode/settings.json << 'EOF'
{
    "files.exclude": {
        "**/.git": true,
        "**/.svn": true,
        "**/.hg": true,
        "**/CVS": true,
        "**/.DS_Store": true,
        "**/Thumbs.db": true,
        "**/node_modules": true,
        "**/.next": true,
        "**/.vscode": true
    },
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.codeActionsOnSave": {
        "source.fixAll.eslint": true
    },
    "eslint.validate": [
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact"
    ]
}
EOF

  # Add IDE and .vscode to .gitignore
  echo -e "# IDE\n.vscode" >> .gitignore

  log_success "VSCode configuration created"

  log_info "Recommended VSCode extensions:"
  echo "- esbenp.prettier-vscode (Prettier)"
  echo "- dbaeumer.vscode-eslint (ESLint)"
  echo "- bradlc.vscode-tailwindcss (Tailwind CSS IntelliSense)"
}

a