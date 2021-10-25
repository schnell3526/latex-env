FROM paperist/texlive-ja:alpine
ENV PATH /usr/local/bin/texlive:$PATH
WORKDIR /workdir
COPY .latexmkrc /root/

ENV TEXDIR /usr/local/texlive/2021/texmf-dist/tex

# bcprules(証明木)
RUN wget 'http://www.cis.upenn.edu/~bcpierce/papers/bcprules.sty' -O bcprules.sty \
  && install -D -m 0644 ./bcprules.sty "${TEXDIR}/latex/bcprules/bcprules.sty" \
  && rm -rf bcprules.sty

# bussproofs(証明木)
RUN wget 'https://math.ucsd.edu/~sbuss/ResearchWeb/bussproofs/bussproofs.sty' -O bussproofs.sty \
  && install -D -m 0644 ./bussproofs.sty "$TEXDIR/latex/bussproofs/bussproofs.sty" \
  && rm -rf bussproofs.sty

# algorithms(擬似アルゴリズム)
RUN wget 'http://mirrors.ctan.org/macros/latex/contrib/algorithms.zip' -O algorithms.zip \
  && unzip algorithms.zip \
  && cd algorithms \
  && latex -halt-on-error -interaction=nonstopmode algorithms.ins \
  && install -D -m 0644 algorithmic.sty "$TEXDIR/latex/algorithms/algorithmic.sty" \
  && install -D -m 0644 algorithm.sty "$TEXDIR/latex/algorithms/algorithm.sty" \
  && cd ../ \
  && rm -rf algorithms algorithms.zip

# algorithmicx(擬似アルゴリズム)
RUN wget 'https://mirrors.ctan.org/macros/latex/contrib/algorithmicx.zip' -O algorithmicx.zip \
  && unzip algorithmicx.zip \
  && install -d "$TEXDIR/latex/algorithmicx/" \
  && install -m 0644 algorithmicx/*.sty "$TEXDIR/latex/algorithmicx/" \
  && rm -rf algorithmicx algorithmicx.zip

# 関連ファイル情報を更新
RUN mktexlsr

CMD ["bash"]