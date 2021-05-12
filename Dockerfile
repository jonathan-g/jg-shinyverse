FROM rocker/shinyverse:4.0.5

COPY scripts/install_pandoc_latest.sh rocker_scripts

RUN apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y qpdf \
    && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin \
    && rocker_scripts/install_pandoc_latest.sh \
    && install2r shiny \
    && install2r shinytest \
    && Rscript -e "if (!shinytest::dependenciesInstalled()) shinytest::installDependencies()"
