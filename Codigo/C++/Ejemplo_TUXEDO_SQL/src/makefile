APPDIR=..
SRCDIR=$(APPDIR)/src
INCDIR=$(APPDIR)/include
EXEDIR=$(APPDIR)/bin
## INI ARTV - Control de versiones
LFLDIR=$(APPDIR)/L_files
## FIN ARTV - Control de versiones

####### RUTAS DE Librerias de Tuxedo

TUXDIR=/tuxedo8.0
TUXINCDIR=$(TUXDIR)/include
TUXINCLIB=$(TUXDIR)/lib
TUXINCFML=/opt/s617/tuxedo/fml
SMEINCDIR=/opt/s617/180/tuxedo/include


CFLAG01= -I$(INCDIR) -I$(TUXINCDIR) -I$(TUXINCFML) -I$(SMEINCDIR) -I$(TUXINCLIB) \
		 -DREFERENCIA -D_OSS -Wextensions -Wsaveabend -DNOWHAT -Wallow_cplusplus_comments \
		 -WTandem_float

CFLAG02= -I$(INCDIR) -I$(TUXINCDIR) -I$(TUXINCFML) -I$(SMEINCDIR) -DNOWHAT -WTandem_float -Wextensions -Wsaveabend -Wallow_cplusplus_comments

CFLAGS4= -g -I$(INCDIR) -I$(TUXINCDIR) -I$(TUXINCFML) -I$(TUXINCLIB) -I$(INCDIR) -DREFERENCIA -D_OSS -Wextensions \
		 -Wsaveabend -DNOWHAT -WTandem_float -Wallow_cplusplus_comments

FLGCTRLVERSION= -g -Wnosuppress

WSQLCOMP=-Wv -Wsqlcomp=\"catalog =base, currentdefines, recompileondemand, explain plan, explain defines, obeyform\"

INF_SERVER_SRC=$(SRCDIR)/srvTuxCall.c
INF_SERVER_INC=$(INCDIR)/srvTuxCall.h
INF_SERVER_EXE=$(EXEDIR)/srvTuxCall.o
INF_SERVER_OBJ=$(EXEDIR)/srvTuxCall


all: creadir clean servidor move

srvTuxCall: $(INF_SERVER_EXE)
$(INF_SERVER_EXE):$(INF_SERVER_SRC)
	@echo --------------------------------------------------------------------
	@echo Construyendo Objeto $(@)
	@echo Compilando $(@F) porque cambiaron $(?F)
	@echo --------------------------------------------------------------------
	c89 $(FLGCTRLVERSION) $(CFLAG01) -Wsql -Wextensions -c $(INF_SERVER_SRC) -o $(@)
	@echo	Ok!

servidor: $(INF_SERVER_OBJ)
	@echo >/dev/null
$(INF_SERVER_OBJ):$(INF_SERVER_EXE)
	@echo --------------------------------------------------------------------
	@echo Construyendo Servidor Tuxedo $(@)
	@echo Compilando $(@F) porque cambiaron $(?F)
	@echo --------------------------------------------------------------------
	CFLAGS="$(FLGCTRLVERSION) $(CFLAG01) $(WSQLCOMP)" \
	buildserver -s OPI_TuxCall -o $(@) -f $(INF_SERVER_EXE)
	@echo	Ok!

creadir:
	@if [ ! -d $(LFLDIR) ]; then \
		mkdir $(LFLDIR); \
		echo "Construyendo $(LFLDIR)"; \
	fi
	@fi [ ! -d $(EXEDIR) ]; then \
		mkdir $(EXEDIR); \
		echo "Construyendo $(EXEDIR)"; \
	fi

clean:
	@if [ -e *.L ]; then \
		rm -f *.L; \
		echo "Se detectan archivos *.L antes de compilar, se borran..."; \
	fi
	@echo --------------------------------------------------------------------
	@echo Borrado completo de los directorios $(LFLDIR) y $(EXEDIR)
	@rm -rf $(LFLDIR)/*
	@rm -rf $(EXEDIR)/*
	@echo --------------------------------------------------------------------
	@echo Listo para usarse !!!
	@echo --------------------------------------------------------------------

move:
	@if [ -e *.L ]; then \
		mv *.L $(LFLDIR); \
		echo "Moviendo *.L a $(LFLDIR)"; \
	fi