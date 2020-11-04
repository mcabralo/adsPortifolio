import os
import time as t
import Pesquisa as pq

print("------------------------------------------------------------------------")
print("---------------------- INICIALIZANDO PROGRAMA --------------------------")
print("Programa desenvolvido em Python para o controle da população de vacas")
print("------------------------------------------------------------------------")

t.sleep(2)
os.system("cls")

print("------------------------------------------------------------------------")
print("Você poderá saber a relação das vacas com o volume de leite que elas dão")
print("------------------------------------------------------------------------")

codigosCadastrados = pq.codigosRegistrados
animaisCadastrados = pq.animaisRegistrados
volumeRegistrados = pq.volumeRegistrados

respostaUsuario = ""

while respostaUsuario != "N":
    print("------------------------------------------------------------------------")
    codigo = input('Digite o codigo para pesquisar: ')
    print("------------------------------------------------------------------------")

    numeroProcurado = int(codigo)
    pq.pesquisaBinaria(codigosCadastrados, 0, len(codigosCadastrados) - 1, numeroProcurado)

    para_teste = pq.pesquisaBinaria(codigosCadastrados, 0, len(codigosCadastrados) - 1, numeroProcurado)
    if(int(para_teste) != -1):
        print('Essa vaca é da espécie: ', animaisCadastrados[int(para_teste)],
              'e rendeu um total de', volumeRegistrados[int(para_teste)], 'ml de leite')
        print("------------------------------------------------------------------------")
        t.sleep(2)
    else:
        print('Nenhum registro foi atribuído a esse código!')

    print("------------------------------------------------------------------------")
    respostaUsuario = input('Gostaria de fazer uma nova busca? (S ou N) ')
    print("------------------------------------------------------------------------")
else:
    t.sleep(2)
    os.system("cls")
    print("------------------------------------------------------------------------")
    print("------------------------- FIM DO PROGRAMA ------------------------------")
    print("------------------------------------------------------------------------")
    t.sleep(10)
    os.system("cls")