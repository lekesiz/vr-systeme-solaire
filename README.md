# VoyageVR — Atelier virtuel d'apprentissage du Système Solaire

**UE 6.2.3 — Applications interactives et immersives en réalité virtuelle (VR)**
**LP DWCA 2025/2026 · Université de Strasbourg / SFC · Tuteur : M. NGU**
**Auteur : Mikail Lekesiz** *(à compléter avec les co-équipiers du groupe : 3–4 personnes)*

---

## 1. Réponse à la situation problème

La consigne demande de **concevoir et développer une application numérique 3D** permettant
**d'analyser l'impact de certaines actions des utilisateurs** dans un monde virtuel sur leur
apprentissage, en intégrant **trois types d'actions** :

| Action exigée | Mise en œuvre dans l'application |
|---|---|
| **Observation du monde virtuel** | Le joueur regarde les planètes en rotation, lit les étiquettes 3D et les **panneaux d'information** affichés au clic. Chaque planète réellement étudiée est comptabilisée. |
| **Déplacement dans le monde virtuel** | Marche libre (WASD / flèches + souris) **et** système de **téléportation** : des anneaux verts (`teleport-pad`) déplacent le joueur d'une station-planète à l'autre. Compatible casque VR. |
| **Interaction avec des objets 3D** | Clic (souris **ou** regard/fuse en VR) sur les planètes et sur le **kiosque-quiz**. Les réponses au quiz évaluent les connaissances acquises. |

### Analyse de l'impact sur l'apprentissage
Un **tableau de bord pédagogique** (HUD) enregistre en temps réel, pour chaque session :
planètes observées (0/5), nombre de téléportations, nombre d'interactions, score au quiz, et un
**indice de progression composite** (50 % observation + 50 % quiz). Cette instrumentation est
exactement le « volet analyse » demandé : elle relie les **actions réalisées** (observer, se
déplacer, interagir) au **résultat d'apprentissage** (score). Les variables sont centralisées dans
l'objet JavaScript `learning` et peuvent être facilement exportées (CSV / `localStorage` /
envoi serveur) pour une étude quantitative ultérieure.

---

## 2. Choix pédagogique et justification

Thème retenu : **découverte du Système Solaire** (cycle 4 / seconde, ou grand public).
Justification : sujet à **forte charge visuelle et spatiale**, où la 3D immersive apporte une
plus-value réelle par rapport à un support 2D (perception des tailles, distances, rotations).
Les trois actions y sont **naturellement signifiantes** : on *observe* les astres, on *se déplace*
entre eux, on *interagit* pour révéler l'information puis on s'auto-évalue. Le cadre est
**remplaçable** sans changer l'architecture (sécurité au travail, anatomie, patrimoine, etc.).

---

## 3. Architecture technique

- **Framework** : A-Frame 1.7.0 (CDN officiel), basé sur Three.js / WebXR — cohérent avec les
  projets exemples du cours (`gducampus/lpdwca25`, Projets 1–10).
- **Fichier unique** `index.html` (aucune installation, aucune dépendance externe à héberger).
- **Composants A-Frame personnalisés** (en JavaScript) :
  - `teleport-pad` : déplace le rig joueur vers la position monde du pad au clic.
  - `quiz-control` : machine à états du quiz (5 questions, boutons-réponses générés dynamiquement).
  - planètes `.clickable` : affichent un panneau d'information et incrémentent les compteurs.
- **Primitives & techniques mobilisées** (vues en cours) : `a-sphere`, `a-box`, `a-plane`,
  `a-ring`, `a-text`, `material` (emissive), `animation` (rotation/orbite/pulse),
  `raycaster` + `cursor` (souris **et** fuse VR), `movement-controls`, génération procédurale
  d'un champ d'étoiles.

---

## 4. Utilisation / test

**En local :** ouvrir `index.html` dans un navigateur moderne (Chrome / Firefox / Edge).
Aucune compilation requise.

- Desktop : `Z/Q/S/D` ou flèches pour marcher, souris pour regarder, clic sur les anneaux verts
  pour se téléporter, clic sur une planète pour l'étudier, clic sur le kiosque pour le quiz.
- Casque VR : bouton **« VR »** en bas à droite (WebXR).

**En ligne (hébergement demandé par la consigne) :** déposer le dossier sur GitHub Pages,
Netlify ou Vercel. Comme tout est dans un seul fichier statique, le déploiement est immédiat.

---

## 5. Travail en équipe (à finaliser)

La consigne impose un **dépôt Git** et une **équipe de 3 à 4 personnes**. Étapes restantes :

1. Créer/forker un dépôt Git de groupe et y pousser ce dossier.
2. Répartir les rôles (conception/UX, scènes 3D, scripts d'interaction, hébergement) et tracer
   les tâches via les **issues** Git.
3. Compléter la liste des co-équipiers en tête de ce document.
4. Héberger l'application et coller l'URL publique dans le dépôt + le dépôt DigitalUni si demandé.

> ⚠️ Ce livrable est une **base individuelle fonctionnelle** produite par Mikail. Il doit être
> intégré au travail collectif du groupe avant le dépôt final pour validation de l'UE 6.2.3.
