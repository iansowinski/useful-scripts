iloscOsob = int(input('Podaj liczbe osob na imprezie: '))
osoby = []
hajsy = []
razem = 0
def gender(name):
    if name[-1] == 'a':
        return "wyszła"
    else:
        return "wyszedł"
for i in range(iloscOsob):
    osoby.append(input('Podaj imie osoby: '))
    hajsy.append(int(input('Podaj ile ta osoba zaplacila: ')))
for i in range(len(hajsy)):
    razem = razem + hajsy[i]
print('Wydana przez Was suma to ' + str(razem) + ' zl.')
naLebka = razem / len(hajsy)
reszta = razem % len(hajsy)
resztaNaLebka = 0
if reszta > 0:
    resztaNaLebka = float(reszta) / float(len(hajsy))
    naLebka = naLebka + resztaNaLebka
print('Kazdy musi zaplacic ' + str(naLebka) + ' zl.')
doZwrotu = []
doZaplacenia = []
for i in range(len(hajsy)):
    if hajsy[i] > naLebka:
        doZwrotu.append(float(hajsy[i] - naLebka))
        doZaplacenia.append(0)
        print(str(osoby[i]) + ' musi odzyskac ' + str(round(doZwrotu[i], 2)) + ' zl.')
    elif hajsy[i] == 0:
        doZwrotu.append(0)
        doZaplacenia.append(0)
        print(str(osoby[i]) + ' ' + gender(str(osoby[i])) + ' na 0.')
    else:
        doZwrotu.append(0)
        doZaplacenia.append(float(naLebka - hajsy[i]))
        print(str(osoby[i]) + ' musi zaplaic jeszcze ' + str(round(doZaplacenia[i], 2)) + ' zl.')
