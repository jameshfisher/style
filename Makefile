CSSES = css/reset.css css/common.css css/print.css css/screen.css

all: $(CSSES)

css/reset.css: src/reset.styl
	stylus --compress < $^ > $@

css/common.css: src/common.styl
	stylus --compress < $^ > $@

css/print.css: src/print.styl src/cv.styl
	cat $^ | stylus --compress > $@

css/screen.css: src/screen.styl src/cv.styl
	cat $^ | stylus --compress > $@

compress:
	pdf2ps cv.pdf tmp.ps
	ps2pdf tmp.ps cv.pdf
	rm tmp.ps

clean:
	rm $(CSSES)
