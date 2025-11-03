#!/bin/bash
# Script d'installation pour Render.com
# Installe les dépendances en gérant spécifiquement native-keymap

set -e

echo "📦 Installation des dépendances principales..."

# Installer toutes les dépendances, en ignorant les scripts pour native-keymap
# mais en permettant les autres scripts nécessaires (comme pour build/)
npm install --ignore-scripts

echo "📦 Installation des dépendances de build/..."
# Installer les dépendances du dossier build (nécessaire pour ternary-stream etc.)
cd build && npm install --ignore-scripts && cd ..

echo "🔧 Tentative d'installation de native-keymap (optionnel pour web)..."
# Essayer d'installer native-keymap sans compilation
npm install native-keymap --ignore-scripts || {
    echo "⚠️ native-keymap ignoré (non nécessaire pour le mode web)"
    # Créer un stub pour éviter les erreurs d'import
    mkdir -p node_modules/native-keymap || true
    echo 'module.exports = { getKeyMap: () => ({}), getCurrentKeyboardLayout: () => ({ layout: "us" }) };' > node_modules/native-keymap/index.js || true
}

echo "✅ Installation terminée"

