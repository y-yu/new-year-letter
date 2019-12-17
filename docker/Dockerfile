FROM alpine:3.10

LABEL maintainer="yyu <yyu [at] mental.poker>"

ENV TEXLIVE_DEPS \
    xz \
    tar \
    fontconfig-dev \
    zlib-dev \
    gnupg \
    musl-dev \
    alpine-sdk \
    pkgconfig \
    gmp-dev

ENV TEXLIVE_PATH /usr/local/texlive

ENV FONT_DEPS \
    unzip

ENV FONT_PATH /usr/local/texlive/texmf-local/fonts

ENV PERSISTENT_DEPS \
    wget \
    make \
    perl \
    ghostscript \
    bash \
    git \
    ca-certificates

ENV PATH $TEXLIVE_PATH/bin/x86_64-linux:/bin:$PATH

RUN apk upgrade --update

# Install basic dependencies
RUN apk add --no-cache --virtual .persistent-deps $PERSISTENT_DEPS

# Install glibc
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk && \
    apk add glibc-2.30-r0.apk

# Install TeXLive
RUN apk add --no-cache --virtual .texlive-deps $TEXLIVE_DEPS && \
    mkdir /tmp/install-tl-unx && \
    wget -qO- http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | \
      tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "TEXDIR $TEXLIVE_PATH" \
      "selected_scheme scheme-small" \
      "option_doc 0" \
      "option_src 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      -profile /tmp/install-tl-unx/texlive.profile && \
    tlmgr install latexmk collection-langjapanese xstring  \
      collection-fontsrecommended letltxmacro && \
    rm -rf /tmp/install-tl-unx && \
    apk del .texlive-deps

# Setup fonts
RUN apk add --no-cache --virtual .font-deps $FONT_DEPS && \
    # Noto Serif
    mkdir -p "$FONT_PATH/opentype/google/notoserif/" && \
      wget https://noto-website-2.storage.googleapis.com/pkgs/NotoSerif-unhinted.zip && \
      unzip -d NotoSerif-unhinted NotoSerif-unhinted.zip && \
      cp -p NotoSerif-unhinted/*.ttf "$FONT_PATH/opentype/google/notoserif/" && \
      rm -rf NotoSerif-unhinted.zip NotoSerif-unhinted && \
    # Noto Sans CJK JP
    mkdir -p "$FONT_PATH/opentype/google/notosanscjk/" && \
      wget https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip && \
      unzip -d NotoSansCJKjp-hinted NotoSansCJKjp-hinted.zip && \
      cp -p NotoSansCJKjp-hinted/*.otf "$FONT_PATH/opentype/google/notosanscjk/" && \
      rm -rf NotoSansCJKjp-hinted.zip NotoSansCJKjp-hinted && \
    # Noto Serif CJK JP
    mkdir -p "$FONT_PATH/opentype/google/notoserifcjk/" && \
      wget https://noto-website-2.storage.googleapis.com/pkgs/NotoSerifCJKjp-hinted.zip && \
      unzip -d NotoSerifCJKjp-hinted NotoSerifCJKjp-hinted.zip && \
      cp -p NotoSerifCJKjp-hinted/*.otf "$FONT_PATH/opentype/google/notoserifcjk/" && \
      rm -rf NotoSerifCJKjp-hinted.zip NotoSerifCJKjp-hinted && \
    mktexlsr && \
    kanji-config-updmap-sys noto && \
    apk del .font-deps 

VOLUME ["/workdir"]

WORKDIR /workdir

ENTRYPOINT ["/bin/bash", "-c", "make"]
