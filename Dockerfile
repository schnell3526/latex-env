# イメージ選択
FROM frolvlad/alpine-glibc

# 環境変数の設定
ENV PATH /usr/local/texlive/2020/bin/x86_64-linuxmusl:$PATH

RUN \
    # コンパイル等に必要なツールをダウンロード
    apk add --no-cache curl perl fontconfig-dev freetype-dev && \
    # 圧縮ファイルのダウンロード(最後に削除)
    apk add --no-cache --virtual .fetch-deps xz tar wget && \
    # texliveのインストール
    mkdir /tmp/install-tl-unx && \
    curl -L ftp://tug.org/historic/systems/texlive/2020/install-tl-unx.tar.gz | \
        tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "selected_scheme scheme-basic" \
      "tlpdbopt_install_docfiles 0" \
      "tlpdbopt_install_srcfiles 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile && \
    tlmgr install \
      collection-latexextra \
      collection-fontsrecommended \
      collection-langjapanese \
      latexmk && \
    rm -fr /tmp/install-tl-unx && \
    # ダウンロードに使ったソフトを削除
    apk del .fetch-deps && \
    # latexmkrcに記入
    { \
        echo "#!/usr/bin/env perl"; \
        echo "\$latex            = 'uplatex -synctex=1 -halt-on-error';"; \
        echo "\$bibtex           = 'upbibtex';"; \
        echo "\$biber            = 'biber --bblencoding=utf8 -u -U --output_safechars';"; \
        echo "\$dvipdf           = 'dvipdfmx %O -o %D %S';"; \
        echo "\$makeindex        = 'mendex %O -o %D %S';"; \
        echo "\$max_repeat       = 5;"; \
        echo "\$pdf_mode         = 3;"; \
        echo "\$pvc_view_file_via_temporary = 0;"; \
    } >> /root/.latexmkrc

WORKDIR /workdir