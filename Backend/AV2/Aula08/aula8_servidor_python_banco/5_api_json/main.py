from flask import Flask, request, jsonify
import pymysql

app = Flask(__name__)

def conectaDB():
    db = pymysql.connect(
        host='localhost',
        database='banco_funcionarios',
        user='root',
        passwd=''
    )

    return db

## CREATE - CADASTRO DO FUNCIONARIO
@app.route('/cadastraFuncionario', methods=['POST'])
def cadastraFuncionario():
    dadosRecebidos = request.get_json()
    nome = dadosRecebidos["nomeFuncionario"]
    banco = conectaDB()
    cursor = banco.cursor()

    sql = f"INSERT INTO funcionario(nome) VALUES ('{nome}')"
    cursor.execute(sql)
    banco.commit()
    banco.close()

    response = {"mensagem" : "Cadastrado com sucesso", "codigo" : 200}

    return jsonify(response)


# rota para atualização dos dados do funcionário nomeada como /atualizaFuncionario, utilizando o método PUT
@app.route('/atualizaFuncionario', methods=['PUT'])
def atualizaFuncionario():
    dadosRecebidos = request.get_json()
    idFuncionario = dadosRecebidos["id"]
    nomeFuncionario = dadosRecebidos["nomeFuncionario"]

    banco = conectaDB()
    cursor = banco.cursor()

    sql = f"UPDATE funcionario SET nome = '{nomeFuncionario}' WHERE id_func = {idFuncionario}"
    cursor.execute(sql)
    banco.commit()
    banco.close()

    response = {"mensagem" : "Atualizado com sucesso", "codigo" : 200}

    return jsonify(response)


## READ - LER OS FUNCIONARIOS DO BANCO
@app.route('/')
def lerFuncionario():
    banco = conectaDB()
    cursor = banco.cursor()

    sql = "SELECT * FROM funcionario;"
    cursor.execute(sql)
    resultado = cursor.fetchall()
    banco.close()
    
    listaFuncionario = []

    for funcionario in resultado:
        listaFuncionario.append(
            {
                "id" : funcionario[0],
                "nomeFuncionario" : funcionario[1] 
             }
        )
    
    return jsonify(listaFuncionario)

# Rota para deletar um funcionário utilizando o método DELETE
@app.route('/deletaFuncionario', methods=['DELETE'])
def deletaFuncionario():
    dadosRecebidos = request.get_json()
    idFuncionario = dadosRecebidos["id"]

    banco = conectaDB()
    cursor = banco.cursor()

    sql = f"DELETE FROM funcionario WHERE id_func = {idFuncionario}"
    cursor.execute(sql)
    banco.commit()
    banco.close()

    response = {"mensagem" : "Deletado com sucesso", "codigo" : 200}

    return jsonify(response)



if __name__ == "__main__":
    app.run(debug=True)

