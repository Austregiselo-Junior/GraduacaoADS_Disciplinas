import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sessao/utils.dart';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  Future<void> autenticarUsuario(Map<String, dynamic> mapLogin) async {
    print("Mapa Login: " + mapLogin.toString());

    var response = await http.post(
      Uri.parse('$baseURL/loginUsuario'),
      headers: {
        'Aceppt': 'application/json',
        'content-type': 'application/json',
      },

      body: jsonEncode(mapLogin),
      encoding: Encoding.getByName('utf-8'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseDadosUsuario = jsonDecode(response.body);
      print("Dados login: " + responseDadosUsuario.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseDadosUsuario["response"]["message"].toString()),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeView(),
          settings: RouteSettings(arguments: responseDadosUsuario["response"]),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
