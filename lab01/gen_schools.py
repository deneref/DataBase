import random
import io
from random_words import RandomWords

r = RandomWords()

lang = ['Russian', 'English',\
             'Finnish', 'French', 'Italian', 'Estonian', 'Spanish',\
             'Polish', 'Ukranian']

with io.open('schools.txt','w', encoding="utf-8") as f:
    templist = []
    name = ''
    for i in range(1000):
        language = random.choice(lang)
        learning = language
        while (learning == language):
            learning = random.choice(lang)
        name = r.random_word()
            
        if language == 'Russian':
            f.write(' :'+name+' :'+'Russia'+' :'+learning+'\n')
        elif language == 'English':
            f.write(' :'+name+' :'+'USA'+' :'+learning+'\n')
        elif language == 'Finnish':
            f.write(' :'+name+' :'+'Finland'+' :'+learning+'\n')
        elif language == 'French':
            f.write(' :'+name+' :'+'France'+' :'+learning+'\n')
        elif language == 'Italian':
            f.write(' :'+name+' :'+'Italy'+' :'+learning+'\n')
        elif language == 'Estonian':
            f.write(' :'+name+' :'+'Estonia'+' :'+learning+'\n')
        elif language == 'Spanish':
            f.write(' :'+name+' :'+'Spain'+' :'+learning+'\n')
        elif language == 'Polish':
            f.write(' :'+name+' :'+'Poland'+' :'+learning+'\n')
        elif language == 'Ukranian':
            f.write(' :'+name+' :'+'Ukraine'+' :'+learning+'\n')
