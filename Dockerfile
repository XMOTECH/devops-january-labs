FROM alpine:3.19
RUN apk add --no-cache curl bash
WORKDIR /app
# Création du dossier logs à la racine du conteneur
RUN mkdir /logs 
COPY scripts/check_site.sh .
RUN chmod +x check_site.sh
ENTRYPOINT ["./check_site.sh"]
CMD ["https://google.com"]
