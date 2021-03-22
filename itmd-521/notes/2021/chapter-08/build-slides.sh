#!/bin/bash

#pandoc -t slidy -s sample.md -o sample.html
# -i is for iterative (slides advance one bullet point at a time)
pandoc -i -t slidy -s chapter-08.md -o chapter-08.html 
pandoc -t beamer chapter-08.md -o chapter-08.pdf