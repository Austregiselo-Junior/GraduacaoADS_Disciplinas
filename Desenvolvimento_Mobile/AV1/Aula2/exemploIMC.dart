void main() {
  double _peso = 75;
  double _altura = 1.75;
  double _resultado;

  double Resultado(double _peso, double _altura) {
    return _peso / (_altura * _altura);
  }

  _resultado = Resultado(_peso, _altura);
  print("Seu IMC é: $_resultado.");

  if (_resultado < 20) {
    print("Você está abaixo do peso.");
  } else if (_resultado >= 20 && _resultado < 25) {
    print("Você está com o peso normal.");
  } else if (_resultado >= 25 && _resultado < 30) {
    print("Você está com sobrepeso.");
  } else if (_resultado >= 30 && _resultado < 40) {
    print("Você está com obesidade grau I.");
  } else if (_resultado >= 40) {
    print("Você está com obesidade grau II.");
  }
}
