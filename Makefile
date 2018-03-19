STANDALONE_TEX_SOURCES = $(wildcard standalone*.tex)
PDF_FILES := $(STANDALONE_TEX_SOURCES:.tex=.pdf)
SVG_FILES := $(STANDALONE_TEX_SOURCES:.tex=.svg)
PNG_FILES := $(STANDALONE_TEX_SOURCES:.tex=.png)

all: pdf svg png

.PHONY: clean pdf svg png

pdf: $(PDF_FILES)
svg: $(SVG_FILES)
png: $(PNG_FILES)

%.pdf: %.tex
	latexmk -pdf $<

#%.dvi: %.tex
#	latexmk -dvi $<

#%.svg: %.dvi
#	dvisvgm --no-fonts $<

%.png: %.pdf
	pdftoppm -singlefile -png -r 200 $< $(basename $@)

%.svg: %.pdf
	pdf2svg $< $@

clean:
	rm -f $(PDF_FILES) $(SVG_FILES)
