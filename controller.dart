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
  int accountValidation(var pin) {
    var user = readFile().elementAt(0).split(' ');
    var password = readFile().elementAt(1).split(' ');

    if (password.elementAt(1) == pin) {
      print("\n\n\t\tWelcome back " + user.elementAt(1) + "!");
      print("\tPlease choose your transaction");
      return 1;
    } else {
      print("\tAccount not found. Try again.");
      return 2;
    }
  }

  //function for depositing transaction
  void depositOption() {
    var balance = remainingBalance();
    print('\n\n\t\tDEPOSIT');

    stdout.write('\n\t>> AMOUNT TO DEPOSIT: P ');
    var depositAmount =
        (double.parse(stdin.readLineSync()!).toStringAsFixed(2));
    var newBalance = double.parse(balance) + double.parse(depositAmount);
    sinkTransaction(1, depositAmount, newBalance);
    print('\t>> UPDATED BALANCE: P ' + newBalance.toStringAsFixed(2));

    return menuSection();
  }

  //function containing withdrawal transaction
  void withdrawOption() {
    var withdrawAmount;
    var balance = remainingBalance();
    print('\n\n\t\tWITHDRAW');

    do {
      stdout.write('\n\t>> AMOUNT TO WITHDRAW: P ');
      withdrawAmount = (double.parse(stdin.readLineSync()!).toStringAsFixed(2));

      if (double.parse(balance) == 0.00 ||
          double.parse(withdrawAmount) == double.parse(balance) ||
          double.parse(withdrawAmount) > double.parse(balance)) {
        TransError();
      } else {
        break;
      }
    } while (true);

    var newBalance = double.parse(balance) - double.parse(withdrawAmount);
    sinkTransaction(2, withdrawAmount, newBalance);
    return menuSection();
  }

  //function for checking of balance transaction
  void balanceOption() {
    var balance = readFile().elementAt(readFile().length - 1).split(' ');
    print('\n\n\t\tBALANCE INQUIRY');
    balance = balance.elementAt(1);
    print('\t>> BALANCE: P ' + balance);
    return menuSection();
  }

  //function that appends the transaction to the file
  void sinkTransaction(var transaction, var amount, var newBalance) {
    var sink = File('accountRecord.txt'); //for appending to the file

    if (transaction == 1) {
      sink.writeAsStringSync(
          '\n+ ' + amount + '\n ------- \n= ' + newBalance.toStringAsFixed(2),
          mode: FileMode.append);
    } else {
      sink.writeAsStringSync(
          '\n- ' + amount + '\n ------- \n= ' + newBalance.toStringAsFixed(2),
          mode: FileMode.append);
    }
  }

  //function to check the remaining balance
  remainingBalance() {
    var balance = readFile().elementAt(readFile().length - 1).split(' ');
    balance = (double.parse(balance.elementAt(1)).toStringAsFixed(2));
    return balance;
  }

  checkBalance(var amount) {}
}

ErrorMessage() => print("\tInvalid input. \n\tTry again.");
TransError() => print("\tThat exceeds the allowable amount. \n\tTry again.");
