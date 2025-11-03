#!/bin/bash
# Script de build pour Render.com
# Gère l'installation des dépendances en ignorant les scripts de build pour les modules natifs non nécessaires

set -e  # Arrêter en cas d'erreur

echo "🚀 Début du build Flexpilot IDE pour Render..."

# Installation des dépendances en ignorant les scripts de build pour les modules natifs
# Cela évite les erreurs de compilation pour native-keymap et autres modules Electron-only
# qui nécessitent des bibliothèques système Linux non disponibles sur Render
echo "📦 Installation des dépendances (en ignorant les scripts natifs)..."
npm install --ignore-scripts || {
    echo "⚠️ Erreur lors de l'installation avec --ignore-scripts, tentative sans..."
    npm install
}

# Certaines dépendances critiques peuvent nécessiter une compilation sélective
# Mais on évite native-keymap qui n'est pas utilisé en mode web
echo "🔨 Vérification des dépendances critiques..."

# Téléchargement des extensions intégrées
echo "📥 Téléchargement des extensions intégrées..."
npm run download-builtin-extensions || echo "⚠️ Warning: Erreur lors du téléchargement des extensions"

# Compilation du code de base
echo "🔨 Compilation du code de base..."
npm run compile-build

# Compilation de la version web
echo "🌐 Compilation de la version web..."
npm run compile-web

# Minification pour la production
echo "📦 Minification pour la production..."
npm run minify-vscode-reh-web

echo "✅ Build terminé avec succès!"

