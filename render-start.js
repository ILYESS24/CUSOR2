#!/usr/bin/env node
/*---------------------------------------------------------------------------------------------
 * Script de démarrage pour Render.com
 * Démarre Flexpilot IDE en mode web avec la configuration appropriée pour Render
 *--------------------------------------------------------------------------------------------*/

const testWebLocation = require.resolve('@vscode/test-web');
const cp = require('child_process');
const path = require('path');

const APP_ROOT = path.join(__dirname);

// Render fournit le PORT via variable d'environnement
const PORT = process.env.PORT || '8080';
const HOST = process.env.HOST || '0.0.0.0';

console.log(`🚀 Démarrage de Flexpilot IDE sur Render...`);
console.log(`📍 Host: ${HOST}`);
console.log(`🔌 Port: ${PORT}`);

// Arguments pour le serveur VS Code Web
const serverArgs = [
	'--host', HOST,
	'--port', PORT,
	'--browserType', 'none',
	'--sourcesPath', APP_ROOT
];

console.log(`📦 Exécution: node ${testWebLocation} ${serverArgs.join(' ')}`);

const env = { ...process.env };

// Démarrer le serveur
const proc = cp.spawn(process.execPath, [testWebLocation, ...serverArgs], { 
	env, 
	stdio: 'inherit' 
});

proc.on('exit', (code) => {
	console.error(`❌ Serveur terminé avec le code: ${code}`);
	process.exit(code);
});

process.on('exit', () => {
	console.log('🛑 Arrêt du serveur...');
	proc.kill();
});

process.on('SIGINT', () => {
	console.log('🛑 Reçu SIGINT, arrêt du serveur...');
	proc.kill();
	process.exit(128 + 2);
});

process.on('SIGTERM', () => {
	console.log('🛑 Reçu SIGTERM, arrêt du serveur...');
	proc.kill();
	process.exit(128 + 15);
});

// Gérer les erreurs non capturées
process.on('uncaughtException', (error) => {
	console.error('❌ Erreur non capturée:', error);
	proc.kill();
	process.exit(1);
});

