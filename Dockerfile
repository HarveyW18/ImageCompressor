# Utiliser une image de base Ubuntu 20.04 LTS
FROM ubuntu:20.04

# Ajouter l'architecture i386 et les dépôts nécessaires
RUN dpkg --add-architecture i386

# Mettre à jour le système et installer les dépendances nécessaires
RUN apt-get update && \
    apt-get install -y \
        software-properties-common && \
    add-apt-repository "deb [arch=amd64,i386] http://archive.ubuntu.com/ubuntu focal main restricted universe multiverse" && \
    add-apt-repository "deb [arch=amd64,i386] http://archive.ubuntu.com/ubuntu focal-updates main restricted universe multiverse" && \
    add-apt-repository "deb [arch=amd64,i386] http://archive.ubuntu.com/ubuntu focal-security main restricted universe multiverse" && \
    apt-get update && \
    apt-get install -y \
        python3 \
        python3-pip \
        wine \
        wine32 \
        build-essential \
        git \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Installer PyInstaller
RUN pip3 install pyinstaller

# Copier le script dans le conteneur
COPY an.py /app/an.py

# Définir le répertoire de travail
WORKDIR /app

# Exécuter PyInstaller
CMD ["wine", "python3", "-m", "PyInstaller", "--onefile", "an.py"]
