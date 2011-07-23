CSSES = css/common.css css/letter.css css/cv.css

TOCSS = stylus --compress

all: $(CSSES)

css/common.css: src/styl/common.styl
	$(TOCSS) $^ -o css

css/letter.css: src/styl/letter.styl
	$(TOCSS) $^ -o css

css/cv.css: src/styl/cv.styl
	$(TOCSS) $^ -o css

clean:
	rm -f $(CSSES)