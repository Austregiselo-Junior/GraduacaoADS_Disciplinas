// Aluno: Austregíselo Junior - 03249515
import 'dart:convert';

import 'package:campeonato/utils/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastroPartidaScreen extends StatefulWidget {
  const CadastroPartidaScreen({super.key});

  @override
  State<CadastroPartidaScreen> createState() => _CadastroPartidaScreenState();
}

class _CadastroPartidaScreenState extends State<CadastroPartidaScreen> {
  final equipeCasaController = TextEditingController();
  final equipeVisitanteController = TextEditingController();
  final placarCasaController = TextEditingController();
  final placarVisitanteController = TextEditingController();
  final dataController = TextEditingController();
  bool carregando = false;

  Future<void> cadastrarPartida(
    String equipeCasa,
    String equipeVisitante,
    String placarCasa,
    String placarVisitante,
    String data,
  ) async {
    setState(() {
      carregando = true;
    });

    final equipeCasaId = int.tryParse(equipeCasa);
    final equipeVisitanteId = int.tryParse(equipeVisitante);

    final body = {
      'equipeCasa': equipeCasaId ?? equipeCasa,
      'equipeVisitante': equipeVisitanteId ?? equipeVisitante,
      'placarCasa': int.tryParse(placarCasa) ?? 0,
      'placarVisitante': int.tryParse(placarVisitante) ?? 0,
      'dataPartida': data,
    };

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/cadastrapartida'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (!mounted) return;

      setState(() {
        carregando = false;
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Partida cadastrada com sucesso!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao cadastrar partida.')),
        );
      }
    } catch (error) {
      if (!mounted) return;

      setState(() {
        carregando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar partida: $error')),
      );
    }
  }

  @override
  void dispose() {
    equipeCasaController.dispose();
    equipeVisitanteController.dispose();
    placarCasaController.dispose();
    placarVisitanteController.dispose();
    dataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Cadastrar Partida',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: equipeCasaController,
              decoration: const InputDecoration(
                labelText: 'Equipe Casa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: equipeVisitanteController,
              decoration: const InputDecoration(
                labelText: 'Equipe Visitante',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: placarCasaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Placar Casa',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: placarVisitanteController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Placar Visitante',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: dataController,
              decoration: const InputDecoration(
                labelText: 'Data da partida',
                hintText: 'YYYY-MM-DD',
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
                    : () => cadastrarPartida(
                        equipeCasaController.text,
                        equipeVisitanteController.text,
                        placarCasaController.text,
                        placarVisitanteController.text,
                        dataController.text,
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
