# 🚀 Guide de Déploiement Flexpilot IDE sur Render

## ✅ Configuration terminée !

Le projet est maintenant configuré et prêt pour être déployé sur Render.com.

## 📁 Fichiers créés pour Render

1. **`render.yaml`** - Configuration principale pour Render
   - Service web Node.js
   - Commandes de build et démarrage
   - Variables d'environnement

2. **`render-start.js`** - Script de démarrage
   - Configure le port depuis la variable d'environnement Render
   - Démarre le serveur VS Code Web

3. **`package.json`** - Scripts ajoutés
   - `npm run render:build` - Build complet pour production
   - `npm run render:start` - Démarre le serveur

## 🔧 Étapes de déploiement sur Render

### Option 1 : Déploiement automatique (Recommandé)

1. **Connectez votre compte Render à GitHub**
   - Allez sur [https://dashboard.render.com](https://dashboard.render.com)
   - Connectez votre compte GitHub si ce n'est pas déjà fait

2. **Créez un nouveau Web Service**
   - Cliquez sur "New +" → "Web Service"
   - Sélectionnez le repository : `ILYESS24/CUSOR2`
   - Render détectera automatiquement le fichier `render.yaml`

3. **Render utilisera automatiquement :**
   - **Build Command** : `npm install && npm run render:build`
   - **Start Command** : `npm run render:start`
   - **Plan** : Starter (vous pouvez changer dans render.yaml)

4. **Attendez la fin du build**
   - Le premier build peut prendre 20-30 minutes
   - Render utilisera jusqu'à 8GB de RAM pendant le build

### Option 2 : Configuration manuelle

Si Render ne détecte pas automatiquement `render.yaml`, configurez manuellement :

1. **Type** : Web Service
2. **Environment** : Node
3. **Build Command** : 
   ```bash
   npm install && npm run render:build
   ```
4. **Start Command** : 
   ```bash
   npm run render:start
   ```
5. **Plan** : Starter ou Standard (Standard recommandé pour plus de mémoire)

## ⚙️ Variables d'environnement

Les variables suivantes sont automatiquement configurées dans `render.yaml` :

- `NODE_ENV=production`
- `HOST=0.0.0.0` (pour accepter les connexions externes)
- `VSCODE_SKIP_PRELAUNCH=1`
- `PORT` (fourni automatiquement par Render)

## 📊 Processus de build

Le build exécute ces étapes dans l'ordre :

1. **`npm install`** - Installation de toutes les dépendances
2. **`npm run download-builtin-extensions`** - Téléchargement des extensions intégrées
3. **`npm run compile-build`** - Compilation du code de base VS Code
4. **`npm run compile-web`** - Compilation de la version web
5. **`npm run minify-vscode-reh-web`** - Minification pour la production

## ⚠️ Notes importantes

### Mémoire requise
- **Build** : Minimum 8GB RAM recommandé
- **Runtime** : 2-4GB RAM recommandé
- Si le build échoue par manque de mémoire, passez au plan **Standard** ou **Pro**

### Temps de build
- **Premier build** : 20-30 minutes
- **Builds suivants** : 5-15 minutes (avec cache)

### Coûts Render
- **Plan Starter** : Gratuit (limité)
- **Plan Standard** : ~$7/mois (recommandé pour la production)
- **Plan Pro** : ~$25/mois (pour haute disponibilité)

## 🔍 Vérification du déploiement

Une fois déployé, vous pouvez :

1. Accéder à votre application via l'URL fournie par Render
2. Vérifier les logs dans le dashboard Render
3. Tester l'interface Flexpilot IDE dans votre navigateur

## 🐛 Résolution de problèmes

### Build échoue par manque de mémoire
- Solution : Passez au plan Standard ou Pro dans Render

### Le serveur ne démarre pas
- Vérifiez les logs Render
- Assurez-vous que le PORT est bien défini (automatique)
- Vérifiez que `@vscode/test-web` est installé

### Build prend trop de temps
- C'est normal pour le premier build (20-30 min)
- Les builds suivants seront plus rapides grâce au cache

## 📝 Commandes utiles

```bash
# Build local (pour tester)
npm run render:build

# Démarrer localement (pour tester)
npm run render:start

# Voir les logs sur Render
# Via le dashboard Render → Votre service → Logs
```

## 🎉 Une fois déployé

Votre Flexpilot IDE sera accessible via l'URL fournie par Render (ex: `https://flexpilot-ide.onrender.com`)

Vous pourrez :
- ✅ Éditer du code dans le navigateur
- ✅ Utiliser toutes les fonctionnalités de VS Code
- ✅ Installer des extensions
- ✅ Utiliser l'IA avec vos propres clés API

---

**Le code a été poussé avec succès vers : https://github.com/ILYESS24/CUSOR2.git** ✅

Bon déploiement ! 🚀

