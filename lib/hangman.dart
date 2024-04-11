import 'package:pendu/console_colors.dart';

class PrintHangman {
  static final List<String> hangman = [
    '''
   _________
    |/        
    |              
    |                
    |                 
    |               
    |                   
    |___
''',
    '''
   _________
    |/   |      
    |              
    |                
    |                 
    |               
    |                   
    |___
''',
    '''
   _________       
    |/   |              
    |   (_)
    |                         
    |                       
    |                         
    |                          
    |___
''',
    '''
   ________               
    |/   |                   
    |   (_)                  
    |    |                     
    |    |                    
    |                           
    |                            
    |___
''',
    '''
   _________             
    |/   |               
    |   (_)                   
    |   /|                     
    |    |                    
    |                        
    |                          
    |___
''',
    '''

   _________              
    |/   |                     
    |   (_)                     
    |   /|\\                    
    |    |                       
    |                             
    |                            
    |___
''',
    '''
   ________                   
    |/   |                         
    |   (_)                      
    |   /|\\                             
    |    |                          
    |   /                            
    |                                  
    |___
''',
    '''
   ________
    |/   |     
    |   (_)    
    |   /|\\           
    |    |        
    |   / \\        
    |               
    |___           
  '''
  ];

  static void drawLevel(int level, String color) {
    if (level < 0 || level >= hangman.length) {
      print('Level out of range!');
    } else {
      String coloredOutput =
          "${ConsoleColors.reset}${_getColor(color)}${hangman[level]}${ConsoleColors.reset}";
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
