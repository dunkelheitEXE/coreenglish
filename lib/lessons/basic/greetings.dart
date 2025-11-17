import 'package:flutter/material.dart';

class Greetings extends StatefulWidget {
  const Greetings({super.key});

  @override
  State<Greetings> createState() => _GreetingsState();
}

class _GreetingsState extends State<Greetings> {
  int _currentStep = 0;
  int _score = 0;
  int _currentQuizQuestion = 0;
  String? _selectedAnswer;

  // Datos de saludos
  final List<Map<String, dynamic>> greetingsData = [
    {
      'english': 'Hello',
      'spanish': 'Hola',
      'pronunciation': '/həˈloʊ/',
      'usage': 'Formal e informal',
      'icon': Icons.waving_hand,
    },
    {
      'english': 'Hi',
      'spanish': 'Hola (informal)',
      'pronunciation': '/haɪ/',
      'usage': 'Informal',
      'icon': Icons.emoji_emotions,
    },
    {
      'english': 'Good morning',
      'spanish': 'Buenos días',
      'pronunciation': '/ɡʊd ˈmɔːrnɪŋ/',
      'usage': 'Formal, antes del mediodía',
      'icon': Icons.wb_sunny,
    },
    {
      'english': 'Good afternoon',
      'spanish': 'Buenas tardes',
      'pronunciation': '/ɡʊd ˌæftərˈnuːn/',
      'usage': 'Formal, 12pm - 6pm',
      'icon': Icons.light_mode,
    },
    {
      'english': 'Good evening',
      'spanish': 'Buenas noches (saludo)',
      'pronunciation': '/ɡʊd ˈiːvnɪŋ/',
      'usage': 'Formal, después de 6pm',
      'icon': Icons.nightlight_round,
    },
    {
      'english': 'Goodbye',
      'spanish': 'Adiós',
      'pronunciation': '/ɡʊdˈbaɪ/',
      'usage': 'Formal e informal',
      'icon': Icons.back_hand,
    },
    {
      'english': 'Bye',
      'spanish': 'Chao (informal)',
      'pronunciation': '/baɪ/',
      'usage': 'Informal',
      'icon': Icons.waves,
    },
    {
      'english': 'See you later',
      'spanish': 'Nos vemos luego',
      'pronunciation': '/siː juː ˈleɪtər/',
      'usage': 'Informal',
      'icon': Icons.schedule,
    },
  ];

  // Preguntas del quiz
  final List<Map<String, dynamic>> quizQuestions = [
    {
      'question': '¿Cómo dices "Buenos días" en inglés?',
      'options': ['Good night', 'Good morning', 'Good afternoon', 'Hello'],
      'correct': 'Good morning',
    },
    {
      'question': '¿Cuál saludo es más informal?',
      'options': ['Good evening', 'Hi', 'Good morning', 'Good afternoon'],
      'correct': 'Hi',
    },
    {
      'question': '¿Qué significa "See you later"?',
      'options': ['Hola', 'Adiós', 'Nos vemos luego', 'Buenas tardes'],
      'correct': 'Nos vemos luego',
    },
    {
      'question': '¿Cuándo usas "Good evening"?',
      'options': [
        'Por la mañana',
        'Al mediodía',
        'Después de las 6pm',
        'Al despertar'
      ],
      'correct': 'Después de las 6pm',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Greetings & Farewells'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade400, Colors.orange.shade600],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.orange.shade50,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Paso ${_currentStep + 1} de 3',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _getStepTitle(),
                      style: TextStyle(
                        color: Colors.orange.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (_currentStep + 1) / 3,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: _buildStepContent(),
          ),
          // Navigation buttons
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Aprendiendo';
      case 1:
        return 'Practicando';
      case 2:
        return 'Evaluación';
      default:
        return '';
    }
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildLearningSection();
      case 1:
        return _buildPracticeSection();
      case 2:
        return _buildQuizSection();
      default:
        return Container();
    }
  }

  // SECCIÓN 1: APRENDIZAJE
  Widget _buildLearningSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          color: Color(0xFFFFF3E0),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.orange),
                    SizedBox(width: 8),
                    Text(
                      'Tip importante',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Los saludos en inglés varían según:\n'
                  '• La hora del día\n'
                  '• El nivel de formalidad\n'
                  '• El contexto social',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Saludos comunes:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...greetingsData.map((greeting) => _buildGreetingCard(greeting)),
      ],
    );
  }

  Widget _buildGreetingCard(Map<String, dynamic> greeting) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(greeting['icon'], color: Colors.orange),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greeting['english'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        greeting['spanish'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.volume_up, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        greeting['pronunciation'],
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '📌 ${greeting['usage']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SECCIÓN 2: PRÁCTICA
  Widget _buildPracticeSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          color: Color(0xFFE3F2FD),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.school, color: Colors.blue),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '¡Ahora practiquemos! Toca las tarjetas para voltearlas.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...greetingsData.map((greeting) => _buildFlipCard(greeting)),
      ],
    );
  }

  Widget _buildFlipCard(Map<String, dynamic> greeting) {
    return StatefulBuilder(
      builder: (context, setCardState) {
        bool isFlipped = false;
        return GestureDetector(
          onTap: () {
            setCardState(() {
              isFlipped = !isFlipped;
            });
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isFlipped
                      ? [Colors.green.shade300, Colors.green.shade400]
                      : [Colors.blue.shade300, Colors.blue.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isFlipped ? Icons.translate : greeting['icon'],
                      size: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isFlipped ? greeting['spanish'] : greeting['english'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isFlipped ? greeting['english'] : greeting['pronunciation'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // SECCIÓN 3: QUIZ
  Widget _buildQuizSection() {
    if (_currentQuizQuestion >= quizQuestions.length) {
      return _buildQuizResults();
    }

    final question = quizQuestions[_currentQuizQuestion];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Colors.purple.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Pregunta ${_currentQuizQuestion + 1} de ${quizQuestions.length}',
                    style: TextStyle(
                      color: Colors.purple.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _currentQuizQuestion / quizQuestions.length,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                question['question'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ...List.generate(
            question['options'].length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildQuizOption(
                question['options'][index],
                question['correct'],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizOption(String option, String correctAnswer) {
    final isSelected = _selectedAnswer == option;
    final isCorrect = option == correctAnswer;
    final showResult = _selectedAnswer != null;

    Color getColor() {
      if (!showResult) return Colors.white;
      if (isSelected) {
        return isCorrect ? Colors.green.shade100 : Colors.red.shade100;
      }
      if (isCorrect) return Colors.green.shade100;
      return Colors.white;
    }

    Color getBorderColor() {
      if (!showResult) return Colors.grey.shade300;
      if (isSelected) {
        return isCorrect ? Colors.green : Colors.red;
      }
      if (isCorrect) return Colors.green;
      return Colors.grey.shade300;
    }

    return InkWell(
      onTap: _selectedAnswer == null
          ? () {
              setState(() {
                _selectedAnswer = option;
                if (option == correctAnswer) {
                  _score++;
                }
              });
              Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  _currentQuizQuestion++;
                  _selectedAnswer = null;
                });
              });
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: getColor(),
          border: Border.all(color: getBorderColor(), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (showResult && isCorrect)
              const Icon(Icons.check_circle, color: Colors.green),
            if (showResult && isSelected && !isCorrect)
              const Icon(Icons.cancel, color: Colors.red),
            if (showResult) const SizedBox(width: 12),
            Expanded(
              child: Text(
                option,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizResults() {
    final percentage = (_score / quizQuestions.length * 100).round();
    final passed = percentage >= 70;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              passed ? Icons.emoji_events : Icons.replay,
              size: 100,
              color: passed ? Colors.amber : Colors.orange,
            ),
            const SizedBox(height: 24),
            Text(
              passed ? '¡Felicitaciones!' : '¡Sigue practicando!',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Tu puntuación: $_score/${quizQuestions.length}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: passed ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 32),
            if (!passed)
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _currentQuizQuestion = 0;
                    _score = 0;
                    _selectedAnswer = null;
                  });
                },
                icon: const Icon(Icons.replay),
                label: const Text('Reintentar Quiz'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
            if (passed) ...[
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('¡Lección completada con éxito!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.check),
                label: const Text('Completar Lección'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _currentQuizQuestion = 0;
                    _score = 0;
                    _selectedAnswer = null;
                  });
                },
                icon: const Icon(Icons.replay),
                label: const Text('Hacer Quiz de Nuevo'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange,
                  side: const BorderSide(color: Colors.orange),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // BOTONES DE NAVEGACIÓN
  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _currentStep--;
                  });
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Anterior'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: _currentStep < 2
                  ? () {
                      setState(() {
                        _currentStep++;
                      });
                    }
                  : _currentQuizQuestion < quizQuestions.length
                      ? null
                      : () {
                          setState(() {
                            _currentStep = 0;
                            _currentQuizQuestion = 0;
                            _score = 0;
                            _selectedAnswer = null;
                          });
                        },
              icon: Icon(_currentStep < 2 ? Icons.arrow_forward : Icons.replay),
              label: Text(_currentStep < 2 ? 'Siguiente' : 'Reiniciar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}