FROM paperist/texlive-ja:alpine
ENV PATH /usr/local/bin/texlive:$PATH
ENV TEXDIR `kpsewhich amsmath.sty | sed 's|^\(/.*/tex\)/latex/.*$|\1|'`
WORKDIR /workdir
COPY .latexmkrc /root/
RUN TEXDIR=`kpsewhich amsmath.sty | sed 's|^\(/.*/tex\)/latex/.*$|\1|'` \
# bcprules.styをインストール(証明木用)
  && wget 'http://www.cis.upenn.edu/~bcpierce/papers/bcprules.sty' -O bcprules.sty \
  && install -D -m 0644 ./bcprules.sty "$TEXDIR/latex/bcprules/bcprules.sty" \
  && rm bcprules.sty
# 関連ファイル情報を更新
RUN mktexlsr
CMD ["bash"]