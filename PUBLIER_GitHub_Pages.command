#!/bin/bash
# =====================================================================
#  Publication automatique du projet VR sur GitHub Pages
#  Double-cliquez sur ce fichier pour l'exécuter.
#  UE 6.2.3 - Situation problème - Mikail Lekesiz
# =====================================================================

# Se placer dans le dossier de ce script (gère les espaces / caractères spéciaux)
cd "$(dirname "$0")" || { echo "Dossier introuvable"; exit 1; }

# ----- Paramètres (modifiez si besoin) -----
USER="lekesiz"                 # votre nom d'utilisateur GitHub
REPO="vr-systeme-solaire"      # nom du dépôt à créer
# -------------------------------------------

echo "============================================================"
echo "  Publication VR -> GitHub Pages"
echo "  Dossier : $(pwd)"
echo "  Compte  : $USER   Depot : $REPO"
echo "============================================================"
echo ""

# 1) Vérifier que git est installé
if ! command -v git >/dev/null 2>&1; then
  echo "[X] git n'est pas installe. Installez Xcode Command Line Tools :"
  echo "    xcode-select --install"
  echo ""
  read -p "Appuyez sur Entree pour fermer..."
  exit 1
fi

# 2) Initialiser le depot local + commit (message ASCII -> pas de souci de guillemets)
git init -q 2>/dev/null
git add .
git commit -q -m "VR Systeme Solaire - situation probleme 6.2.3" 2>/dev/null \
  || git commit -q -m "mise a jour du projet VR" 2>/dev/null
git branch -M main
echo "[OK] Depot local pret et commit effectue."
echo ""

# 3) Route automatique avec GitHub CLI (gh) si disponible et connecte
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  echo "[OK] GitHub CLI detecte et connecte. Creation + publication automatiques..."
  gh repo create "$USER/$REPO" --public --source=. --remote=origin --push 2>/dev/null \
    || git push -u origin main
  # Activer GitHub Pages (branche main / racine)
  gh api -X POST "repos/$USER/$REPO/pages" \
     -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1
  echo ""
  echo "============================================================"
  echo "  TERMINE !"
  echo "  URL du site (disponible sous ~1 minute) :"
  echo "     https://$USER.github.io/$REPO/"
  echo "============================================================"
  open "https://github.com/$USER/$REPO/settings/pages"
else
  # 4) Pas de gh : on configure le remote et on tente un push direct
  echo "[i] GitHub CLI (gh) absent ou non connecte -> mode manuel assiste."
  git remote remove origin 2>/dev/null
  git remote add origin "https://github.com/$USER/$REPO.git"
  echo ""
  echo "Tentative de push vers https://github.com/$USER/$REPO ..."
  if git push -u origin main 2>/dev/null; then
    echo "[OK] Push reussi !"
    echo "  -> Allez sur GitHub : Settings > Pages > Branch 'main' / root > Save"
    open "https://github.com/$USER/$REPO/settings/pages"
  else
    echo ""
    echo "[!] Le depot '$REPO' n'existe pas encore (ou non authentifie)."
    echo "    1. La page de creation GitHub va s'ouvrir."
    echo "    2. Nom du depot : $REPO   | Public   | NE PAS ajouter de README"
    echo "    3. Cliquez 'Create repository'."
    echo "    4. Relancez (double-clic) ce script : il poussera tout automatiquement."
    open "https://github.com/new"
  fi
fi

echo ""
read -p "Appuyez sur Entree pour fermer cette fenetre..."
