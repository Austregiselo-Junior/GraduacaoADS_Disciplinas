// Aluno: Austregíselo Junior - 03249515

import 'package:campeonato/telas/cadastro_equipe_screen.dart';
import 'package:campeonato/telas/cadastro_jogador_screen.dart';
import 'package:campeonato/telas/cadastro_partida_screen.dart';
import 'package:flutter/material.dart';

import 'telas/home_screen.dart';
import 'telas/equipes_screen.dart';
import 'telas/jogadores_screen.dart';
import 'telas/partidas_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Campeonato',

      initialRoute: '/',

      routes: {
        '/': (context) => const HomeScreen(),

        '/listaequipes': (context) => const EquipesScreen(),

        '/jogadores': (context) => const JogadoresScreen(),

        '/partidas': (context) => const PartidasScreen(),

        '/cadastroEquipe': (context) => const CadastroEquipeScreen(),
        '/cadastroJogador': (context) => const CadastroJogadorScreen(),
        '/cadastroPartida': (context) => const CadastroPartidaScreen(),
      },
    );
  }
}
