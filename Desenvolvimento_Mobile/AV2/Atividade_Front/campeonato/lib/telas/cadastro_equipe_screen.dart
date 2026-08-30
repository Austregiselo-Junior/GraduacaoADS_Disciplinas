// Aluno: Austregíselo Junior - 03249515
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/api_config.dart';

class CadastroEquipeScreen extends StatefulWidget {
  const CadastroEquipeScreen({super.key});

  @override
  State<CadastroEquipeScreen> createState() => _CadastroEquipeScreenState();
}

class _CadastroEquipeScreenState extends State<CadastroEquipeScreen> {
  var nomeController = TextEditingController();
  var cidadeController = TextEditingController();
  bool carregando = false;

  Future cadastrarEquipe(String nome, String cidade) async {
    setState(() {
      carregando = true;
    });

    var response = await http.post(
      Uri.parse('$apiBaseUrl/cadastraequipe'),

      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },

      body: json.encode({"nomeEquipe": nome, "cidadeEquipe": cidade}),
      encoding: Encoding.getByName("utf-8"),
    );

    setState(() {
      carregando = false;
    });

    if (!mounted) return;

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Equipe cadastrada com sucesso!")),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Erro ao cadastrar equipe")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,

        title: const Text(
          "Cadastrar Equipe",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: nomeController,

              decoration: const InputDecoration(
                labelText: "Nome da equipe",

                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: cidadeController,

              decoration: const InputDecoration(
                labelText: "Cidade",

                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              height: 50,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),

                onPressed: carregando
                    ? null
                    : () => cadastrarEquipe(
                        nomeController.text,
                        cidadeController.text,
                      ),

                child: carregando
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
