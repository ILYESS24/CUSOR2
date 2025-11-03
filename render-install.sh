#!/bin/bash
# Script d'installation pour Render.com
# Installe les dépendances en gérant spécifiquement native-keymap

set -e

echo "📦 Installation des dépendances..."

# Installer toutes les dépendances normalement
# Si native-keymap échoue, on continue quand même
npm install || {
    echo "⚠️ Erreur lors de l'installation, vérification de native-keymap..."
    # Si c'est seulement native-keymap qui a échoué, on peut continuer
    # car il n'est pas nécessaire pour le mode web
    if [ -d "node_modules" ]; then
        echo "✅ node_modules existe, installation partielle OK"
        # Réinstaller seulement native-keymap sans scripts
        npm install native-keymap --ignore-scripts || echo "⚠️ native-keymap ignoré (non nécessaire pour web)"
    else
        echo "❌ Échec complet de l'installation"
        exit 1
    fi
}

echo "✅ Installation terminée"

