import 'dart:io';

void main() {
  //1
  print('Add um número inteiro:');
  int num1 = int.parse(stdin.readLineSync() as String);
  print('Quadrado de $num1 é ${Quadrado(num1)}:');

  //2
  print('Add primeiro nome:');
  String fistName = stdin.readLineSync() as String;

  print('Add segundo nome:');
  String secondName = stdin.readLineSync() as String;

  print('Olá $fistName $secondName!');

  //3
  print('Quantos KM vc percorreu?');
  int km = int.parse(stdin.readLineSync() as String);

  print('por quantos dias o carro foi alugado?');
  int dias = int.parse(stdin.readLineSync() as String);

  double valor = (km * 0.15) + (dias * 60);
  print('O valor a ser pago é: R\$ $valor');

  //4
  print('Quantos cigarros vc fuma por dia?');
  int cigarros = int.parse(stdin.readLineSync() as String);

  print('Quantos anos vc fuma?');
  int anos = int.parse(stdin.readLineSync() as String);

  int totalCigarros = cigarros * 365 * anos;
  double diasPerdidos = totalCigarros / 10;

  print('Você perdeu aproximadamente $diasPerdidos dias de vida.');

  //5
  print('Qual o valor do imóvel?');
  double valorImovel = double.parse(stdin.readLineSync() as String);

  print('Qual seu salário?');
  double salario = double.parse(stdin.readLineSync() as String);

  print('Quantos meses você pretende pagar?');
  double meses = double.parse(stdin.readLineSync() as String);

  if (ValorParcela(valorImovel, meses) <= ValorMaxParcela(salario)) {
    print(
      'Empréstimo aprovado! O valor da parcela é: R\$ ${ValorParcela(valorImovel, meses)}',
    );
  } else {
    print(
      'Empréstimo negado! O valor da parcela é: R\$ ${ValorParcela(valorImovel, meses)}',
    );
  }

  //6
  double alturaChico = 1.50;
  double alturaZeca = 1.10;

  for (int ano = 1; ano <= 100; ano++) {
    alturaChico += 0.02;
    alturaZeca += 0.03;

    if (alturaZeca > alturaChico) {
      print('Zeca ultrapassará Chico em $ano anos.');
      break;
    }
  }

  //7
  print('Digite o valor 1');
  double valor1 = double.parse(stdin.readLineSync() as String);

  print('Digite o valor 2');
  double valor2 = double.parse(stdin.readLineSync() as String);

  print('Impressão: ${ImprimirValorIgualouMenor(valor1, valor2)}');

  //8
  int pontos = 0;
  String resultado = '';
  int partida = 0;

  pontos = MotorPontos(partida, resultado, pontos);
  print('Pontuação final: $pontos');
  PontosHandler(pontos);

  //9
  List<String> respostas = [];
  String _resulst = "";

  print("Telefonou pra vítima? S/N");
  _resulst = stdin.readLineSync() as String;
  respostas.add(_resulst);

  print("Esteve no local do crime? S/N");
  _resulst = stdin.readLineSync() as String;
  respostas.add(_resulst);

  print("Mora perto davítima? S/N");
  _resulst = stdin.readLineSync() as String;
  respostas.add(_resulst);

  print("Tinha dívidas com a vítima? S/N");
  _resulst = stdin.readLineSync() as String;
  respostas.add(_resulst);

  print("Já trabalhou com a vítima? S/N");
  _resulst = stdin.readLineSync() as String;
  respostas.add(_resulst);

  RequestRendler(respostas);
}

void RequestRendler(List<String> respostas) {
  int countSim = respostas
      .where((resposta) => resposta.toUpperCase() == 'S')
      .length;

  if (countSim == 2) {
    print('Suspeita');
  } else if (countSim >= 3 && countSim < 4) {
    print('Cúmplice');
  } else if (countSim == 5) {
    print('Assassino');
  }
}

void PontosHandler(int pontos) {
  if (pontos >= 60) {
    print('Parabéns! Você subiu de patente.');
  } else if (pontos >= 21 && pontos < 60) {
    print('Bom trabalho! Você permanece na patente.');
  } else if (pontos < 21) {
    print('Caio de patente! Você tem potencial para melhorar!');
  }
}

int MotorPontos(int partida, String resultado, int pontos) {
  do {
    print('Partida $partida');
    print(
      'Digite o resultado da próxima partida (V para vitória, D para derrota, E para empate):',
    );
    resultado = stdin.readLineSync() as String;

    while (resultado == 'V') {
      pontos += 10;
      print('Você venceu! Pontos: $pontos');
      break;
    }
    while (resultado == 'E') {
      pontos += 5;
      print('Você empatou! Pontos: $pontos');
      break;
    }
    while (resultado == 'D') {
      pontos -= 2;
      print('Você perdeu! Pontos: $pontos');
      break;
    }

    partida++;
  } while (partida <= 10);
  return pontos;
}

double ImprimirValorIgualouMenor(double valor1, double valor2) {
  if (valor1 < valor2) {
    return valor1;
  } else if (valor1 > valor2) {
    return valor2;
  } else {
    return valor1; // ou valor2, já que são iguais
  }
}

double ValorParcela(double valorImovel, double meses) {
  return (valorImovel / meses);
}

double ValorMaxParcela(double salario) {
  return (salario * 0.3);
}

int Quadrado(int _quadrado) {
  return _quadrado * _quadrado;
}
