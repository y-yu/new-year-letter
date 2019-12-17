.PHONY: all clean

LATEXMK = latexmk
CP = cp
RM = rm

TARGET = letter
CLS = jletteraddress.cls

all: $(TARGET).pdf

$(TARGET).pdf: $(CLS) $(TARGET).tex 
	$(LATEXMK) -pdfdvi $(TARGET).tex

clean:
	$(LATEXMK) -C
