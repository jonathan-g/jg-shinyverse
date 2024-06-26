FROM rocker/shiny-verse:4.3.3

COPY scripts/install_pandoc_latest.sh rocker_scripts

RUN echo 'options(repos = c(P3M = "https://p3m.dev/cran/__linux__/jammy/latest", CRAN = "https://cloud.r-project.org"))' >> "${R_HOME}/etc/Rprofile.site"

RUN apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y xz-utils \
    && apt-get install -y xdg-utils \
    && apt-get install -y bzip2 \
    && apt-get install -y qpdf \
    && apt-get install -y libegl1 \
    && apt-get install -y libopengl0 \
    && apt-get install -y libnss3 \
    && apt-get install -y libxcb-cursor0 \
    && mkdir /usr/share/desktop-directories/ \
    && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin \
    && rocker_scripts/install_pandoc_latest.sh \
    && apt-get install -y chromium-browser \
    && Rscript -e "install.packages('shiny')" \
    && Rscript -e "install.packages('shinytest')" \
    && Rscript -e "if (!shinytest::dependenciesInstalled()) shinytest::installDependencies()" \
    && Rscript -e "install.packages('shinytest2', dependencies = TRUE)"
