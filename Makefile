CSSES = css/common.css css/letter.css

TOCSS = stylus --compress

all: $(CSSES)

css/common.css: src/styl/common.styl
	$(TOCSS) $^ -o css

css/letter.css: src/styl/letter.styl
	$(TOCSS) $^ -o css

clean:
	rm -f $(CSSES)