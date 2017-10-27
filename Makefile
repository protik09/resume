tex_files = $(wildcard *.tex)
pdf_files = $(patsubst %.tex,%.pdf,$(tex_files))

%.pdf: %.tex $(wildcard resume/*.tex)
	xelatex $(<)
	rm -f *.aux *.log *.out

all: $(pdf_files)

.PHONY: clean

clean:
	rm -f *.aux *.log *.out $(pdf_files)
