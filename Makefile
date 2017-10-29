tex_files = $(wildcard *.tex)
pdf_files = $(patsubst %.tex,%.pdf,$(tex_files))
cv_types = one_page two_pages
all_tex_files = $(tex_files) $(foreach x,$(cv_types),$(wildcard $(x)/*.tex))
makefile_dep = Makefile.dep

%.pdf: %.tex
	echo $(^)
	xelatex $(<)
	rm -f *.aux *.log *.out

all: $(pdf_files)

-include $(makefile_dep)

$(makefile_dep): Makefile $(all_tex_files)
	@> $(@)
	@for x in $(cv_types); \
		do y=`ls *_$$x.tex`; \
		z=`echo $$y | sed -e "s/\.tex/\.pdf/"`; \
		echo "$$z : $$y \$$(wildcard $$x/*.tex) awesome-cv.cls" >> $(@); \
		echo "" >> $(@); \
	done

.PHONY: clean

clean:
	rm -f *.aux *.log *.out $(pdf_files) $(makefile_dep)
