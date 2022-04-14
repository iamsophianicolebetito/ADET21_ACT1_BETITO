import 'dart:io';
import 'main.dart';

class operation {
  //function that reads the text file
  readFile() {
    //saves file content to the variable
    var content = File('accountRecord.txt').readAsLinesSync();
    return content;
  }

  //function to validate the pin from the file
  void accountValidation(var pin) {
    var password = readFile().elementAt(1).split(' ');

    if (password.elementAt(1) == pin) {
      print("Account found");
      menuSection();
    } else {
      print("Account not found");
      return;
    }
  }

  //function for menu
  void menuSection() {
    var transaction;

    print('\n\n\n\n\t ---- TRANSACTION ---- ');
    print('\t|  [1] DEPOSIT        |');
    print('\t|  [2] WITHDRAW       |');
    print('\t|  [3] CHECK BALANCE  |');
    print('\t|  [4] LOGOUT         |');
    print('\t ---------------------');

    do {
      do {
        stdout.write('\n\t>> Transaction: ');
        transaction = stdin.readLineSync();
      } while (int.parse(transaction) < 1 || int.parse(transaction) > 4);

      if (int.parse(transaction) == 1) {
        depositOption();
      }
      if (int.parse(transaction) == 2) {
        withdrawOption();
      }
      if (int.parse(transaction) == 3) {
        balanceOption();
      }
      if (int.parse(transaction) == 4) {
        print('\tLOGGING OUT\n\n');
        return main();
      }
    } while (int.parse(transaction) != 4);
  }

  //function for depositing transaction
  void depositOption() {
    var last = readFile().length; //to get the last element of the file
    var sink = File('accountRecord.txt'); //for appending to the file
    print('\n\n\t\tDEPOSIT');

    //last - 1; index starts with 0
    var balance = readFile().elementAt(last - 1).split(' ');
    balance = (double.parse(balance.elementAt(1)).toStringAsFixed(2));

    stdout.write('\n\t>> AMOUNT TO DEPOSIT: P ');
    var depositAmount =
        (double.parse(stdin.readLineSync()!).toStringAsFixed(2));
    var newBalance = double.parse(balance) + double.parse(depositAmount);

    sink.writeAsStringSync(
        '\n+ ' +
            depositAmount +
            '\n ------- '
                '\n= ' +
            newBalance.toStringAsFixed(2),
        mode: FileMode.append);
    print('\n\t>> UPDATED BALANCE: P ' + newBalance.toStringAsFixed(2));

    return menuSection();
  }

  //function containing withdrawal transaction
  void withdrawOption() {
    var last = readFile().length; //to get the last element of the file
    var sink = File('accountRecord.txt'); //for appending to the file
    var withdrawAmount;

    print('\n\n\t\tWITHDRAW');

    //last - 1; index starts with 0
    var balance = readFile().elementAt(last - 1).split(' ');
    balance = (double.parse(balance.elementAt(1)).toStringAsFixed(2));

    //prints current account balance
    print('\t>> BALANCE: P ' + balance);

    do {
      stdout.write('\n\t>> AMOUNT TO WITHDRAW: P ');
      withdrawAmount = (double.parse(stdin.readLineSync()!).toStringAsFixed(2));
    } while (double.parse(withdrawAmount) > double.parse(balance));

    var newBalance = double.parse(balance) - double.parse(withdrawAmount);

    sink.writeAsStringSync(
        '\n- ' +
            withdrawAmount +
            '\n ------- '
                '\n= ' +
            newBalance.toStringAsFixed(2),
        mode: FileMode.append);
    print('\n\t>> UPDATED BALANCE: P ' + newBalance.toStringAsFixed(2));

    return menuSection();
  }

  //function for checking of balance transaction
  void balanceOption() {
    var last = readFile().length; //to get the last element of the file
    print('\n\n\t\tBALANCE INQUIRY');

    var balance = readFile().elementAt(last - 1).split(' ');
    balance = balance.elementAt(1);

    print('\t>> BALANCE: P ' + balance);

    return menuSection();
  }
}
