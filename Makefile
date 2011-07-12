CSSES = css/reset.css css/common.css css/print.css css/screen.css

all: $(CSSES) cv.pdf

css/reset.css: src/reset.styl
	stylus --compress < $^ > $@

css/common.css: src/common.styl
	stylus --compress < $^ > $@

css/print.css: src/print.styl src/cv.styl
	cat $^ | stylus --compress > $@

css/screen.css: src/screen.styl src/cv.styl
	cat $^ | stylus --compress > $@

cv.pdf: index.html $(CSSES)
	wkhtmltopdf --print-media-type index.html cv.pdf

clean:
	rm $(CSSES) cv.pdf

fromscratch: clean all
