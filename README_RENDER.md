# Déploiement Flexpilot IDE sur Render

## Configuration pour Render.com

Ce projet est configuré pour être déployé automatiquement sur Render.com.

### Fichiers de configuration

- **`render.yaml`** : Configuration principale pour Render
- **`render-start.js`** : Script de démarrage du serveur web

### Étapes de déploiement

1. **Connectez votre repository GitHub à Render**
   - Allez sur [Render Dashboard](https://dashboard.render.com)
   - Cliquez sur "New +" → "Web Service"
   - Connectez votre repository GitHub `ILYESS24/CUSOR2`

2. **Render détectera automatiquement `render.yaml`**
   - Render utilisera la configuration définie dans `render.yaml`
   - Build command : `npm install && npm run render:build`
   - Start command : `npm run render:start`

3. **Variables d'environnement**
   - Render définit automatiquement `PORT`
   - Les autres variables sont définies dans `render.yaml`

### Structure du build

Le build sur Render exécute :
1. `npm install` - Installation des dépendances
2. `npm run download-builtin-extensions` - Téléchargement des extensions intégrées
3. `npm run compile-build` - Compilation du code de base
4. `npm run compile-web` - Compilation de la version web
5. `npm run minify-vscode-reh-web` - Minification pour la production

### Démarrer le serveur

Le serveur démarre via `render-start.js` qui :
- Utilise le PORT fourni par Render
- Configure le host sur `0.0.0.0` pour accepter les connexions externes
- Lance `@vscode/test-web` pour servir Flexpilot IDE

### Notes importantes

- **Mémoire** : Le build nécessite beaucoup de mémoire (≥8GB recommandé)
- **Temps de build** : Le build peut prendre 15-30 minutes la première fois
- **Plan Render** : Le plan "starter" est configuré par défaut, mais vous pourriez avoir besoin d'un plan supérieur pour le build

### Personnalisation

Pour changer le plan ou les variables d'environnement, modifiez `render.yaml`.

