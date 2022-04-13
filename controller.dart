import 'dart:io';
import 'main.dart';

class operation {
  void accountValidation(var pin, var content) {
    var password = content.elementAt(1).split(' ');

    if (password.elementAt(1) == pin) {
      print("Account found");
      menuSection(content);
    } else {
      print("Account not found");
      return;
    }
  }

  //function for menu
  void menuSection(var content) {
    int transaction;

    print('\n\n\n\n\t ---- TRANSACTION ---- ');
    print('\t|  [1] DEPOSIT        |');
    print('\t|  [2] WITHDRAW       |');
    print('\t|  [3] CHECK BALANCE  |');
    print('\t|  [4] LOGOUT         |');
    print('\t ---------------------');

    do {
      stdout.write('\n\t>> Transaction: ');
      transaction = int.parse(stdin.readLineSync()!);
    } while (transaction < 1 || transaction > 4);

    if (transaction == 1) {
      depositOption(content);
    } else if (transaction == 2) {
      withdrawOption(content);
    } else if (transaction == 3) {
      balanceOption(content);
    } else if (transaction == 4) {
      print('\tLOGGING OUT\n\n');
      return main();
    }
  }

  //function for depositing transaction
  void depositOption(var content) {
    var last = content.length; //to get the last element of the file
    var sink = File('accountRecord.txt'); //for appending to the file
    print('\n\n\t\tDEPOSIT');

    //last - 1; index starts with 0
    var balance = content.elementAt(last - 1).split(' ');
    balance = (double.parse(balance.elementAt(1)).toStringAsFixed(2));

    //prints current account balance
    print('\t>> BALANCE: P ' + balance);
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

    return menuSection(content);
  }

  //function containing withdrawal transaction
  void withdrawOption(var content) {
    var last = content.length; //to get the last element of the file
    var sink = File('accountRecord.txt'); //for appending to the file
    var withdrawAmount;

    print('\n\n\t\tWITHDRAW');

    //last - 1; index starts with 0
    var balance = content.elementAt(last - 1).split(' ');
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

    return menuSection(content);
  }

  //function for checking of balance transaction
  void balanceOption(var content) {
    //to get the last element of the file
    var last = content.length;
    print('\n\n\t\tBALANCE INQUIRY');

    //last - 1; index starts with 0
    var balance = content.elementAt(last - 1).split(' ');
    balance = checkBalance(content);

    //prints current account balance
    print('\t>> BALANCE: P ' + balance);

    return menuSection(content);
  }

  //function to check the balance before proceeding to transact
  String checkBalance(var content) {
    var last = content.length; //to get the last element of the file

    //last - 1; index starts with 0
    var balance = content.elementAt(last - 1).split(' ');
    balance = (double.parse(balance.elementAt(1)).toStringAsFixed(2));

    return balance;
  }
}
