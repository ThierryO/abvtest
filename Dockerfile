FROM inbobmk/rn2k

## This handle reaches Thierry
MAINTAINER "Thierry Onkelinx" thierry.onkelinx@inbo.be

## Set a default user. Available via runtime flag `--user docker`
## Add user to 'staff' group, granting them write privileges to /usr/local/lib/R/site.library
## User should also have & own a home directory (for rstudio or linked volumes to work properly).
RUN useradd docker \
  && mkdir /home/docker \
  && chown docker:docker /home/docker \
  && addgroup docker staff

## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen en_US.utf8 \
  && /usr/sbin/update-locale LANG=en_US.UTF-8

## Install n2khelper from Github
RUN Rscript -e 'devtools::install_github("inbo/n2khelper", ref = "develop", upgrade_dependencies = FALSE)'

## Install n2kanalysis from Github
RUN Rscript -e 'devtools::install_github("inbo/n2kanalysis", ref = "develop", upgrade_dependencies = FALSE)'

## Install abvanalysis from Github
RUN Rscript -e 'devtools::install_github("inbo/abvanalysis", ref = "develop", upgrade_dependencies = FALSE)'
