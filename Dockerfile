FROM rocker/shiny-verse:4.2.2

COPY scripts/install_pandoc_latest.sh rocker_scripts

RUN apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y xz-utils \
    && apt-get install -y xdg-utils \
    && apt-get install -y bzip2 \
    && apt-get install -y qpdf \
    && apt-get install -y libegl1 \
    && apt-get install -y libopengl0 \
    && apt-get install -y libnss3 \
    && mkdir /usr/share/desktop-directories/ \
    && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin \
    && rocker_scripts/install_pandoc_latest.sh \
    && apt-get install -y chromium-browser \
    && Rscript -e "install.packages('shiny')" \
    && Rscript -e "install.packages('shinytest')" \
    && Rscript -e "if (!shinytest::dependenciesInstalled()) shinytest::installDependencies()" \
    && Rscript -e "install.packages('shinytest2', dependencies = TRUE)"
