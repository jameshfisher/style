CSSES = css/reset.css css/common.css css/print.css css/screen.css css/letter.css

TOCSS = stylus --compress

all: $(CSSES)

css/reset.css: src/styl/reset.styl
	$(TOCSS) < $^ > $@

css/common.css: src/styl/common.styl
	$(TOCSS) < $^ > $@

css/print.css: src/styl/print.styl
	$(TOCSS) < $^ > $@

css/screen.css: src/styl/screen.styl
	$(TOCSS) < $^ > $@

css/letter.css: src/styl/letter.styl
	$(TOCSS) < $^ > $@

clean:
	rm -f $(CSSES)
