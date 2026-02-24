import 'dart:io';

void main() {
  print('Digete uma idade:');
  int idade = int.parse(stdin.readLineSync() as String);

  if (idade >= 0 && idade < 13) {
    print('Criança');
  } else if (idade >= 14 && idade < 17) {
    print('Adolescente');
  } else if (idade >= 18 && idade < 59) {
    print('Adulto');
  } else {
    print('Idoso');
  }
}
