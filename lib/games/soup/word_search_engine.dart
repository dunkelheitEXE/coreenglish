import 'dart:math';
import 'word_search_model.dart';

class WordSearchEngine {
  List<List<WordSearchCell>> grid = [];
  List<String> words;
  List<String> foundWords = [];
  List<Point<int>> selectedCells = [];
  static const int gridSize = 10;

  WordSearchEngine({required this.words}) {
    _initializeGrid();
    _placeWords();
    _fillEmptyCells();
  }

  void _initializeGrid() {
    grid = List.generate(gridSize, 
      (i) => List.generate(gridSize, 
        (j) => WordSearchCell(letter: ' ')
      )
    );
  }

  void _placeWords() {
    final random = Random();
    
    for (String word in words) {
      String upperWord = word.toUpperCase();
      bool placed = false;
      int attempts = 0;
      
      while (!placed && attempts < 100) {
        int direction = random.nextInt(3); // 0: horizontal, 1: vertical, 2: diagonal
        int row = random.nextInt(gridSize);
        int col = random.nextInt(gridSize);
        
        placed = _tryPlaceWord(upperWord, row, col, direction);
        attempts++;
      }
    }
  }

  bool _tryPlaceWord(String word, int row, int col, int direction) {
    int dRow = 0, dCol = 0;
    
    switch (direction) {
      case 0: // horizontal
        if (col + word.length > gridSize) return false;
        dCol = 1;
        break;
      case 1: // vertical
        if (row + word.length > gridSize) return false;
        dRow = 1;
        break;
      case 2: // diagonal
        if (row + word.length > gridSize || col + word.length > gridSize) return false;
        dRow = 1;
        dCol = 1;
        break;
    }
    
    // Verificar si se puede colocar
    for (int i = 0; i < word.length; i++) {
      int currentRow = row + i * dRow;
      int currentCol = col + i * dCol;
      String currentLetter = grid[currentRow][currentCol].letter;
      if (currentLetter != ' ' && currentLetter != word[i]) {
        return false;
      }
    }
    
    // Colocar la palabra
    for (int i = 0; i < word.length; i++) {
      int currentRow = row + i * dRow;
      int currentCol = col + i * dCol;
      grid[currentRow][currentCol] = WordSearchCell(letter: word[i]);
    }
    
    return true;
  }

  void _fillEmptyCells() {
    final random = Random();
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        if (grid[i][j].letter == ' ') {
          grid[i][j] = WordSearchCell(
            letter: letters[random.nextInt(letters.length)],
          );
        }
      }
    }
  }

  void selectCell(int row, int col) {
    selectedCells.add(Point<int>(row, col));
    
    if (selectedCells.length >= 2) {
      _checkSelection();
    }
  }

  void _checkSelection() {
    if (selectedCells.length < 2) return;
    
    // Obtener las letras seleccionadas
    String selectedWord = selectedCells
        .map((point) => grid[point.x][point.y].letter)
        .join('');
    
    // Verificar en ambas direcciones
    String reversedWord = selectedWord.split('').reversed.join('');
    
    for (String word in words) {
      String upperWord = word.toUpperCase();
      if (selectedWord == upperWord || reversedWord == upperWord) {
        // Marcar como encontrada
        if (!foundWords.contains(word.toUpperCase())) {
          foundWords.add(word.toUpperCase());
          
          // Marcar celdas como encontradas
          for (Point<int> point in selectedCells) {
            grid[point.x][point.y].isFound = true;
          }
        }
      }
    }
    
    // Limpiar selección
    for (Point<int> point in selectedCells) {
      grid[point.x][point.y].isSelected = false;
    }
    selectedCells.clear();
  }
}