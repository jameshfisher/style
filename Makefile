CSSES = css/reset.css css/common.css css/print.css css/screen.css

TOCSS = stylus --compress

all: $(CSSES)

css/reset.css: src/styl/reset.styl
	$(TOCSS) < $^ > $@

css/common.css: src/styl/common.styl
	$(TOCSS) < $^ > $@

css/print.css: src/styl/print.styl src/styl/cv.styl
	cat $^ | $(TOCSS) > $@

css/screen.css: src/styl/screen.styl src/styl/cv.styl
	cat $^ | $(TOCSS) > $@

clean:
	rm -f $(CSSES)