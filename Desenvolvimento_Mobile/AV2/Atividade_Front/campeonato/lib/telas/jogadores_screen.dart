// Aluno: Austregíselo Junior - 03249515
import 'dart:convert';

import 'package:campeonato/telas/cadastro_jogador_screen.dart';
import 'package:campeonato/utils/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JogadoresScreen extends StatefulWidget {
  const JogadoresScreen({super.key});

  @override
  State<JogadoresScreen> createState() => _JogadoresScreenState();
}

class _JogadoresScreenState extends State<JogadoresScreen> {
  List jogadores = [];
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    listarJogadores();
  }

  Future<void> listarJogadores() async {
    try {
      final response = await http.get(Uri.parse('$apiBaseUrl/listajogadores'));

      if (!mounted) return;

      final dados = jsonDecode(response.body);

      setState(() {
        jogadores = dados;
        carregando = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        carregando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar jogadores: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,

        title: const Text("Jogadores", style: TextStyle(color: Colors.white)),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CadastroJogadorScreen(),
            ),
          );
          await listarJogadores();
        },
        child: const Icon(Icons.add),
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : jogadores.isEmpty
          ? const Center(
              child: Text(
                'Nenhum jogador encontrado.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: jogadores.length,
              itemBuilder: (context, index) {
                final jogador = jogadores[index];
                final nome =
                    jogador['nome'] ?? jogador['nomeJogador'] ?? 'Sem nome';
                final posicao =
                    jogador['posicao'] ??
                    jogador['posicaoJogador'] ??
                    'Sem posição';

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(nome),
                    subtitle: Text(posicao),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
