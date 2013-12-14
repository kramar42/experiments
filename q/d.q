deg:15
cn:32768
s:60
dx:s%cn
n:10*cn

d:n#s%n*2
l:n#0.85
o:n#1
t:n#2
i:til n

psi:exp neg i*i*d*d
a:(neg o%d*d)+(o%t*i*d*d)
b:(neg o%d*d)-(o%t*i*d*d)
c:l+2%d*d

a[0]:0.0
b[0]:neg 2%d[0]*d[0]
