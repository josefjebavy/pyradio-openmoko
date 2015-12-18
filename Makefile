#ICON=pyradio.png
NAME=pyradio
FILES=$(NAME)
DATAFILES=stations.csv

LASTVERSION=0.2-r1
IPKLAST=$(NAME)_$(LASTVERSION)_all.ipk
cilovyAdresar=/media/card/python
DEPENDS="python-core python-audio python-netclient python-curses"

cp:
	scp $(IPKLAST)  192.168.0.202:$(cilovyAdresar)/

install:
	ssh root@192.168.0.202 'opkg install $(cilovyAdresar)/$(IPKLAST)'


ipk:	package
pk:	package
package:
	mkdir -p package-ipkg/CONTROL package-ipkg/usr/bin package-ipkg/usr/share/applications package-ipkg/usr/share/pixmaps package-ipkg/usr/share/$(NAME)/
	#cp $(ICON) package-ipkg/usr/share/pixmaps/
	echo -e Package: pyradio \\n\
	Section: extras \\n\
	Priority: optional \\n\
	Version: 0.2-r1 \\n\
	Architecture: all \\n\
	Source: http://www.coderholic.com/pyradio  \\n\
	"Maintainer: Josef Jebavy <josef.jebavy[at]gmail.com>" \\n\
	Depends: $(DEPENDS) \\n\
	Description: TUI program in python for receiver stream of internet radio \\n > package-ipkg/CONTROL/control
	cp $(FILES) package-ipkg/usr/bin/
	cp $(NAME).desktop package-ipkg/usr/share/applications/
	cp $(DATAFILES) package-ipkg/usr/share/$(NAME)/
	ipkg-build  -o root -g root ./package-ipkg/ ./
	rm -rf ./package-ipkg/






