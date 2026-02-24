import 'dart:io';

void main() {
  double _resultado = 0;

  print('Add o primeiro número:');
  double num1 = double.parse(stdin.readLineSync() as String);

  print('Add o segundo número:');
  double num2 = double.parse(stdin.readLineSync() as String);

  double Soma(double a, double b) {
    return a + b;
  }

  _resultado = Soma(num1, num2);
  print('A soma é: $_resultado');

  double Subtracao(double a, double b) {
    return a - b;
  }

  _resultado = Subtracao(num1, num2);
  print('A subtração é: $_resultado');

  double Multiplicacao(double a, double b) {
    return a * b;
  }

  _resultado = Multiplicacao(num1, num2);
  print('A multiplicação é: $_resultado');

  double Divisao(double a, double b) {
    return a / b;
  }

  _resultado = Divisao(num1, num2);
  print('A divisão é: $_resultado');
}
