# 🌦️ Application Météo - Réseau de Transports Français
🌐 [**VOIR LE SITE EN LIVE**](https://meteo-transports.vercel.app/)

Ce projet a été réalisé dans le cadre de la sélection pour le parcours **Concepteur Développeur d'Applications (spécialité DevOps)** chez Simplon. L'objectif était d'adapter une application météo existante pour un usage sur des bornes d'information dans les transports en commun.

## 🛠️ Améliorations et Choix Techniques

### 1. Adaptation de la source de données (Backend)
Le projet utilise désormais l'API **Open-Meteo**. Toute la logique est dans la route API (`/pages/api/data.js`) suivant le **Design Pattern "Adapter"** :
- **Mapping des codes météo** : Création d'un dictionnaire de correspondance pour traduire les codes météo en descriptions françaises et icônes SVG.
- **Indicateur Jour/Nuit** : Gestion dynamique des icônes (`d` pour le jour, `n` pour la nuit) via la propriété `is_day`.
- **Unités & Contraintes** : Configuration de l'appel API pour recevoir le vent en **m/s** car par défaut en **km/s**.

**Point clé :** Cette approche a permis de migrer l'API sans modifier (hormis la langue avec mon big ctrl+F) les services existants (`converters.js`, `helpers.js`), garantissant ainsi la stabilité du code.

### 2. Évolutions de l'Interface (Frontend)
- **Localisation complète** : Traduction de l'intégralité des composants en français (Ressenti, Vitesse du vent, Humidité, etc.) pour s'adapter aux usagers.
- **Mode Station Fixe** : Suppression du moteur de recherche conformément au brief. La ville est maintenant affichée via le fichier `config.json`.

- **Rafraîchissement automatique** : Implémentation d'un cycle de mise à jour toutes les heures via un `setInterval` avec gestion du nettoyage (cleanup) dans le hook `useEffect`.

## ⚙️ Configuration
La ville affichée est configurable dans le fichier `config.json` à la racine :
```json
{
  "cityName": "Montreuil",
  "countryCode": "FR",
  "latitude": 48.866669,
  "longitude": 2.43333
}
