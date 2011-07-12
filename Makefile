CSSES = css/reset.css css/common.css css/print.css css/screen.css

TOCSS = stylus --compress
TOPDF = wkhtmltopdf --print-media-type --margin-top 2cm --margin-right 2cm --margin-bottom 0 --margin-left 2cm

fromscratch: clean all

all: $(CSSES) cv.pdf

css/reset.css: src/reset.styl
	$(TOCSS) < $^ > $@

css/common.css: src/common.styl
	$(TOCSS) < $^ > $@

css/print.css: src/print.styl src/cv.styl
	cat $^ | $(TOCSS) > $@

css/screen.css: src/screen.styl src/cv.styl
	cat $^ | $(TOCSS) > $@

cv.pdf: index.html $(CSSES)
	$(TOPDF) index.html cv.pdf

clean:
	rm $(CSSES) cv.pdf

