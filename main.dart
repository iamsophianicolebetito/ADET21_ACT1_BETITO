import 'dart:io';
import 'controller.dart';

void main() {
  operation operate = new operation();

  //saves fiile content to the variable
  var content = File('accountRecord.txt').readAsLinesSync();

  //login function with file content as parameter
  userLogin(operate, content);
}

void userLogin(operation operate, var content) {
  var pin;

  print('\n\n\t\tADET');
  print('\tAUTOMATED TELLER MACHINE');

  do {
    stdout.write('\n>> Enter PIN (5 Digits): ');
    pin = stdin.readLineSync();

    operate.accountValidation(pin, content);
  } while (pin.length != 5 && content.elementAt(1) != pin);
}
