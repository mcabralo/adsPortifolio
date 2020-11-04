import Conexao as con

c = con.Conexao()
c.conecta()
res = c.executaDQL("SELECT * FROM Consulta_Python")
codigosRegistrados = []
animaisRegistrados = []
volumeRegistrados = []

for x in res:
    codigosRegistrados.append(x[0])
    animaisRegistrados.append(x[1])
    volumeRegistrados.append(x[2])

def pesquisaBinaria(codigosCadastrados, minimo, maximo, buscar):

    if maximo < minimo:
        return -1  

    meio = (minimo + maximo) // 2
    if codigosCadastrados[meio] == buscar:
        return meio

    elif codigosCadastrados[meio] > buscar:
        return pesquisaBinaria(codigosCadastrados, minimo, meio - 1, buscar)
    else:
        return pesquisaBinaria(codigosCadastrados, meio + 1, maximo, buscar)

