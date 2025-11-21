// Módulo para mostrar resultados del juego
import 'package:flutter/material.dart';

class WordSearchResultsScreen extends StatelessWidget {
  final int score;
  final int totalWords;
  final int timeLeft;
  final bool won;
  final VoidCallback onPlayAgain;
  final VoidCallback onExit;

  const WordSearchResultsScreen({
    super.key,
    required this.score,
    required this.totalWords,
    required this.timeLeft,
    required this.won,
    required this.onPlayAgain,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (score / totalWords * 100).round();
    
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono de resultado
              Icon(
                won ? Icons.emoji_events : Icons.timer_off,
                size: 100,
                color: won ? Colors.amber : Colors.deepPurple,
              ),
              const SizedBox(height: 32),
              
              // Título
              Text(
                won ? '¡Felicidades!' : '¡Tiempo Agotado!',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 16),
              
              // Estadísticas
              _buildStatCard('Palabras Encontradas', '$score/$totalWords'),
              const SizedBox(height: 12),
              _buildStatCard('Tiempo Restante', '${timeLeft ~/ 60}:${(timeLeft % 60).toString().padLeft(2, '0')}'),
              const SizedBox(height: 12),
              _buildStatCard('Puntuación', '$percentage%'),
              const SizedBox(height: 32),
              
              // Mensaje personalizado
              Text(
                _getMessage(percentage),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // Botones de acción
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: onPlayAgain,
                    icon: const Icon(Icons.replay),
                    label: const Text('Jugar Otra Vez'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: onExit,
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text('Salir'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      side: const BorderSide(color: Colors.deepPurple),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMessage(int percentage) {
    if (percentage >= 90) return '¡Excelente trabajo! Eres un experto en TI.';
    if (percentage >= 70) return '¡Muy bien! Tienes buen conocimiento de TI.';
    if (percentage >= 50) return '¡Buen trabajo! Sigue practicando.';
    return '¡Sigue aprendiendo! La práctica hace al maestro.';
  }
}