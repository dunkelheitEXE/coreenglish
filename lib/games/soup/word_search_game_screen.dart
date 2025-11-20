import 'dart:async';

import 'package:flutter/material.dart';
import 'word_search_themes.dart';
import 'word_search_engine.dart';

class WordSearchGameScreen extends StatefulWidget {
  final WordSearchTheme theme;

  const WordSearchGameScreen({Key? key, required this.theme}) : super(key: key);

  @override
  _WordSearchGameScreenState createState() => _WordSearchGameScreenState();
}

class _WordSearchGameScreenState extends State<WordSearchGameScreen> {
  late WordSearchEngine gameEngine;
  late int timeLeft;
  late Timer timer;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
    gameEngine = WordSearchEngine(words: widget.theme.words);
    timeLeft = 120; // 2 minutos
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          isGameOver = true;
          _showGameOverDialog();
        }
      });
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('¡Tiempo Agotado!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Encontraste ${gameEngine.foundWords.length} de ${widget.theme.words.length} palabras',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: gameEngine.foundWords.length / widget.theme.words.length,
              backgroundColor: Colors.grey.shade300,
              color: Colors.green,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cerrar diálogo
              Navigator.pop(context); // Volver al menú
            },
            child: const Text('Volver al Menú'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                gameEngine = WordSearchEngine(words: widget.theme.words);
                timeLeft = 120;
                isGameOver = false;
                startTimer();
              });
            },
            child: const Text('Jugar Otra Vez'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.theme.name),
        backgroundColor: Colors.blue.shade400,
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(Icons.timer, color: Colors.white),
                const SizedBox(width: 5),
                Text(
                  _formatTime(timeLeft),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade50,
              Colors.purple.shade50,
            ],
          ),
        ),
        child: Column(
          children: [
            // Palabras por encontrar
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white.withOpacity(0.8),
              child: Column(
                children: [
                  const Text(
                    'Palabras por encontrar:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 5,
                    children: widget.theme.words.map((word) {
                      bool isFound = gameEngine.foundWords.contains(word.toUpperCase());
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isFound ? Colors.green.shade100 : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isFound ? Colors.green : Colors.grey,
                          ),
                        ),
                        child: Text(
                          word,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isFound ? Colors.green.shade800 : Colors.grey.shade800,
                            decoration: isFound ? TextDecoration.lineThrough : TextDecoration.none,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Grid de la sopa de letras
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gameEngine.grid.length,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: gameEngine.grid.length * gameEngine.grid.length,
                  itemBuilder: (context, index) {
                    int row = index ~/ gameEngine.grid.length;
                    int col = index % gameEngine.grid.length;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          gameEngine.selectCell(row, col);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: gameEngine.grid[row][col].isFound
                              ? Colors.green.shade300
                              : gameEngine.grid[row][col].isSelected
                                  ? Colors.blue.shade200
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            gameEngine.grid[row][col].letter,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: gameEngine.grid[row][col].isFound
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Progreso
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white.withOpacity(0.8),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: gameEngine.foundWords.length / widget.theme.words.length,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Progreso: ${gameEngine.foundWords.length}/${widget.theme.words.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back),
        backgroundColor: Colors.blue.shade400,
      ),
    );
  }
}