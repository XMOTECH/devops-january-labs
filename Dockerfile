# 1. Image de base légère
FROM alpine:3.19

# 2. Installer curl et bash (avec miroir rapide si besoin)
RUN sed -i 's/dl-cdn.alpinelinux.org/mirror.leaseweb.com/g' /etc/apk/repositories \
    && apk add --no-cache curl bash

# 3. Définir le dossier de travail
WORKDIR /app

# 4. Copier ton script
COPY scripts/check_site.sh .

# 5. Donner les droits d’exécution
RUN chmod +x check_site.sh

# 6. Commande par défaut
ENTRYPOINT ["./check_site.sh"]
CMD ["https://google.com"]

