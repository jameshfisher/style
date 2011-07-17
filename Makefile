CSSES = css/reset.css css/common.css css/letter.css

TOCSS = stylus --compress

all: $(CSSES)

css/reset.css: src/styl/reset.styl
	$(TOCSS) < $^ > $@

css/common.css: src/styl/common.styl
	$(TOCSS) < $^ > $@

css/letter.css: src/styl/letter.styl
	$(TOCSS) < $^ > $@

clean:
	rm -f $(CSSES)
