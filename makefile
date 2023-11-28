# Limpieza de archivos intermedios de latex
clean:
	rm -f *.out *.log *.aux *.toc *.vrb *.snm *.nav

# Regla phony para que "clean" no sea confundido con un archivo llamado "clean"
.PHONY: clean
