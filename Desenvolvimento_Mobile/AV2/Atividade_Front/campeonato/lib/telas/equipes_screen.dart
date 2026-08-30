// Aluno: Austregíselo Junior - 03249515
import 'dart:convert';
import 'package:campeonato/utils/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cadastro_equipe_screen.dart';

class EquipesScreen extends StatefulWidget {
  const EquipesScreen({super.key});

  @override
  State<EquipesScreen> createState() => _EquipesScreenState();
}

class _EquipesScreenState extends State<EquipesScreen> {
  List equipes = [];
  bool carregando = true;

  Future<void> listarEquipes() async {
    try {
      var response = await http.get(Uri.parse('${apiBaseUrl}/listaequipes'));

      if (!mounted) {
        return;
      }

      final dados = jsonDecode(response.body);

      setState(() {
        equipes = dados;

        carregando = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        carregando = false;
      });

      debugPrint('Erro ao carregar equipes: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar equipes: $error')),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    listarEquipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.blue,

        title: const Text("Equipes", style: TextStyle(color: Colors.white)),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,

        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CadastroEquipeScreen(),
            ),
          );
          await listarEquipes();
        },

        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: carregando
            ? const Center(child: CircularProgressIndicator())
            : equipes.isEmpty
            ? const Center(
                child: Text(
                  'Nenhuma equipe encontrada.',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.separated(
                itemCount: equipes.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  var equipe = equipes[index];
                  var nome = equipe["nome"];
                  var cidade = equipe["cidade"] ?? equipe["cidadeEquipe"];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),

                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.blue,
                            child: Text(
                              nome.isNotEmpty ? nome[0].toUpperCase() : 'E',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nome,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  cidade,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),

                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
