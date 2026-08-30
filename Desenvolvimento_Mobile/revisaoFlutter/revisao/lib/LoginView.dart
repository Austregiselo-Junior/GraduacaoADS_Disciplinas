import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:revisao/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
TextEditingController email = TextEditingController();
TextEditingController senha = TextEditingController();

String ip_server = Utils.ip_server;

Future<void> login(Map<String, dynamic> maplogin) async {
  String url = "http://$ip_server:5000/login";
  var response = await http.post(Uri.parse(url),
    headers: 
    {"Accept": "application/json", 
    "Content-Type": "application/json",},
    
    body: jsonEncode(maplogin),
    encoding: Encoding.getByName("utf-8"),
    );

    if(response.statusCode == 200){
      Map<String, dynamic> responseDadosUsuario = JsonDecoder(response.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseDadosUsuario["response"]["mensagem"].toString(),),),
    };
    }




  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}