// Jeu du pendu
import 'dart:io';
import 'package:pendu/pendu.dart';

void printGuess(String wordSecret, Set<String> foundLetters, int wrongGuesses) {
  clearScreen();
  HangmanDraw.drawLevel(wrongGuesses, 'red');

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
    HangmanDraw.drawLevel(wrongGuesses, 'green');
    print(
        "Gagné ! Vous avez trouvé le mot : ${ConsoleColors.green} ${wordSecret.toUpperCase()} ${ConsoleColors.reset}");
  }
  else {
    clearScreen();
    HangmanDraw.drawLevel(wrongGuesses, 'red');
    print(
        "Perdu ! Le mot était : ${ConsoleColors.red} ${wordSecret.toUpperCase()} ${ConsoleColors.reset}");
  }
}

void main() {
  String wordSecret = 'AZERTY';
  Set<String> foundLetters = <String>{};
  int wrongGuesses = 0;
  const int maxWrongGuesses = 6;

  clearScreen();
  print(' * * * * Jeu du pendu * * * * ');

  do {
    printGuess(wordSecret, foundLetters, wrongGuesses);
    print('Entrez une lettre : ');
    String letter = (stdin.readLineSync()?.toUpperCase() ?? '');
    if (letter.isNotEmpty && !wordSecret.contains(letter)) {
      wrongGuesses++;
    } else {
      for (int i = 0; i < wordSecret.length; i++) {
        if (wordSecret[i] == letter[0]) {
          foundLetters.add(letter[0]);
        }
      }
    }
  } while (wrongGuesses < maxWrongGuesses &&
      foundLetters.length < wordSecret.runes.toSet().length);

  checkWin(wordSecret, foundLetters, wrongGuesses);
}
