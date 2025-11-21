import 'package:flutter/material.dart';
import 'word_search_themes.dart';
import 'word_search_board.dart';
import 'word_search_timer.dart';
import 'word_search_results.dart';

class WordSearchGame extends StatefulWidget {
  const WordSearchGame({super.key});

  @override
  State<WordSearchGame> createState() => _WordSearchGameState();
}

class _WordSearchGameState extends State<WordSearchGame> {
  GameState _gameState = GameState.choosingTheme;
  WordSearchTheme? _selectedTheme;
  WordSearchBoard? _board;
  WordSearchTimer? _timer;
  
  final List<String> _foundWords = [];
  final List<CellPosition> _selectedCells = [];
  final List<WordPosition> _foundWordPositions = [];
  
  // Scroll controllers
  final ScrollController _gridScrollController = ScrollController();
  final ScrollController _wordsScrollController = ScrollController();

  int get _gridSize {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    
    if (screenWidth < 350) return 10;   // Pantallas muy pequeñas
    if (screenWidth < 400) return 12;  // Móviles pequeños
    if (screenWidth < 600) return 14;  // Móviles normales
    if (screenWidth < 900) return 16;  // Tablets
    return 18; // Desktop
  }

  int get _gameTime => 300;

  @override
  void dispose() {
    _timer?.dispose();
    _gridScrollController.dispose();
    _wordsScrollController.dispose();
    super.dispose();
  }

  void _startGame(WordSearchTheme theme) {
    setState(() {
      _selectedTheme = theme;
      _gameState = GameState.playing;
      _foundWords.clear();
      _selectedCells.clear();
      _foundWordPositions.clear();
      
      final words = WordSearchThemes.getWordsForGrid(theme, _gridSize);
      _board = WordSearchBoard(size: _gridSize, words: words);
      
      _timer = WordSearchTimer(
        initialSeconds: _gameTime,
        onTick: (remainingSeconds) {
          setState(() {});
        },
        onTimeUp: () {
          _endGame(won: false);
        },
      );
      _timer!.start();
    });
  }

  void _endGame({required bool won}) {
    _timer?.stop();
    setState(() {
      _gameState = GameState.finished;
    });
  }

  void _onCellTap(int row, int col) {
    if (_gameState != GameState.playing) return;
    
    setState(() {
      CellPosition cell = CellPosition(row: row, col: col);
      
      if (_selectedCells.contains(cell)) {
        _selectedCells.remove(cell);
      } else {
        _selectedCells.add(cell);
        
        if (_selectedCells.length >= 2) {
          WordPosition? foundWord = _board!.checkSelection(_selectedCells);
          if (foundWord != null && !_foundWords.contains(foundWord.word)) {
            _foundWords.add(foundWord.word);
            _foundWordPositions.add(foundWord);
            _selectedCells.clear();
            
            if (_foundWords.length == _board!.words.length) {
              _endGame(won: true);
            }
          }
        }
      }
    });
  }

  void _resetGame() {
    setState(() {
      _gameState = GameState.choosingTheme;
      _selectedTheme = null;
      _board = null;
      _timer?.dispose();
      _timer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sopa de Letras - TI'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: _gameState == GameState.playing ? [_buildTimer()] : null,
      ),
      body: _buildGameContent(),
    );
  }

  Widget _buildTimer() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        _timer?.formattedTime ?? '05:00',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildGameContent() {
    switch (_gameState) {
      case GameState.choosingTheme:
        return _buildThemeSelection();
      case GameState.playing:
        return _buildGameBoard();
      case GameState.finished:
        return _buildResults();
    }
  }

  Widget _buildThemeSelection() {
    final themes = WordSearchThemes.getThemes();
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade50,
            Colors.deepPurple.shade100,
          ],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Elige un Tema',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Encuentra palabras relacionadas con Tecnologías de la Información',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: isMobile 
                ? _buildThemesListView(themes)
                : _buildThemesGridView(themes),
          ),
        ],
      ),
    );
  }

  Widget _buildThemesGridView(List<WordSearchTheme> themes) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: themes.length,
      itemBuilder: (context, index) => _buildThemeCard(themes[index]),
    );
  }

  Widget _buildThemesListView(List<WordSearchTheme> themes) {
    return ListView.builder(
      itemCount: themes.length,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: _buildThemeCard(themes[index]),
      ),
    );
  }

  Widget _buildThemeCard(WordSearchTheme theme) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => _startGame(theme),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple.shade400,
                Colors.deepPurple.shade600,
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                theme.icon,
                style: const TextStyle(fontSize: 40),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      theme.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${theme.words.length} palabras',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameBoard() {
    if (_board == null || _selectedTheme == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _buildGameInfo(),
          const SizedBox(height: 16),
          Expanded(
            child: MediaQuery.of(context).size.width < 600 
                ? _buildMobileLayout()
                : _buildDesktopLayout(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Header con información compacta
        _buildMobileGameHeader(),
        const SizedBox(height: 12),
        // Tablero de letras con scroll
        Expanded(
          flex: 2,
          child: _buildLetterGridWithScroll(),
        ),
        const SizedBox(height: 12),
        // Lista de palabras con scroll
        Expanded(
          flex: 1,
          child: _buildWordListWithScroll(),
        ),
      ],
    );
  }

  Widget _buildMobileGameHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  'Tiempo',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  _timer?.formattedTime ?? '00:00',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Encontradas',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  '${_foundWords.length}/${_board!.words.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildLetterGridWithScroll(),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: _buildWordListWithScroll(),
        ),
      ],
    );
  }

  Widget _buildLetterGridWithScroll() {
    // Calcular el tamaño mínimo para que las letras sean legibles
    final cellSize = _calculateCellSize();
    final gridTotalSize = _gridSize * cellSize;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 8),
              child: Text(
                'Sopa de Letras - ${_selectedTheme!.name}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                controller: _gridScrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _gridScrollController,
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      width: gridTotalSize.toDouble(),
                      height: gridTotalSize.toDouble(),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple.shade200, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _buildLetterGrid(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateCellSize() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Tamaño base para móviles
    double baseSize = 28.0;
    
    // Ajustar según el tamaño de pantalla
    if (screenWidth < 350) {
      baseSize = 24.0;
    } else if (screenWidth < 400) {
      baseSize = 26.0;
    } else if (screenWidth < 600) {
      baseSize = 28.0;
    } else {
      baseSize = 32.0;
    }
    
    return baseSize;
  }

  Widget _buildLetterGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // Deshabilitar scroll interno
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _gridSize,
        childAspectRatio: 1.0,
      ),
      itemCount: _gridSize * _gridSize,
      itemBuilder: (context, index) {
        int row = index ~/ _gridSize;
        int col = index % _gridSize;
        bool isSelected = _selectedCells.contains(CellPosition(row: row, col: col));
        bool isInFoundWord = _isCellInFoundWord(row, col);

        return _buildGridCell(row, col, isSelected, isInFoundWord);
      },
    );
  }

  Widget _buildGridCell(int row, int col, bool isSelected, bool isInFoundWord) {
    Color backgroundColor = Colors.white;
    
    if (isInFoundWord) {
      backgroundColor = Colors.green.shade100;
    } else if (isSelected) {
      backgroundColor = Colors.yellow.shade100;
    }

    final cellSize = _calculateCellSize();
    final fontSize = cellSize * 0.6; // 60% del tamaño de la celda

    return Container(
      margin: const EdgeInsets.all(0.5),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onCellTap(row, col),
          child: Center(
            child: Text(
              _board!.grid[row][col],
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: isInFoundWord ? Colors.green : Colors.deepPurple,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWordListWithScroll() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Palabras a Encontrar:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_foundWords.length}/${_board!.words.length} encontradas',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Scrollbar(
                controller: _wordsScrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: _wordsScrollController,
                  itemCount: _board!.words.length,
                  itemBuilder: (context, index) {
                    String word = _board!.words[index];
                    bool isFound = _foundWords.contains(word);
                    
                    return _buildWordItem(word, isFound);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordItem(String word, bool isFound) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isFound ? Colors.green.shade50 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isFound ? Colors.green : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isFound ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isFound ? Colors.green : Colors.grey,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              word,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isFound ? Colors.green : Colors.deepPurple,
                decoration: isFound ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoItem('Tema', _selectedTheme!.name),
            _buildInfoItem('Tiempo', _timer?.formattedTime ?? '00:00'),
            _buildInfoItem('Encontradas', '${_foundWords.length}/${_board!.words.length}'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }

  bool _isCellInFoundWord(int row, int col) {
    for (WordPosition position in _foundWordPositions) {
      int dr = 0, dc = 0;
      switch (position.direction) {
        case 0: dc = 1; break;
        case 1: dr = 1; break;
        case 2: dr = 1; dc = 1; break;
      }

      String wordToCheck = position.reversed ? _reverseString(position.word) : position.word;
      
      for (int i = 0; i < wordToCheck.length; i++) {
        int r = position.startRow + dr * i;
        int c = position.startCol + dc * i;
        
        if (r == row && c == col) {
          return true;
        }
      }
    }
    return false;
  }

  String _reverseString(String input) {
    return input.split('').reversed.join();
  }

  Widget _buildResults() {
    return WordSearchResultsScreen(
      score: _foundWords.length,
      totalWords: _board?.words.length ?? 1,
      timeLeft: _timer?.remainingSeconds ?? 0,
      won: _foundWords.length == _board?.words.length,
      onPlayAgain: _resetGame,
      onExit: () => Navigator.pop(context),
    );
  }
}

enum GameState {
  choosingTheme,
  playing,
  finished,
}