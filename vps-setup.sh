#!/bin/bash
# Script d'installation automatique pour VPS
# Configure Flexpilot IDE sur un nouveau serveur Ubuntu/Debian

set -e

echo "🚀 Configuration Flexpilot IDE sur VPS..."

# Mise à jour système
echo "📦 Mise à jour du système..."
sudo apt update && sudo apt upgrade -y

# Installation dépendances de base
echo "📦 Installation des dépendances..."
sudo apt install -y curl git build-essential python3 python3-pip

# Installation Node.js 20.x
echo "📦 Installation Node.js 20.x..."
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt install -y nodejs
fi

# Vérification versions
echo "✅ Node.js version: $(node --version)"
echo "✅ npm version: $(npm --version)"

# Installation PM2
echo "📦 Installation PM2..."
sudo npm install -g pm2

# Installation Nginx
echo "📦 Installation Nginx..."
sudo apt install -y nginx

# Configuration firewall
echo "🔥 Configuration firewall..."
sudo ufw allow 22/tcp  # SSH
sudo ufw allow 80/tcp  # HTTP
sudo ufw allow 443/tcp # HTTPS
sudo ufw --force enable

# Clonage repository (si pas déjà fait)
if [ ! -d "CUSOR2" ]; then
    echo "📥 Clonage du repository..."
    git clone https://github.com/ILYESS24/CUSOR2.git
    cd CUSOR2
else
    echo "📂 Repository déjà présent, mise à jour..."
    cd CUSOR2
    git pull
fi

# Installation dépendances
echo "📦 Installation des dépendances npm..."
npm install --ignore-scripts

# Build (optionnel, peut être long)
read -p "Voulez-vous builder maintenant? (cela peut prendre 30+ minutes) [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🔨 Build Flexpilot IDE (cela va prendre du temps)..."
    export NODE_OPTIONS="--max-old-space-size=2048"
    npm run download-builtin-extensions
    npm run compile-build
    npm run compile-web
    npm run minify-vscode-reh-web
    echo "✅ Build terminé!"
else
    echo "⏭️  Build ignoré pour l'instant"
fi

# Configuration PM2
echo "⚙️  Configuration PM2..."
cat > ecosystem.config.js << 'EOF'
module.exports = {
  apps: [{
    name: 'flexpilot-ide',
    script: 'render-start.js',
    instances: 1,
    exec_mode: 'fork',
    env: {
      NODE_ENV: 'production',
      HOST: '0.0.0.0',
      PORT: 8080,
      NODE_OPTIONS: '--max-old-space-size=2048'
    },
    error_file: './logs/err.log',
    out_file: './logs/out.log',
    log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
    merge_logs: true,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G'
  }]
}
EOF

mkdir -p logs

# Démarrage avec PM2
echo "🚀 Démarrage de l'application..."
pm2 start ecosystem.config.js
pm2 save

# Configuration auto-start
echo "⚙️  Configuration auto-start..."
pm2 startup

echo ""
echo "✅ Installation terminée!"
echo ""
echo "📋 Prochaines étapes:"
echo "1. Configurer Nginx reverse proxy (voir VPS_OPTIONS.md)"
echo "2. Configurer SSL avec Let's Encrypt"
echo "3. Configurer votre domaine DNS"
echo ""
echo "🔍 Commandes utiles:"
echo "  pm2 status          - Voir le statut"
echo "  pm2 logs            - Voir les logs"
echo "  pm2 restart all     - Redémarrer"
echo "  pm2 stop all        - Arrêter"
echo ""

