import random
import io
import universities


lang = ['Russian', 'English',\
             'Finnish', 'French', 'Italian', 'Estonian', 'Spanish',\
             'Polish', 'Ukranian']
uni = universities.API()
russian = uni.search(country = "Russian Federation"); ru = []
english = uni.search(country = "United States"); eng = []
finnish = uni.search(country = "Finland"); fin = []
french = uni.search(country = "France"); fr = []
italian = uni.search(country = "Italy"); it = []
estonian = uni.search(country = "Estonia"); est = []
spanish = uni.search(country = "Spain"); esp = []
polish = uni.search(country = "Poland"); pol = []
ukranian = uni.search(country = "Ukraine"); uk = []

for i in russian:
    ru.append(i.name)
for i in english:
    eng.append(i.name)
for i in finnish:
    fin.append(i.name)
for i in french:
    fr.append(i.name)
for i in italian:
    it.append(i.name)
for i in estonian:
    est.append(i.name)
for i in spanish:
    esp.append(i.name)
for i in polish:
    pol.append(i.name)
for i in ukranian:
    uk.append(i.name)

with io.open('univercities.txt','w', encoding="utf-8") as f:
    name = ''
    for i in range(1000):
        language = random.choice(lang)
        if language == 'Russian':
            if ru != []:
                #f.write(str(i)+' :'+ru[-1]+' :'+'Россия :'+language+'\n')
                f.write(' :{} :Russia :{}\n'.format(ru[-1], language))
                ru.pop()
            else:
                language = 'English'
        elif language == 'Finnish':
            if fin != []:
                f.write(' :{} :Finland :{}\n'.format(fin[-1], language))
                fin.pop()
            else:
                language = 'English'
        elif language == 'French':
            if fr != []:
                f.write(' :{} :France :{}\n'.format(fr[-1], language))
                fr.pop()
            else:
                language = 'English'
        elif language == 'Italian':
            if it != []:
                f.write(' :{} :Italy :{}\n'.format(it[-1], language))
                it.pop()
            else:
                language = 'English'
        elif language == 'Estonian':
            if est != []:
                f.write(' :{} :Estonia :{}\n'.format(est[-1], language))
                est.pop()
            else:
                language = 'English'
        elif language == 'Spanish':
            if esp != []:
                f.write(' :{} :Spain :{}\n'.format(esp[-1], language))
                esp.pop()
            else:
                language = 'English'
        elif language == 'Polish':
            if pol != []:
                f.write(' :{} :Poland :{}\n'.format( pol[-1], language))
                pol.pop()
            else:
                language = 'English'
        elif language == 'Ukranian':
            if uk != []:
                f.write(' :{} :Ukraine :{}\n'.format( uk[-1], language))
                uk.pop()
            else:
                language = 'English'
        if language == 'English':
            if eng != []:
                f.write(' :'+eng[-1]+' :'+'USA :'+language+'\n')
                eng.pop()
     
