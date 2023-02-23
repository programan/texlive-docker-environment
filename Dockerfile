# FROM debian:buster-slim
FROM python:3.11.2-slim-bullseye

ENV PATH $PATH:/usr/local/texlive/2022/bin/x86_64-linux


# https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip
# https://noto-website-2.storage.googleapis.com/pkgs/NotoSerifCJKjp-hinted.zip


RUN set -x \
    && mkdir -p /usr/share/man/man1 \
    && mkdir -p /usr/share/plantuml \
    && apt update \
    && apt install -y \
    perl \
    vim \
    fonts-noto-cjk \
    fonts-noto-cjk-extra \
    libfontconfig-dev \
    ghostscript \
    curl \
    wget \
    tar \
    unzip \
    xz-utils \
    gcc \
    g++ \
    make \
    pandoc \
    openjdk-11-jre \
    graphviz && \
    pip install pygments && \
    cd /tmp/ && \
    curl -LO https://github.com/plantuml/plantuml/releases/download/v1.2023.1/plantuml-1.2023.1.jar && \
    mv plantuml-1.2023.1.jar /usr/share/plantuml/plantuml.jar && \
    curl -LO https://mirrors.ctan.org/fonts/haranoaji.zip && \
    curl -LO https://mirrors.ctan.org/fonts/haranoaji-extra.zip && \
    unzip haranoaji.zip && \
    unzip haranoaji-extra.zip && \
    mkdir -p /tmp/install-tl-unx && \
    curl -L ftp://tug.org/historic/systems/texlive/2022/install-tl-unx.tar.gz | \
      tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "selected_scheme scheme-basic" \
      "tlpdbopt_install_docfiles 0" \
      "tlpdbopt_install_srcfiles 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile && \
    tlmgr update --self --all && \
    tlmgr install \
      collection-latexrecommended \
      collection-latexextra \
      collection-fontsrecommended \
      collection-langjapanese \
      lualatex-math \
      xetex xecjk ctex \
      latexmk light-latex-make \
    && mkdir -p \
      /usr/local/texlive/texmf-local/fonts/opentype/google/notosanscjk/ \
    && mkdir -p \
      /usr/local/texlive/texmf-local/fonts/opentype/google/notoserifcjk/ \
    && ln -s /usr/share/fonts/opentype/noto/NotoSansCJK-*.ttc \
      /usr/local/texlive/texmf-local/fonts/opentype/google/notosanscjk/ \
    && ln -s /usr/share/fonts/opentype/noto/NotoSerifCJK-*.ttc \
      /usr/local/texlive/texmf-local/fonts/opentype/google/notoserifcjk/ \
    && mkdir -p \
      /usr/local/share/fonts/opentype/haranoaji \
    && cp /tmp/haranoaji/*.otf /usr/local/share/fonts/opentype/haranoaji/ \
    && mkdir -p \
      /usr/local/texlive/texmf-local/fonts/opentype/haranoaji \
    && ln -s /usr/local/share/fonts/opentype/haranoaji/HaranoAji*.otf \
      /usr/local/texlive/texmf-local/fonts/opentype/haranoaji/ \
    && mkdir -p \
      /usr/local/share/fonts/opentype/haranoaji-extra \
    && cp /tmp/haranoaji-extra/*.otf /usr/local/share/fonts/opentype/haranoaji-extra \
    && mkdir -p \
      /usr/local/texlive/texmf-local/fonts/opentype/haranoaji-extra \
    && ln -s /usr/local/share/fonts/opentype/haranoaji-extra/HaranoAji*.otf \
      /usr/local/texlive/texmf-local/fonts/opentype/haranoaji-extra/ \
    && mktexlsr \
    && rm -rf /var/lib/apt/lists/* \
    && rm -fr /tmp/install-tl-unx \
    && rm -f /tmp/haranoaji.zip \
    && rm -f /tmp/haranoaji-extra.zip \
    && rm -rf /tmp/haranoaji \
    && rm -rf /tmp/haranoaji-extra

RUN set -x \
    && echo '#! /bin/bash' > plantuml \
    && echo '/usr/bin/java -jar /usr/share/plantuml/plantuml.jar -svg -charset UTF-8 ${@}' >> plantuml \
    && mv plantuml /usr/local/bin/ \
    && chmod +x /usr/local/bin/plantuml


WORKDIR /workdir

# CMD ["sh"]
CMD ["/bin/bash"]
