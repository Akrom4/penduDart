class ConsoleColors {
  static const String reset = '\x1B[0m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';
}

class HangmanDraw {
  static final List<String> hangman = [
    '''
  +---+
  |   |
      |
      |
      |
      |
=========
''',
    '''
  +---+
  |   |
  O   |
      |
      |
      |
=========
''',
    '''
  +---+
  |   |
  O   |
  |   |
      |
      |
=========
''',
    '''
  +---+
  |   |
  O   |
 /|   |
      |
      |
=========
''',
    '''
  +---+
  |   |
  O   |
 /|\\  |
      |
      |
=========
''',
    '''
  +---+
  |   |
  O   |
 /|\\  |
 /    |
      |
=========
''',
    '''
  +---+
  |   |
  O   |
 /|\\  |
 / \\  |
      |
=========
'''
  ];

  static void drawLevel(int level, String color) {
    if (level < 0 || level >= hangman.length) {
      print('Level out of range!');
    } else {
      String coloredOutput = "${ConsoleColors.reset}${_getColor(color)}${hangman[level]}${ConsoleColors.reset}";
      print(coloredOutput);
    }
  }

  static String _getColor(String color) {
    switch (color.toLowerCase()) {
      case 'red':
        return ConsoleColors.red;
      case 'green':
        return ConsoleColors.green;
      case 'yellow':
        return ConsoleColors.yellow;
      case 'blue':
        return ConsoleColors.blue;
      case 'magenta':
        return ConsoleColors.magenta;
      case 'cyan':
        return ConsoleColors.cyan;
      case 'white':
        return ConsoleColors.white;
      default:
        return ConsoleColors.white;
    }
  }
}