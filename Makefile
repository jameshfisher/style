CSSES = reset.css common.css print.css screen.css

TOCSS = stylus --compress

all: $(CSSES)

reset.css: src/reset.styl
	$(TOCSS) < $^ > $@

common.css: src/common.styl
	$(TOCSS) < $^ > $@

print.css: src/print.styl src/cv.styl
	cat $^ | $(TOCSS) > $@

screen.css: src/screen.styl src/cv.styl
	cat $^ | $(TOCSS) > $@

clean:
	rm -f $(CSSES)