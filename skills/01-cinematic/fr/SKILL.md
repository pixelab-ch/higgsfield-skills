---
name: higgsfield-cinematic-fr
description: >-
  Crée des prompts vidéo cinématographiques de qualité production pour
  Higgsfield et sélectionne le meilleur modèle (cinematic_studio_3_0 en
  principal, veo3_1 en repli). À utiliser quand l'utilisateur souhaite un
  clip de style cinéma, look film, scène de film, éclairage dramatique,
  profondeur de champ, flare d'objectif, anamorphique, letterbox, noir,
  épique, Steadicam, dolly, grue, ou toute vidéo IA de qualité Hollywood.
  Gère les demandes texte-vers-vidéo et image-vers-vidéo avec assemblage
  complet du prompt, sélection de modèle et validation des paramètres.
  Achemine aussi les demandes de photo de production et de moodboard vers
  cinematic_studio_2_5.
when_to_use: >-
  Utiliser pour look long-métrage, cinématographie heure dorée, mise au point
  progressive, plans dolly, plans grue, style objectif anamorphique, caméra
  portée style documentaire, chiaroscuro noir, étalonnage teal-and-orange, ou
  toute demande mentionnant cinématique, look film, scène de film, dramatique,
  épique ou sortie vidéo de qualité professionnelle. Utiliser aussi quand
  l'utilisateur veut une photo de production ou un moodboard avant de
  s'engager sur la vidéo.
allowed-tools: >-
  mcp__higgsfield__generate_video
  mcp__higgsfield__generate_image
  mcp__higgsfield__models_explore
  mcp__higgsfield__job_status
  mcp__higgsfield__job_display
  mcp__higgsfield__media_upload
  mcp__higgsfield__media_confirm
  mcp__higgsfield__balance
  mcp__higgsfield__show_plans_and_credits
---

# Higgsfield — Compétence Cinématique

## Ce que fait cette compétence

Crée des prompts vidéo cinématographiques prêts à la production et les
achemine vers le meilleur modèle Higgsfield pour une sortie de qualité film.
À la demande, elle assemble le jeu de paramètres complet, affiche le coût en
crédits et — après confirmation explicite de l'utilisateur — génère l'asset
via le flux de génération avec opt-in. La compétence gère également les
moodboards fixes via le chemin image `cinematic_studio_2_5`.

---

## Routage des modèles

### Modèles vidéo principal et de repli

| | cinematic_studio_3_0 (principal) | veo3_1 (repli) |
|---|---|---|
| **Justification** | Pipeline cinématique dédié ; par défaut pour toute vidéo de qualité film | Photoréalisme + audio natif quand le modèle studio est indisponible ou qu'une sortie avec voix est requise |
| **Formats d'image** | `16:9`, `9:16`, `1:1` | `16:9`, `9:16` uniquement — **pas de `1:1`** |
| **Durée** | 4–15 s (plage continue) | `4`, `6`, `8` s (ensemble discret uniquement) |
| **Paramètres réglables** | **Aucun** — passer uniquement `aspect_ratio` et `duration` | `quality` {`basic`, `high`, `ultra`} ; `model` {`veo-3-1-preview`, `veo-3-1-fast`} |
| **Rôles média** | `image`, `start_image`, `end_image` (optionnel) | `start_image` uniquement (max 1) |
| **Audio natif** | Non | Oui |

**Règle de routage :** Utiliser `cinematic_studio_3_0` par défaut. Basculer
vers `veo3_1` seulement quand : (1) le modèle principal est indisponible,
(2) l'utilisateur veut de la génération audio native, (3) l'utilisateur
demande explicitement un rendu photoréaliste et accepte la contrainte de durée
discrète.

**Directive MODEL-06 :** Si un paramètre est rejeté à la génération, appeler
`higgsfield:models_explore` avec le nom du modèle cible pour re-vérifier le
schéma en direct. Le catalogue live est la source de vérité — ne jamais
deviner les valeurs de paramètres. Tableaux de paramètres complets :
[../references/model-specs.md](../references/model-specs.md).

### Recommandations de format et durée par plateforme

| Plateforme | Format d'image | Durée | Notes |
|---|---|---|---|
| TikTok | `9:16` | 6–10 s | Plein écran vertical ; le hook doit s'installer dans les 2 premières secondes |
| Instagram Reels | `9:16` | 8–12 s | Vertical ; haute qualité visuelle attendue |
| YouTube Shorts | `9:16` ou `16:9` | 10–15 s | 15 s max convient à un arc narratif complet |
| YouTube (standard) | `16:9` | 10–15 s | Écran large ; cadence contemplative efficace |
| LinkedIn | `16:9` | 8–12 s | Format professionnel ; rythme délibéré |
| Instagram feed / Carré | `1:1` | 4–8 s | `cinematic_studio_3_0` uniquement — veo3_1 ne supporte pas `1:1` |

---

## Chemin image fixe (MODEL-05)

Pour une photo de production ou un moodboard avant de s'engager sur la vidéo,
acheminer vers `cinematic_studio_2_5` via `higgsfield:generate_image`. Ce
modèle image supporte les valeurs `resolution` `1k`, `2k` et `4k` (l'enum
`4k` est une option légitime pour CE modèle image uniquement — il ne s'applique
à aucun modèle vidéo). Formats d'image : `1:1`, `4:3`, `3:4`, `16:9`, `9:16`.
Après avoir généré le visuel fixe, l'image peut être passée en référence
`start_image` à `cinematic_studio_3_0` pour prolonger la composition établie
en vidéo. Tableau de paramètres complet :
[../references/model-specs.md](../references/model-specs.md).

---

## Flux de construction du prompt

1. **Recueillir l'intention** — Confirmer avec l'utilisateur : style créatif
   (noir, épique, intimiste, etc.), sujet, ambiance, plateforme cible, format
   d'image et durée souhaitée.

2. **Sélectionner le modèle** — Appliquer le tableau de routage ci-dessus.
   Choisir `cinematic_studio_3_0` par défaut ; sélectionner `veo3_1` seulement
   si un critère de routage s'applique ; acheminer les demandes de visuels
   fixes vers `cinematic_studio_2_5`.

3. **Construire le prompt** — Utiliser les principes de craft des références
   ci-dessous pour élaborer le prompt :
   - Hook d'ouverture (technique de capture d'attention sur 2 secondes) depuis
     [../references/hooks.md](../references/hooks.md)
   - Mouvement de caméra, installation lumineuse, étalonnage colorimétrique,
     composition depuis [../references/camera.md](../references/camera.md)
   - Exemples de prompts de production par genre/plateforme depuis
     [../references/examples.md](../references/examples.md)

4. **Présenter pour validation** — Afficher le prompt assemblé et tous les
   paramètres à l'utilisateur pour révision et affinage **avant** tout appel de
   génération. L'utilisateur doit approuver le texte du prompt, le modèle, le
   format d'image et la durée.

---

## Génération avec opt-in

La génération consomme des crédits Higgsfield et requiert une confirmation
explicite de l'utilisateur avant tout appel de génération. Cette compétence
ne génère jamais automatiquement.

**Flux complet étape par étape** (porte de confirmation, affichage solde/coût,
générer → interroger → afficher) :
[`../../../shared/generation-flow.md`](../../../shared/generation-flow.md)

**Modèle principal de cette compétence :** `cinematic_studio_3_0`

**Upload média :** Conditionnel — uniquement quand l'utilisateur fournit une
référence `start_image` ou `end_image` pour l'image-vers-vidéo. Cette compétence
n'est PAS une compétence I2V obligatoire ; la vidéo texte-vers-vidéo est le
chemin par défaut. Quand l'utilisateur fournit une image de référence, exécuter
la paire atomique `higgsfield:media_upload` → `higgsfield:media_confirm` avant
de générer.

**Signatures des outils :**
[`../../../shared/mcp-tools.md`](../../../shared/mcp-tools.md)

---

## Matériaux de référence

| Fichier | Contenu |
|---|---|
| [../references/model-specs.md](../references/model-specs.md) | Tableaux de paramètres par modèle, formats d'image, durées, justification de routage et directive de re-vérification pour cinematic_studio_3_0, veo3_1 et cinematic_studio_2_5 |
| [../references/camera.md](../references/camera.md) | Encyclopédie des mouvements de caméra (20+ mouvements), bibliothèque d'éclairages (15+ configurations), règles de composition, approches d'étalonnage, guidance sur le rythme et l'atmosphère |
| [../references/hooks.md](../references/hooks.md) | Cadre de hook sur 2 secondes, 12 techniques de hook avec gabarits de formulation pour les prompts, guidance avancée sur l'empilement de hooks |
| [../references/examples.md](../references/examples.md) | Prompts d'exemple de qualité production par genre (noir, paysage épique, dialogue dramatique, action, abstrait) avec guides de segmentation temporelle |
