compress:
	pdf2ps cv.pdf tmp.ps
	ps2pdf tmp.ps cv.pdf
	rm tmp.ps

