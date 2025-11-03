#!/bin/bash
# Script de build pour Render.com
# Gère l'installation des dépendances en ignorant les scripts de build pour les modules natifs non nécessaires

set -e

echo "🚀 Début du build Flexpilot IDE pour Render..."

# Installation des dépendances en ignorant les scripts de build pour les modules natifs
# Cela évite les erreurs de compilation pour native-keymap et autres modules Electron-only
echo "📦 Installation des dépendances (en ignorant les scripts natifs)..."
npm install --ignore-scripts

# Compilation manuelle uniquement des dépendances nécessaires pour le web
echo "🔨 Compilation des dépendances nécessaires..."
# Certaines dépendances peuvent nécessiter une compilation, mais on les compile sélectivement
# native-keymap n'est pas nécessaire pour le web, donc on l'ignore

# Téléchargement des extensions intégrées
echo "📥 Téléchargement des extensions intégrées..."
npm run download-builtin-extensions

# Compilation du code
echo "🔨 Compilation du code de base..."
npm run compile-build

# Compilation de la version web
echo "🌐 Compilation de la version web..."
npm run compile-web

# Minification pour la production
echo "📦 Minification pour la production..."
npm run minify-vscode-reh-web

echo "✅ Build terminé avec succès!"

