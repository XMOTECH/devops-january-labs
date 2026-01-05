#!/bin/bash

# 1. On récupère l'URL passée en argument
URL=$1

# 2. Vérification : est-ce que l'utilisateur a bien donné une URL ?
if [ -z "$URL" ]; then
    echo "Usage: ./check_site.sh <url>"
    exit 1
fi

# 3. On récupère UNIQUEMENT le code HTTP (ex: 200, 404, 500)
# -s : silencieux (pas de barre de progression)
# -o /dev/null : on ne veut pas afficher le contenu HTML du site
# -w : on définit ce qu'on veut afficher à la fin (le code http)
CODE_HTTP=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

# 4. On récupère la date actuelle pour les logs
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# 5. Logique de décision
if ["$CODE_HTTP" -eq 200 ]; then
    RESULT=" [OK] Le site $URL répond bien (Code: $CODE_HTTP)"
else
    RESULT=" [ALERTE] Le site $URL est en panne ou inaccessible (Code: $CODE_HTTP)"
fi

# 6. Affichage à l'écran ET enregistrement dans le fichier de logs
echo "$RESULT"
echo "[$DATE] $RESULT" >> ../logs/status.log
