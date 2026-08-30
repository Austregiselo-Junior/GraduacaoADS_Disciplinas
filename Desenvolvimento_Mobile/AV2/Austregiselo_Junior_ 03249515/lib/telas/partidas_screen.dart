// Aluno: Austregíselo Junior - 03249515
import 'dart:convert';

import 'package:campeonato/telas/cadastro_partida_screen.dart';
import 'package:campeonato/utils/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PartidasScreen extends StatefulWidget {
  const PartidasScreen({super.key});

  @override
  State<PartidasScreen> createState() => _PartidasScreenState();
}

class _PartidasScreenState extends State<PartidasScreen> {
  List partidas = [];
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    listarPartidas();
  }

  Future<void> listarPartidas() async {
    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/listapartidasdetalhada'),
      );

      if (!mounted) return;

      final dados = jsonDecode(response.body);

      setState(() {
        if (dados is List) {
          partidas = dados;
        } else if (dados is Map<String, dynamic>) {
          partidas = dados['partidas'] is List
              ? dados['partidas']
              : dados['data'] is List
              ? dados['data']
              : [];
        } else {
          partidas = [];
        }
        carregando = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        carregando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar partidas: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Partidas', style: TextStyle(color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CadastroPartidaScreen(),
            ),
          );
          await listarPartidas();
        },
        child: const Icon(Icons.add),
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : partidas.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma partida encontrada.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: partidas.length,
              itemBuilder: (context, index) {
                final partida = partidas[index];
                final casa = partida['equipeCasa'] ?? partida['casa'] ?? 'Casa';
                final visitante =
                    partida['equipeVisitante'] ??
                    partida['visitante'] ??
                    'Visitante';
                final placarCasa = partida['placarCasa']?.toString() ?? '0';
                final placarVisitante =
                    partida['placarVisitante']?.toString() ?? '0';
                final data = partida['dataPartida'] ?? partida['data'] ?? '';

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.sports_soccer, color: Colors.white),
                    ),
                    title: Text('$casa x $visitante'),
                    subtitle: Text(
                      '$placarCasa x $placarVisitante${data.isNotEmpty ? ' • $data' : ''}',
                    ),
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
