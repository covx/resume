# Makefile twentyseconds cv

files_tex = $(wildcard *.tex)
cv_name = "maksym_cherniatevych_resume"
all: pdf
	@echo "Done!"
pdf: *.tex
	@echo "Building.... $^"
	@$(foreach var,$(files_tex),pdflatex -interaction=nonstopmode -jobname=$(cv_name) '$(var)' 1>/dev/null;)
clean:
	@rm -f *.aux *.dvi *.log *.out *.bak
	@echo "Clean done.";
