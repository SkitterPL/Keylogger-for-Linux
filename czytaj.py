import datetime


plik = open("/home/bartek/SO/ds/klawisze.txt", "r")
linie = plik.readlines()
plik.close()

tab = ['nul']*100
 
for linia in linie:
	if linia[0] == "k":
          tab.insert(int(linia[8:10]),linia[12:len(linia)-1])
         

temp = open("/home/bartek/SO/ds/showkey.txt", "r")
linie = temp.readlines()
temp.close()
plik = open("/home/bartek/SO/ds/wyjscie.txt", "a")
 
index = 0
for linia in linie:
        #jesli w danym momencie zostal klikniety klawisz to dopiero wtedy pokazujemy date i godzine
	    if linia[0:5] == "keyco": 
		if index == 0:
		     	plik.write("\n \n"+datetime.datetime.now().strftime("%H:%M %B %d, %Y")+"\n_______________________________________________\n")

        #czytanie klawiszy

		index = int(linia[9:11])

		if (index==42 or index==54) and linia[12:len(linia)-1]=="press":
		 	plik.write("<Wcisnieto Shift>")

		elif index==58 and linia[12:len(linia)-1]=="press":		
			plik.write("<Wcisnieto CapsLk>")

		elif index==28 and linia[12:len(linia)-1]=="release":
			plik.write("\n")

		elif index==57 and linia[12:len(linia)-1]=="release":
			plik.write("\t")

		elif (index==42 or index==54) and linia[12:len(linia)-1]=="release":
		 	plik.write("<Puszczono Shift>")

		elif index==58 and linia[12:len(linia)-1]=="release":		
			plik.write("<Puszczono CapsLk>")

		elif linia[12:len(linia)-1]=="release":
			plik.write(tab[index])
 
plik.close()
