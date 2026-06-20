#!/bin/bash
# =====================================================================
#  Publication automatique du projet VR sur GitHub Pages
#  Double-cliquez sur ce fichier pour l'executer.
#  UE 6.2.3 - Situation probleme - Mikail Lekesiz
# =====================================================================

cd "$(dirname "$0")" || { echo "Dossier introuvable"; exit 1; }

# ----- Parametres -----
USER="lekesiz"
REPO="vr-systeme-solaire"
REMOTE="https://github.com/$USER/$REPO.git"
# ----------------------

echo "============================================================"
echo "  Publication VR -> GitHub Pages"
echo "  Dossier : $(pwd)"
echo "  Depot   : $USER/$REPO"
echo "============================================================"
echo ""

command -v git >/dev/null 2>&1 || { echo "[X] git absent. Lancez : xcode-select --install"; read -p "Entree pour fermer..."; exit 1; }

# 1) Depot local + commit
git init -q 2>/dev/null
git add .
git commit -q -m "VR Systeme Solaire - situation probleme 6.2.3" 2>/dev/null \
  || git commit -q -m "mise a jour du projet VR" 2>/dev/null
git branch -M main
echo "[OK] Commit local pret."

# 2) Creer le depot distant s'il n'existe pas encore (sinon on ignore l'erreur)
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  gh repo create "$USER/$REPO" --public >/dev/null 2>&1 \
    && echo "[OK] Depot distant cree." \
    || echo "[i] Depot distant deja existant (on continue)."
fi

# 3) S'ASSURER que le remote 'origin' est bien configure (correctif principal)
if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE"
else
  git remote add origin "$REMOTE"
fi
echo "[OK] Remote origin = $REMOTE"

# 4) Pousser (gh fournit l'authentification ; les erreurs eventuelles sont affichees)
echo ""
echo ">> Envoi des fichiers (git push)..."
if git push -u origin main; then
  echo "[OK] Push reussi !"
else
  echo "[X] Echec du push. Si une fenetre de connexion GitHub apparait, validez-la, puis relancez ce script."
  read -p "Entree pour fermer..."
  exit 1
fi

# 5) Activer GitHub Pages (branche main / racine)
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  if gh api -X POST "repos/$USER/$REPO/pages" -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1; then
    echo "[OK] GitHub Pages active."
  else
    echo "[i] Pages deja active (ou a activer dans Settings > Pages)."
  fi
fi

echo ""
echo "============================================================"
echo "  TERMINE !"
echo "  Code  : https://github.com/$USER/$REPO"
echo "  Site  : https://$USER.github.io/$REPO/   (en ligne sous ~1 min)"
echo "============================================================"
open "https://$USER.github.io/$REPO/" 2>/dev/null

echo ""
read -p "Appuyez sur Entree pour fermer cette fenetre..."
