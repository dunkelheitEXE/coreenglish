class WordSearchCell {
  final String letter;
  bool isSelected;
  bool isFound;

  WordSearchCell({
    required this.letter,
    this.isSelected = false,
    this.isFound = false,
  });
}

class WordSearchGame {
  List<List<WordSearchCell>> grid;
  List<String> wordsToFind;
  List<String> foundWords;
  int timeLeft;
  bool isGameOver;
  String currentTheme;

  WordSearchGame({
    required this.grid,
    required this.wordsToFind,
    required this.currentTheme,
    this.timeLeft = 120, // 2 minutos
    this.foundWords = const [],
    this.isGameOver = false,
  });
}