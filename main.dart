import 'dart:io';
import 'controller.dart';

operation operate = new operation();

void main() {
  //saves file content to the variable
  var content = File('accountRecord.txt').readAsLinesSync();

  userLogin(content);
  menuSection();
}

//function for user login
userLogin(var content) {
  var pin;
  var val;
  print('\n\n\t\tADET\n\tAUTOMATED TELLER MACHINE');

  do {
    stdout.write('\n>> Enter PIN (5 Digits): ');
    pin = stdin.readLineSync();
    val = operate.accountValidation(pin);
  } while (val == 2);
}

//function for menu
menuSection() {
  var transaction;
  printChoices show = printMenu;
  show(operate);

  do {
    stdout.write('\n\t>> Transaction: ');
    transaction = stdin.readLineSync();
    if (int.parse(transaction) < 1 || int.parse(transaction) > 4) {
      ErrorMessage();
    }
  } while (int.parse(transaction) < 1 || int.parse(transaction) > 4);

  if (int.parse(transaction) == 1) {
    operate.depositOption();
  } else if (int.parse(transaction) == 2) {
    operate.withdrawOption();
  } else if (int.parse(transaction) == 3) {
    operate.balanceOption();
  } else {
    print('\tLOGGING OUT\n\n');
    return main();
  }
}

//typedef function to show the transaction options
printMenu(operation operate) {
  print('\n\n\n\n\t ---- TRANSACTION ---- ');
  print('\t|  [1] DEPOSIT        |');
  print('\t|  [2] WITHDRAW       |');
  print('\t|  [3] CHECK BALANCE  |');
  print('\t|  [4] LOGOUT         |');
  print('\t ---------------------');
}

typedef printChoices(operation operate);
ErrorMessage() => print("\tInvalid input. Try again.");
