// Aluno: Austregíselo Junior - 03249515
import 'dart:convert';
import 'package:campeonato/utils/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalEquipes = 0;
  int totalJogadores = 0;
  int totalPartidas = 0;
  bool carregando = true;
  String? erro;

  @override
  void initState() {
    super.initState();
    carregarResumo();
  }

  Future<void> carregarResumo() async {
    setState(() {
      carregando = true;
      erro = null;
    });

    try {
      final responses = await Future.wait([
        http.get(Uri.parse('$apiBaseUrl/listaequipes')),
        http.get(Uri.parse('$apiBaseUrl/listajogadores')),
        http.get(Uri.parse('$apiBaseUrl/listapartidasdetalhada')),
      ]);

      if (!mounted) return;

      if (responses.any((r) => r.statusCode != 200)) {
        throw Exception('Erro ao carregar dados da API');
      }

      final dadosEquipes = jsonDecode(responses[0].body);
      final dadosJogadores = jsonDecode(responses[1].body);
      final dadosPartidas = jsonDecode(responses[2].body);

      setState(() {
        totalEquipes = _contarItens(dadosEquipes);
        totalJogadores = _contarItens(dadosJogadores);
        totalPartidas = _contarItens(dadosPartidas);
        carregando = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        carregando = false;
        erro = error.toString();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao carregar dados: $error')));
    }
  }

  int _contarItens(dynamic dados) {
    if (dados is List) {
      return dados.length;
    }
    if (dados is Map<String, dynamic>) {
      if (dados.containsKey('data') && dados['data'] is List) {
        return dados['data'].length;
      }
      if (dados.containsKey('items') && dados['items'] is List) {
        return dados['items'].length;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Campeonato Esportivo',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: carregarResumo,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.sports_soccer, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text(
                    'Sistema Campeonato',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.groups),
              title: const Text('Equipes'),
              onTap: () {
                Navigator.pushNamed(context, '/listaequipes');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Jogadores'),
              onTap: () {
                Navigator.pushNamed(context, '/jogadores');
              },
            ),
            ListTile(
              leading: const Icon(Icons.sports),
              title: const Text('Partidas'),
              onTap: () {
                Navigator.pushNamed(context, '/partidas');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: carregando
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildResumoCard(
                    icon: Icons.groups,
                    title: 'Equipes',
                    value: totalEquipes.toString(),
                    color: Colors.blue,
                    subtitle: 'Total de equipes cadastradas',
                  ),
                  const SizedBox(height: 10),
                  _buildResumoCard(
                    icon: Icons.person,
                    title: 'Jogadores',
                    value: totalJogadores.toString(),
                    color: Colors.green,
                    subtitle: 'Total de jogadores cadastrados',
                  ),
                  const SizedBox(height: 10),
                  _buildResumoCard(
                    icon: Icons.sports_soccer,
                    title: 'Partidas',
                    value: totalPartidas.toString(),
                    color: Colors.orange,
                    subtitle: 'Total de partidas registradas',
                  ),
                  if (erro != null) ...[
                    const SizedBox(height: 20),
                    Text(
                      'Erro: $erro',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  Widget _buildResumoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required String subtitle,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
