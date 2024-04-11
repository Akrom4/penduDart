// Jeu du pendu
import 'dart:io';
import 'package:pendu/hangman.dart';
import 'package:pendu/dictionary.dart';
import 'package:pendu/console_colors.dart';

void printGuess(String wordSecret, Set<String> foundLetters, int wrongGuesses) {
  clearScreen();
  PrintHangman.drawLevel(wrongGuesses, 'red');

  for (int i = 0; i < wordSecret.length; i++) {
    if (foundLetters.contains(wordSecret[i])) {
      stdout.write(' ${wordSecret[i]} ');
    } else {
      stdout.write(' _ ');
    }
  }
  print('');
}

void clearScreen() {
  print("\x1B[2J\x1B[0;0H");
}

void checkWin(String wordSecret, Set<String> foundLetters, int wrongGuesses) {
  clearScreen();
  if (foundLetters.length == wordSecret.runes.toSet().length) {
    PrintHangman.drawLevel(wrongGuesses, 'green');
    print(
        "${ConsoleColors.yellow}Gagné ! Vous avez trouvé le mot : ${ConsoleColors.green} ${wordSecret.toUpperCase()} ${ConsoleColors.reset}");
  } else {
    clearScreen();
    PrintHangman.drawLevel(wrongGuesses, 'red');
    print(
        "${ConsoleColors.yellow}Perdu ! Le mot était : ${ConsoleColors.red} ${wordSecret.toUpperCase()} ${ConsoleColors.reset}");
  }
}

void printMainmenu() {
  clearScreen();
  print('''
${ConsoleColors.magenta} * * * * Jeu du pendu * * * * ${ConsoleColors.reset}
${ConsoleColors.green}1. Jouer${ConsoleColors.reset}
${ConsoleColors.blue}2. Dictionnaire${ConsoleColors.reset}
${ConsoleColors.red}3. Quitter${ConsoleColors.reset}
${ConsoleColors.yellow}Choisissez une option :${ConsoleColors.reset}
 ''');
}

void playGame(Dictionary dict) {
  String wordSecret = dict.getRandomWord();
  Set<String> foundLetters = <String>{};
  int wrongGuesses = 0;
  const int maxWrongGuesses = 7;

  do {
    printGuess(wordSecret, foundLetters, wrongGuesses);
    print('${ConsoleColors.yellow}Entrez une lettre : ${ConsoleColors.reset}');
    String letter = (stdin.readLineSync()?.toUpperCase() ?? '');
    if (letter.isNotEmpty && !wordSecret.contains(letter)) {
      wrongGuesses++;
    } else {
      for (int i = 0; i < wordSecret.length; i++) {
        if (wordSecret[i] == letter) {
          foundLetters.add(letter);
        }
      }
    }
  } while (wrongGuesses < maxWrongGuesses &&
      foundLetters.length < wordSecret.runes.toSet().length);

  checkWin(wordSecret, foundLetters, wrongGuesses);
  print("${ConsoleColors.yellow}Appuyez sur une touche pour continuer...${ConsoleColors.reset}");
  stdin.readLineSync();
}

void manageDictionary(Dictionary dict) {
  bool manageDict = true;
  while (manageDict) {
    print('''
${ConsoleColors.magenta}Gestion du dictionnaire :
${ConsoleColors.green}1. Ajouter
${ConsoleColors.cyan}2. Modifier
${ConsoleColors.yellow}3. Enlever
${ConsoleColors.blue}4. Lister les mots
${ConsoleColors.red}5. Quitter
${ConsoleColors.magenta}Choisissez une option :${ConsoleColors.reset}
''');
    String choice2 = stdin.readLineSync() ?? '';
    switch (choice2) {
      case '1':
        print('Entrez un mot à ajouter :');
        String wordToAdd = stdin.readLineSync()?.toUpperCase() ?? '';
        dict.addWord(wordToAdd);
        print('Mot ajouté.');
        break;
      case '2':
        print('Entrez le mot à modifier :');
        String oldWord = stdin.readLineSync()?.toUpperCase() ?? '';
        print('Entrez le nouveau mot :');
        String newWord = stdin.readLineSync()?.toUpperCase() ?? '';
        if (dict.modifyWord(oldWord, newWord)) {
          print('Mot modifié.');
        } else {
          print('Le mot n\'a pas été trouvé dans le dictionnaire.');
        }
        break;
      case '3':
        print('Entrez le mot à enlever :');
        String wordToRemove = stdin.readLineSync()?.toUpperCase() ?? '';
        if (dict.removeWord(wordToRemove)) {
          print('Mot enlevé.');
        } else {
          print('Le mot n\'a pas été trouvé dans le dictionnaire.');
        }
        break;
      case '4':
        dict.listWords();
        break;
      case '5':
        print('Êtes-vous sûr de vouloir quitter ? (o/n)');
        String confirm = stdin.readLineSync()?.toLowerCase() ?? '';
        if (confirm == 'o') {
          manageDict = false;
        }
        break;
      default:
        break;
    }
  }
}

void main() async {
  Dictionary dict = Dictionary();
  bool runApp = true;

  while (runApp) {
    printMainmenu();
    String choice = stdin.readLineSync() ?? '';

    switch (choice) {
      case '1':
        if (dict.words.isNotEmpty) {
          playGame(dict);
        } else {
          print('${ConsoleColors.yellow}Le dictionnaire est vide.');
          print("Appuyez sur une touche pour continuer...${ConsoleColors.reset}");
          stdin.readLineSync();
        }
        break;
      case '2':
        manageDictionary(dict);
        break;
      case '3':
        print('${ConsoleColors.yellow}Êtes-vous sûr de vouloir quitter ? (o/n)${ConsoleColors.reset}');
        String confirm = stdin.readLineSync()?.toLowerCase() ?? '';
        if (confirm == 'o') {
          runApp = false;
          clearScreen();
          print('${ConsoleColors.cyan}Au revoir !${ConsoleColors.reset}');
        }
        break;
      default:
        break;
    }
  }
}
