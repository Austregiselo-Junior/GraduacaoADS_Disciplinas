// Aluno: Austregíselo Junior - 03249515
import 'dart:convert';

import 'package:campeonato/utils/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastroJogadorScreen extends StatefulWidget {
  const CadastroJogadorScreen({super.key});

  @override
  State<CadastroJogadorScreen> createState() => _CadastroJogadorScreenState();
}

class _CadastroJogadorScreenState extends State<CadastroJogadorScreen> {
  final nomeController = TextEditingController();
  final posicaoController = TextEditingController();
  final equipeController = TextEditingController();
  bool carregando = false;

  Future<void> cadastrarJogador(
    String nome,
    String posicao,
    String equipe,
  ) async {
    setState(() {
      carregando = true;
    });

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/cadastrajogador'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'nomeJogador': nome,
          'posicaoJogador': posicao,
          'equipeJogador': equipe,
        }),
      );

      if (!mounted) return;

      setState(() {
        carregando = false;
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jogador cadastrado com sucesso!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao cadastrar jogador.')),
        );
      }
    } catch (error) {
      if (!mounted) return;

      setState(() {
        carregando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar jogador: $error')),
      );
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    posicaoController.dispose();
    equipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Cadastrar Jogador',
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
                labelText: 'Nome do jogador',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: posicaoController,
              decoration: const InputDecoration(
                labelText: 'Posição',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: equipeController,
              decoration: const InputDecoration(
                labelText: 'Equipe',
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
                    : () => cadastrarJogador(
                        nomeController.text,
                        posicaoController.text,
                        equipeController.text,
                      ),
                child: carregando
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Cadastrar',
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
