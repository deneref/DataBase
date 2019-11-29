from faker import Faker
import random
import io


fake = Faker()

lang = ['Russian', 'English',\
             'Finnish', 'French', 'Italian', 'Estonian', 'Spanish',\
             'Polish', 'Ukranian']

with io.open('students.txt','w', encoding="utf-8") as f:
    templist = []
    name = ''
    for i in range(1000):
        language = random.choice(lang)
        if language == 'Russian':
            fake = Faker('ru_RU')
            name = fake.name()
        elif language == 'English':
            fake = Faker('en_CA')
            name = fake.name()
        elif language == 'Finnish':
            fake = Faker('fi_FI')
            name = fake.name()
        elif language == 'French':
            fake = Faker('fr_FR')
            name = fake.name()
        elif language == 'Italian':
            fake = Faker('it_IT')
            name = fake.name()
        elif language == 'Estonian':
            fake = Faker('et_EE')
            name = fake.name()
        elif language == 'Spanish':
            fake = Faker('es_ES')
            name = fake.name()
        elif language == 'Polish':
            fake = Faker('pl_PL')
            name = fake.name()
        elif language == 'Ukranian':
            fake = Faker('uk_UA')
            name = fake.name()

        learning = language
        while (learning == language):
            learning = random.choice(lang)    

        f.write(' :{} :{} :{}\n'.format(name, language, learning))


        
        


