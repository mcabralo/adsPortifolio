import mysql.connector


class Conexao:

    def __init__(self, host="localhost", user="root", password="", database="fazenda_bd"):
        self.host = host
        self.user = user
        self.password = password
        self.database = database

    def conecta(self):
        self.con = mysql.connector.connect(host=self.host,
                                           user=self.user,
                                           password=self.password,
                                           database=self.database)
        self.cur = self.con.cursor()

    def desconecta(self):
        self.con.close()

    def mostrarTabela(self, resultado):
        for x in resultado:
                print(x[0])


    def executaDQL(self, sql):
        self.conecta()
        self.cur.execute(sql)
        resultado = self.cur.fetchall()
        self.desconecta()
        # self.mostrarTabela(resultado)
        return resultado

    def executaDML(self, sql):
        self.conecta()
        self.cur.execute(sql)
        self.con.commit()
        self.desconecta()
