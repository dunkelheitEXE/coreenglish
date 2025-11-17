import 'package:flutter/material.dart';

class PersonalPronouns extends StatefulWidget {
  const PersonalPronouns({super.key});

  @override
  State<PersonalPronouns> createState() => _PersonalPronounsState();
}

class _PersonalPronounsState extends State<PersonalPronouns> {
  int _currentStep = 0;
  int _score = 0;
  int _currentExercise = 0;
  String? _selectedAnswer;
  final Map<int, String> _matchingAnswers = {};

  // Datos de pronombres personales
  final List<Map<String, dynamic>> pronounsData = [
    {
      'pronoun': 'I',
      'spanish': 'Yo',
      'type': 'Sujeto (1ra persona singular)',
      'example': 'I am happy',
      'exampleSpanish': 'Yo estoy feliz',
      'usage': 'Siempre se refiere a uno mismo',
      'icon': Icons.person,
      'color': Colors.blue,
    },
    {
      'pronoun': 'You',
      'spanish': 'Tú / Usted / Ustedes',
      'type': 'Sujeto (2da persona)',
      'example': 'You are my friend',
      'exampleSpanish': 'Tú eres mi amigo',
      'usage': 'Puede ser singular o plural',
      'icon': Icons.person_outline,
      'color': Colors.green,
    },
    {
      'pronoun': 'He',
      'spanish': 'Él',
      'type': 'Sujeto (3ra persona singular masculino)',
      'example': 'He is a teacher',
      'exampleSpanish': 'Él es un profesor',
      'usage': 'Para referirse a un hombre',
      'icon': Icons.man,
      'color': Colors.indigo,
    },
    {
      'pronoun': 'She',
      'spanish': 'Ella',
      'type': 'Sujeto (3ra persona singular femenino)',
      'example': 'She is a doctor',
      'exampleSpanish': 'Ella es una doctora',
      'usage': 'Para referirse a una mujer',
      'icon': Icons.woman,
      'color': Colors.pink,
    },
    {
      'pronoun': 'It',
      'spanish': 'Eso / Ello',
      'type': 'Sujeto (3ra persona singular neutro)',
      'example': 'It is a cat',
      'exampleSpanish': 'Es un gato',
      'usage': 'Para animales, cosas o ideas',
      'icon': Icons.category,
      'color': Colors.orange,
    },
    {
      'pronoun': 'We',
      'spanish': 'Nosotros / Nosotras',
      'type': 'Sujeto (1ra persona plural)',
      'example': 'We are students',
      'exampleSpanish': 'Nosotros somos estudiantes',
      'usage': 'Para incluirse con otros',
      'icon': Icons.groups,
      'color': Colors.teal,
    },
    {
      'pronoun': 'They',
      'spanish': 'Ellos / Ellas',
      'type': 'Sujeto (3ra persona plural)',
      'example': 'They are friends',
      'exampleSpanish': 'Ellos son amigos',
      'usage': 'Para personas, animales o cosas (plural)',
      'icon': Icons.group,
      'color': Colors.purple,
    },
  ];

  // Ejercicios de matching
  final List<Map<String, dynamic>> matchingExercises = [
    {
      'sentence': '___ am a student',
      'options': ['I', 'You', 'He', 'They'],
      'correct': 'I',
      'translation': 'Yo soy un estudiante',
    },
    {
      'sentence': '___ is my brother',
      'options': ['I', 'He', 'We', 'They'],
      'correct': 'He',
      'translation': 'Él es mi hermano',
    },
    {
      'sentence': '___ are happy',
      'options': ['I', 'She', 'It', 'They'],
      'correct': 'They',
      'translation': 'Ellos están felices',
    },
    {
      'sentence': '___ is a beautiful day',
      'options': ['He', 'She', 'It', 'We'],
      'correct': 'It',
      'translation': 'Es un día hermoso',
    },
    {
      'sentence': '___ are best friends',
      'options': ['I', 'He', 'We', 'It'],
      'correct': 'We',
      'translation': 'Nosotros somos mejores amigos',
    },
  ];

  // Quiz final
  final List<Map<String, dynamic>> quizQuestions = [
    {
      'question': '¿Qué pronombre usas para referirte a ti mismo?',
      'options': ['I', 'You', 'We', 'He'],
      'correct': 'I',
    },
    {
      'question': '¿Qué pronombre usas para un objeto o animal?',
      'options': ['He', 'She', 'It', 'They'],
      'correct': 'It',
    },
    {
      'question': '¿Cuál es el pronombre para "Ella"?',
      'options': ['He', 'She', 'It', 'They'],
      'correct': 'She',
    },
    {
      'question': '¿Qué pronombre significa "Nosotros"?',
      'options': ['I', 'You', 'We', 'They'],
      'correct': 'We',
    },
    {
      'question': '¿Cuál usas para varias personas (ellos)?',
      'options': ['He', 'She', 'We', 'They'],
      'correct': 'They',
    },
    {
      'question': 'El pronombre "You" puede ser:',
      'options': [
        'Solo singular',
        'Solo plural',
        'Singular y plural',
        'Solo formal'
      ],
      'correct': 'Singular y plural',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Pronouns'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade400, Colors.purple.shade600],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: _buildStepContent(),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.purple.shade50,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Paso ${_currentStep + 1} de 4',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                _getStepTitle(),
                style: TextStyle(
                  color: Colors.purple.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (_currentStep + 1) / 4,
            backgroundColor: Colors.grey.shade300,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Aprendiendo';
      case 1:
        return 'Tarjetas';
      case 2:
        return 'Práctica';
      case 3:
        return 'Quiz Final';
      default:
        return '';
    }
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildLearningSection();
      case 1:
        return _buildFlashcardsSection();
      case 2:
        return _buildPracticeSection();
      case 3:
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
        Card(
          color: const Color(0xFFE1BEE7),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.school, color: Colors.purple, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '¿Qué son los Personal Pronouns?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Los pronombres personales sustituyen a los nombres de personas, '
                  'animales o cosas. Son palabras fundamentales para construir oraciones en inglés.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Los 7 Pronombres Personales:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...pronounsData.map((pronoun) => _buildPronounCard(pronoun)),
        const SizedBox(height: 20),
        Card(
          color: const Color(0xFFFFF9C4),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.orange),
                    SizedBox(width: 8),
                    Text(
                      '💡 Datos importantes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '• "I" siempre se escribe con mayúscula\n'
                  '• "You" sirve para singular y plural\n'
                  '• "It" se usa para animales, objetos e ideas\n'
                  '• "They" es para cualquier grupo (personas, animales, cosas)',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPronounCard(Map<String, dynamic> pronoun) {
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
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (pronoun['color'] as Color).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    pronoun['icon'],
                    color: pronoun['color'],
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pronoun['pronoun'],
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: pronoun['color'],
                        ),
                      ),
                      Text(
                        pronoun['spanish'],
                        style: TextStyle(
                          fontSize: 18,
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
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pronoun['type'],
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.info_outline, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          pronoun['usage'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (pronoun['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.chat_bubble_outline,
                          size: 16, color: pronoun['color']),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          pronoun['example'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.translate, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          pronoun['exampleSpanish'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SECCIÓN 2: FLASHCARDS
  Widget _buildFlashcardsSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          color: Color(0xFFE3F2FD),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.flip, color: Colors.blue),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '¡Practica con las tarjetas! Toca para voltear.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...pronounsData.map((pronoun) => _buildFlipCard(pronoun)),
      ],
    );
  }

  Widget _buildFlipCard(Map<String, dynamic> pronoun) {
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
              height: 160,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isFlipped
                      ? [Colors.green.shade300, Colors.green.shade500]
                      : [
                          (pronoun['color'] as Color).withOpacity(0.7),
                          pronoun['color'] as Color
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isFlipped ? Icons.translate : pronoun['icon'],
                        size: 50,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isFlipped
                            ? pronoun['spanish']
                            : pronoun['pronoun'],
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isFlipped
                            ? pronoun['pronoun']
                            : pronoun['type'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // SECCIÓN 3: PRÁCTICA
  Widget _buildPracticeSection() {
    if (_currentExercise >= matchingExercises.length) {
      return _buildPracticeResults();
    }

    final exercise = matchingExercises[_currentExercise];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Colors.amber.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Ejercicio ${_currentExercise + 1} de ${matchingExercises.length}',
                    style: TextStyle(
                      color: Colors.amber.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Completa con el pronombre correcto',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _currentExercise / matchingExercises.length,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    exercise['sentence'],
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    exercise['translation'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Selecciona el pronombre correcto:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(
            exercise['options'].length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildPracticeOption(
                exercise['options'][index],
                exercise['correct'],
                _currentExercise,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeOption(
      String option, String correctAnswer, int exerciseIndex) {
    final selectedAnswer = _matchingAnswers[exerciseIndex];
    final isSelected = selectedAnswer == option;
    final showResult = selectedAnswer != null;

    Color getColor() {
      if (!showResult) return Colors.white;
      if (isSelected) {
        return option == correctAnswer
            ? Colors.green.shade100
            : Colors.red.shade100;
      }
      if (option == correctAnswer) return Colors.green.shade100;
      return Colors.white;
    }

    Color getBorderColor() {
      if (!showResult) return Colors.purple.shade200;
      if (isSelected) {
        return option == correctAnswer ? Colors.green : Colors.red;
      }
      if (option == correctAnswer) return Colors.green;
      return Colors.grey.shade300;
    }

    return InkWell(
      onTap: selectedAnswer == null
          ? () {
              setState(() {
                _matchingAnswers[exerciseIndex] = option;
                if (option == correctAnswer) {
                  _score++;
                }
              });
              Future.delayed(const Duration(milliseconds: 1500), () {
                if (mounted) {
                  setState(() {
                    _currentExercise++;
                  });
                }
              });
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: getColor(),
          border: Border.all(color: getBorderColor(), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showResult && option == correctAnswer)
              const Icon(Icons.check_circle, color: Colors.green, size: 24),
            if (showResult && isSelected && option != correctAnswer)
              const Icon(Icons.cancel, color: Colors.red, size: 24),
            if (showResult) const SizedBox(width: 12),
            Text(
              option,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPracticeResults() {
    final percentage = (_score / matchingExercises.length * 100).round();

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Colors.green.shade400,
              ),
              const SizedBox(height: 24),
              const Text(
                '¡Práctica completada!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Respuestas correctas: $_score/${matchingExercises.length}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade600,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _currentExercise = 0;
                    _score = 0;
                    _matchingAnswers.clear();
                  });
                },
                icon: const Icon(Icons.replay),
                label: const Text('Practicar de Nuevo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // SECCIÓN 4: QUIZ FINAL
  Widget _buildQuizSection() {
    if (_currentExercise >= quizQuestions.length) {
      return _buildQuizResults();
    }

    final question = quizQuestions[_currentExercise];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Colors.deepPurple.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.quiz, color: Colors.deepPurple),
                      SizedBox(width: 8),
                      Text(
                        'Quiz Final',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pregunta ${_currentExercise + 1} de ${quizQuestions.length}',
                    style: TextStyle(
                      color: Colors.deepPurple.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _currentExercise / quizQuestions.length,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                question['question'],
                style: const TextStyle(
                  fontSize: 22,
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
    final showResult = _selectedAnswer != null;

    Color getColor() {
      if (!showResult) return Colors.white;
      if (isSelected) {
        return option == correctAnswer
            ? Colors.green.shade100
            : Colors.red.shade100;
      }
      if (option == correctAnswer) return Colors.green.shade100;
      return Colors.white;
    }

    Color getBorderColor() {
      if (!showResult) return Colors.grey.shade300;
      if (isSelected) {
        return option == correctAnswer ? Colors.green : Colors.red;
      }
      if (option == correctAnswer) return Colors.green;
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
              Future.delayed(const Duration(milliseconds: 1500), () {
                if (mounted) {
                  setState(() {
                    _currentExercise++;
                    _selectedAnswer = null;
                  });
                }
              });
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: getColor(),
          border: Border.all(color: getBorderColor(), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (showResult && option == correctAnswer)
              const Icon(Icons.check_circle, color: Colors.green, size: 24),
            if (showResult && isSelected && option != correctAnswer)
              const Icon(Icons.cancel, color: Colors.red, size: 24),
            if (showResult) const SizedBox(width: 12),
            Expanded(
              child: Text(
                option,
                style: const TextStyle(
                  fontSize: 18,
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

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                passed ? Icons.emoji_events : Icons.replay,
                size: 100,
                color: passed ? Colors.amber : Colors.purple,
              ),
              const SizedBox(height: 24),
              Text(
                passed ? '¡Excelente trabajo!' : '¡Sigue practicando!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Puntuación: $_score/${quizQuestions.length}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: passed ? Colors.green : Colors.purple,
                ),
              ),
              const SizedBox(height: 32),
              if (!passed)
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _currentStep = 2;
                      _currentExercise = 0;
                      _score = 0;
                      _selectedAnswer = null;
                    });
                  },
                  icon: const Icon(Icons.replay),
                  label: const Text('Reintentar Quiz'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
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
                        content: Text('¡Lección de Personal Pronouns completada!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle),
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
                      _currentStep = 2;
                      _currentExercise = 0;
                      _score = 0;
                      _selectedAnswer = null;
                    });
                  },
                  icon: const Icon(Icons.replay),
                  label: const Text('Repetir Quiz'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.purple,
                    side: const BorderSide(color: Colors.purple),
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
      ),
    );
  }

  // BOTONES DE NAVEGACIÓN
  Widget _buildNavigationButtons() {
    final canGoNext = _currentStep < 3 &&
        (_currentStep != 2 || _currentExercise >= matchingExercises.length);

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
                    if (_currentStep == 2) {
                      _currentExercise = 0;
                      _score = 0;
                      _matchingAnswers.clear();
                    } else if (_currentStep == 3) {
                      _currentExercise = 0;
                      _score = 0;
                      _selectedAnswer = null;
                    }
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
              onPressed: canGoNext
                  ? () {
                      setState(() {
                        if (_currentStep == 2) {
                          _currentExercise = 0;
                          _score = 0;
                          _matchingAnswers.clear();
                        }
                        _currentStep++;
                      });
                    }
                  : null,
              icon: const Icon(Icons.arrow_forward),
              label: Text(_currentStep < 3 ? 'Siguiente' : 'Finalizar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                disabledBackgroundColor: Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}