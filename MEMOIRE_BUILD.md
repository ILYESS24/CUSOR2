# ⚠️ Problème de Mémoire lors du Build

## Problème rencontré

Le build échoue avec l'erreur :
```
FATAL ERROR: Ineffective mark-compacts near heap limit Allocation failed - JavaScript heap out of memory
```

## Cause

VS Code est un très gros projet qui nécessite beaucoup de mémoire pour la compilation TypeScript. Le plan **Starter** de Render (512 MB RAM) n'est pas suffisant.

## Solutions

### Option 1 : Augmenter la mémoire Node.js (déjà implémenté)

J'ai ajouté `NODE_OPTIONS="--max-old-space-size=4096"` dans :
- Les variables d'environnement
- La commande de build directement

Cela permet d'utiliser jusqu'à 4GB de RAM si disponible.

### Option 2 : Passer au plan Standard/Pro (RECOMMANDÉ)

Le plan **Starter** a seulement **512 MB de RAM**, ce qui est insuffisant pour compiler VS Code.

**Recommandation :**
- **Plan Standard** : 2GB RAM (~$7/mois) - devrait fonctionner
- **Plan Pro** : 4GB+ RAM (~$25/mois) - fonctionnera sans problème

### Option 3 : Build en local puis déployer

Si vous ne voulez pas payer pour un plan supérieur, vous pouvez :
1. Build en local
2. Créer un script qui pousse seulement les fichiers compilés
3. Déployer seulement les assets finaux

## Configuration actuelle

Le `render.yaml` a été mis à jour pour utiliser `NODE_OPTIONS="--max-old-space-size=4096"`, mais si le plan Starter n'a que 512MB de RAM totale, cela ne suffira pas.

## Prochaines étapes

1. **Si le build échoue encore :** Passez au plan Standard ou Pro dans Render
2. **Si le build réussit :** Parfait, vous pouvez continuer avec le plan Starter
3. **Alternative :** Utiliser un autre service comme Railway.app ou Fly.io qui offrent plus de RAM gratuitement

