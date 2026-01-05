#!/bin/bash

# ==============================================================================
# Script      : check_site.sh
# Description : Surveillance de disponibilité HTTP avec journalisation.
# Usage       : ./check_site.sh <URL>
# ==============================================================================

# 1. Configuration des variables
# On utilise une variable d'environnement pour le log, ou un chemin par défaut
URL="$1"
LOG_PATH="${LOG_FILE:-../logs/status.log}"
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# 2. Vérification de l'argument
if [ -z "$URL" ]; then
    echo "❌ Erreur : URL manquante."
    echo "Usage  : $0 <https://url-a-tester.com>"
    exit 1
fi

# 3. Test de connectivité avec curl
# -s : Silencieux
# -L : Suit les redirections (301, 302) -> Indispensable !
# -o /dev/null : N'affiche pas le HTML
# -w : Récupère uniquement le code de retour
# --connect-timeout : Évite que le script reste bloqué si le site est lent
CODE_HTTP=$(curl -s -L -o /dev/null -w "%{http_code}" --connect-timeout 10 "$URL")

# 4. Analyse du code de retour
if [ "$CODE_HTTP" -eq 200 ]; then
    RESULT="✅ [OK] Le site $URL est opérationnel (Code: $CODE_HTTP)"
elif [ "$CODE_HTTP" -eq 000 ]; then
    RESULT="❌ [CRITICAL] Impossible de contacter le serveur $URL"
else
    RESULT="⚠️ [WARNING] Le site $URL a répondu avec un code inhabituel (Code: $CODE_HTTP)"
fi

# 5. Sortie console et Journalisation
# On s'assure que le dossier des logs existe
mkdir -p "$(dirname "$LOG_PATH")"

echo "[$DATE] $RESULT"
echo "[$DATE] $RESULT" >> "$LOG_PATH"
