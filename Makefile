.PHONY: all

all:
	typst c main.typ slide.pdf
	sed -i 's/handout: false/handout: true/' main.typ
	typst c main.typ handout.pdf
	sed -i 's/handout: true/handout: false/' main.typ
