#!/bin/bash


# 1. Definition des variables
SOURCE_DIR="../logs"
BACKUP_DIR="../backups" 
DATE=$(date +%Y-%m-%d)

# 2. Créer le dossier backup s'il n'existe pas
mkdir -p $BACKUP_DIR

# 3. Archiver les fichiers logs
echo "Début de l'archivage des logs le $DATE..."
tar -czvf $BACKUP_DIR/logs_$DATE.tar.gz $SOURCE_DIR/*.log

# 4. Message de fin
echo "Archivage terminé dans $BACKUP_DIR"
 
