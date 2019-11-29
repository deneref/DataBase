import io
import random

with io.open('exchanges.txt','w', encoding="utf-8") as f:
    schools = io.open('schools.txt', 'r', encoding="utf-8")
    students = io.open('students.txt', 'r', encoding="utf-8")
    universities = io.open('univercities.txt', 'r', encoding="utf-8")

##    shl = []; st = []; uni = []
##    for line in schools:
##        shl.append(line)
##    for line in students:
##        st.append(line)
##    for line in universities:
##        uni.append(line)
        
##    while st != []:
##        cst = st[-1].split(" :")
##        st.pop()
##        
##        cst_l = cst[-1]
##        rand_shl = random.choice(shl).split(' :')
##        rand_uni = random.choice(uni).split(' :')
##        while rand_shl[-1] != cst_l:
##            rand_shl = random.choice(shl).split(' :')
##        while rand_uni[-1] != cst_l:
##            rand_uni = random.choice(uni).split(' :')
         
        #f.write("{} :{} :{} :{}\n".format(str(cst[0]),str(rand_shl[0]), str(rand_uni[0]), str(random.randint(100, 10000))))

    shl = []
    univ = []
    for i in range(1000):
        shl.append(i+1)
        univ.append(i+1)
    random.shuffle(shl)
    random.shuffle(univ)


    for i in range(1000):
        f.write("{} :{} :{} :{}\n".format(str(i+1), str(shl[i]), str(univ[i]), str(random.randint(100, 10000))))
##        
##
