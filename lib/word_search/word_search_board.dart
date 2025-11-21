// Módulo para la lógica del tablero de sopa de letras
import 'dart:math';

class WordSearchBoard {
  late List<List<String>> grid;
  late int size;
  late List<String> words;
  late List<WordPosition> wordPositions;
  final Random random = Random();

  WordSearchBoard({required this.size, required this.words}) {
    _initializeGrid();
    _placeWords();
    _fillEmptyCells();
  }

  void _initializeGrid() {
    grid = List.generate(size, (_) => List.generate(size, (_) => ' '));
  }

  void _placeWords() {
    wordPositions = [];
    List<String> wordsToPlace = List.from(words);
    wordsToPlace.shuffle(random);

    for (String word in wordsToPlace) {
      bool placed = false;
      int attempts = 0;

      while (!placed && attempts < 100) {
        int direction = random.nextInt(3); // 0: horizontal, 1: vertical, 2: diagonal
        int row = random.nextInt(size);
        int col = random.nextInt(size);
        bool reverse = random.nextBool();

        String wordToPlace = reverse ? _reverseString(word) : word;

        placed = _tryPlaceWord(wordToPlace, row, col, direction);
        
        if (placed) {
          wordPositions.add(WordPosition(
            word: word,
            startRow: row,
            startCol: col,
            direction: direction,
            reversed: reverse,
          ));
        }
        attempts++;
      }
    }
  }

  bool _tryPlaceWord(String word, int row, int col, int direction) {
    int dr = 0, dc = 0;
    
    switch (direction) {
      case 0: // horizontal
        dc = 1;
        break;
      case 1: // vertical
        dr = 1;
        break;
      case 2: // diagonal
        dr = 1;
        dc = 1;
        break;
    }

    // Verificar si la palabra cabe
    if (row + dr * (word.length - 1) >= size || 
        col + dc * (word.length - 1) >= size) {
      return false;
    }

    // Verificar superposición
    for (int i = 0; i < word.length; i++) {
      int r = row + dr * i;
      int c = col + dc * i;
      
      if (grid[r][c] != ' ' && grid[r][c] != word[i]) {
        return false;
      }
    }

    // Colocar la palabra
    for (int i = 0; i < word.length; i++) {
      int r = row + dr * i;
      int c = col + dc * i;
      grid[r][c] = word[i];
    }

    return true;
  }

  String _reverseString(String input) {
    return input.split('').reversed.join();
  }

  void _fillEmptyCells() {
    const String letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (grid[i][j] == ' ') {
          grid[i][j] = letters[random.nextInt(letters.length)];
        }
      }
    }
  }

  // Verificar si una selección coincide con alguna palabra
  WordPosition? checkSelection(List<CellPosition> selection) {
    if (selection.length < 2) return null;

    // Ordenar las celdas para verificar dirección
    selection.sort((a, b) {
      if (a.row != b.row) return a.row.compareTo(b.row);
      return a.col.compareTo(b.col);
    });

    String selectedWord = selection.map((cell) => grid[cell.row][cell.col]).join();

    // Verificar en ambas direcciones
    for (WordPosition position in wordPositions) {
      String wordToCheck = position.reversed ? _reverseString(position.word) : position.word;
      
      if (selectedWord == wordToCheck || _reverseString(selectedWord) == wordToCheck) {
        // Verificar si las celdas coinciden con la posición real
        if (_matchesPosition(selection, position)) {
          return position;
        }
      }
    }

    return null;
  }

  bool _matchesSelection(List<CellPosition> selection, WordPosition position) {
    // Esta es una verificación simplificada - en una implementación completa
    // deberías verificar que las celdas seleccionadas coincidan exactamente
    // con la posición de la palabra en el grid
    return true;
  }

  bool _matchesPosition(List<CellPosition> selection, WordPosition position) {
    // Obtener las celdas esperadas para esta palabra
    List<CellPosition> expectedCells = [];
    int dr = 0, dc = 0;
    
    switch (position.direction) {
      case 0: dc = 1; break; // horizontal
      case 1: dr = 1; break; // vertical
      case 2: dr = 1; dc = 1; break; // diagonal
    }

    String wordToCheck = position.reversed ? _reverseString(position.word) : position.word;
    
    for (int i = 0; i < wordToCheck.length; i++) {
      expectedCells.add(CellPosition(
        row: position.startRow + dr * i,
        col: position.startCol + dc * i,
      ));
    }

    // Verificar si la selección coincide con las celdas esperadas
    if (selection.length != expectedCells.length) return false;

    for (int i = 0; i < selection.length; i++) {
      if (selection[i].row != expectedCells[i].row || 
          selection[i].col != expectedCells[i].col) {
        return false;
      }
    }

    return true;
  }
}

class WordPosition {
  final String word;
  final int startRow;
  final int startCol;
  final int direction; // 0: horizontal, 1: vertical, 2: diagonal
  final bool reversed;

  WordPosition({
    required this.word,
    required this.startRow,
    required this.startCol,
    required this.direction,
    required this.reversed,
  });
}

class CellPosition {
  final int row;
  final int col;

  CellPosition({required this.row, required this.col});

  @override
  bool operator ==(Object other) {
    return other is CellPosition && other.row == row && other.col == col;
  }

  @override
  int get hashCode => Object.hash(row, col);
}