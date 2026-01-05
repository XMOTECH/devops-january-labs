#!/bin/bash

# Configuration
URL="$1"
# Utilisation d'un chemin absolu pour éviter les erreurs de dossier dans Docker
LOG_PATH="${LOG_FILE:-/logs/status.log}"
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Vérification argument
if [ -z "$URL" ]; then
    echo "Usage: $0 <URL>"
    exit 1
fi

# Récupération du code HTTP (avec -L pour suivre les redirections)
CODE_HTTP=$(curl -s -L -o /dev/null -w "%{http_code}" --connect-timeout 10 "$URL")

# Logique
if [ "$CODE_HTTP" -eq 200 ]; then
    RESULT="✅ [OK] $URL est en ligne (Code: $CODE_HTTP)"
else
    RESULT="❌ [ALERTE] $URL a un problème (Code: $CODE_HTTP)"
fi

# Création du dossier de log si inexistant et écriture
mkdir -p "$(dirname "$LOG_PATH")"
echo "[$DATE] $RESULT" | tee -a "$LOG_PATH"
