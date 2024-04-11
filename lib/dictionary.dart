import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:pendu/console_colors.dart';


class Dictionary {
  List<String> words = [];
  final String filePath = 'dict.json';

  Dictionary() {
    var file = File(filePath);
    if (!file.existsSync()) {
      file.createSync();
      file.writeAsStringSync(jsonEncode(['CAFE', 'YOYO']));
    }
    _loadWords();
  }

  void _loadWords() {
    var fileContent = File(filePath).readAsStringSync();
    words = List<String>.from(jsonDecode(fileContent));
  }

  void addWord(String word) {
    words.add(word.toUpperCase());
    _saveWords();
  }

  void _saveWords() {
    File(filePath).writeAsStringSync(jsonEncode(words));
  }

  bool removeWord(String word) {
    if (words.contains(word.toUpperCase())) {
      words.remove(word.toUpperCase());
      _saveWords();
      return true;
    }
    return false;
  }

  bool modifyWord(String oldWord, String newWord) {
    int index = words.indexOf(oldWord.toUpperCase());
    if (index != -1) {
      words[index] = newWord.toUpperCase();
      _saveWords();
      return true;
    }
    return false;
  }

  void listWords() {
    if (words.isEmpty) {
      print('Le dictionnaire est vide.');
    } else {
      print(
          '${ConsoleColors.blue}Mots dans le dictionnaire:${ConsoleColors.reset}');
      for (String word in words) {
        print(word);
      }
    }
  }

  String getRandomWord() {
    if (words.isEmpty) {
      return "";
    }
    return words[Random().nextInt(words.length)];
  }
}