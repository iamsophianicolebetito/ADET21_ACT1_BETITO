import 'dart:io';

void main(List<String> arguments) {
  //saves fiile content to the variable
  var content = File('accountRecord.txt').readAsLinesSync();

  //login function with file content as parameter
  userLogin(content);
}

//function for user login
void userLogin(var content) {
  var pin;

  print('\n\n\t\tADET');
  print('\tAUTOMATED TELLER MACHINE');

  do {
    stdout.write('\n>> Enter PIN (5 Digits): ');
    pin = stdin.readLineSync();

    accountValidation(pin, content);
  } while (pin.length != 5 && content.elementAt(1) != pin);
}

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

    switch (transaction) {
      case 1:
        {
          depositOption(content);
          break;
        }

      case 2:
        {
          withdrawOption(content);
          break;
        }

      case 3:
        {
          balanceOption(content);
          break;
        }

      case 4:
        {
          print('LOGGING OUT');
          break;
        }

      default:
        {
          print('\tInput not recognized. Try again.');
        }
    }
  } while (transaction < 1 || transaction > 4);
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
  var depositAmount = (double.parse(stdin.readLineSync()!).toStringAsFixed(2));
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
  var last = content.length; //to get the last element of the file
  print('\n\n\t\tBALANCE INQUIRY');

  //last - 1; index starts with 0
  var balance = content.elementAt(last - 1).split(' ');
  balance = (double.parse(balance.elementAt(1)).toStringAsFixed(2));

  //prints current account balance
  print('\t>> BALANCE: P ' + balance);

  return menuSection(content);
}
