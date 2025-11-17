import 'package:flutter/material.dart';

class VerbToBe extends StatefulWidget {
  const VerbToBe({super.key});

  @override
  State<VerbToBe> createState() => _VerbToBeState();
}

class _VerbToBeState extends State<VerbToBe> {
  int _currentStep = 0;
  int _score = 0;
  int _currentExercise = 0;
  String? _selectedAnswer;
  final Map<int, String> _fillInAnswers = {};

  // Datos del verbo To Be
  final List<Map<String, dynamic>> verbToBeData = [
    {
      'pronoun': 'I',
      'verb': 'am',
      'contraction': "I'm",
      'spanish': 'Yo soy/estoy',
      'example': 'I am a student',
      'exampleSpanish': 'Yo soy un estudiante',
    },
    {
      'pronoun': 'You',
      'verb': 'are',
      'contraction': "You're",
      'spanish': 'Tú eres/estás',
      'example': 'You are happy',
      'exampleSpanish': 'Tú estás feliz',
    },
    {
      'pronoun': 'He',
      'verb': 'is',
      'contraction': "He's",
      'spanish': 'Él es/está',
      'example': 'He is a doctor',
      'exampleSpanish': 'Él es un doctor',
    },
    {
      'pronoun': 'She',
      'verb': 'is',
      'contraction': "She's",
      'spanish': 'Ella es/está',
      'example': 'She is beautiful',
      'exampleSpanish': 'Ella es hermosa',
    },
    {
      'pronoun': 'It',
      'verb': 'is',
      'contraction': "It's",
      'spanish': 'Eso/Ello es/está',
      'example': 'It is a cat',
      'exampleSpanish': 'Es un gato',
    },
    {
      'pronoun': 'We',
      'verb': 'are',
      'contraction': "We're",
      'spanish': 'Nosotros somos/estamos',
      'example': 'We are friends',
      'exampleSpanish': 'Nosotros somos amigos',
    },
    {
      'pronoun': 'You',
      'verb': 'are',
      'contraction': "You're",
      'spanish': 'Ustedes son/están',
      'example': 'You are students',
      'exampleSpanish': 'Ustedes son estudiantes',
    },
    {
      'pronoun': 'They',
      'verb': 'are',
      'contraction': "They're",
      'spanish': 'Ellos son/están',
      'example': 'They are teachers',
      'exampleSpanish': 'Ellos son profesores',
    },
  ];

  // Ejercicios de opción múltiple
  final List<Map<String, dynamic>> multipleChoiceExercises = [
    {
      'question': 'I ___ a student',
      'options': ['am', 'is', 'are'],
      'correct': 'am',
      'translation': 'Yo soy un estudiante',
    },
    {
      'question': 'She ___ happy',
      'options': ['am', 'is', 'are'],
      'correct': 'is',
      'translation': 'Ella está feliz',
    },
    {
      'question': 'They ___ friends',
      'options': ['am', 'is', 'are'],
      'correct': 'are',
      'translation': 'Ellos son amigos',
    },
    {
      'question': 'We ___ at home',
      'options': ['am', 'is', 'are'],
      'correct': 'are',
      'translation': 'Nosotros estamos en casa',
    },
    {
      'question': 'He ___ a doctor',
      'options': ['am', 'is', 'are'],
      'correct': 'is',
      'translation': 'Él es un doctor',
    },
  ];

  // Ejercicios de llenar espacios
  final List<Map<String, dynamic>> fillInExercises = [
    {
      'sentence': 'You ___ my best friend',
      'correct': 'are',
      'options': ['am', 'is', 'are'],
      'translation': 'Tú eres mi mejor amigo',
    },
    {
      'sentence': 'It ___ a beautiful day',
      'correct': 'is',
      'options': ['am', 'is', 'are'],
      'translation': 'Es un día hermoso',
    },
    {
      'sentence': 'I ___ tired',
      'correct': 'am',
      'options': ['am', 'is', 'are'],
      'translation': 'Estoy cansado',
    },
    {
      'sentence': 'They ___ in the park',
      'correct': 'are',
      'options': ['am', 'is', 'are'],
      'translation': 'Ellos están en el parque',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verb To Be'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade600],
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
      color: Colors.blue.shade50,
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
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (_currentStep + 1) / 4,
            backgroundColor: Colors.grey.shade300,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Teoría';
      case 1:
        return 'Ejemplos';
      case 2:
        return 'Práctica';
      case 3:
        return 'Evaluación';
      default:
        return '';
    }
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildTheorySection();
      case 1:
        return _buildExamplesSection();
      case 2:
        return _buildPracticeSection();
      case 3:
        return _buildQuizSection();
      default:
        return Container();
    }
  }

  // SECCIÓN 1: TEORÍA
  Widget _buildTheorySection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: const Color(0xFFE3F2FD),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.school, color: Colors.blue, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '¿Qué es el Verb To Be?',
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
                  'El verbo "To Be" significa "SER" o "ESTAR" en español. '
                  'Es uno de los verbos más importantes en inglés.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Formas del Verb To Be:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildVerbTable(),
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
                    Icon(Icons.tips_and_updates, color: Colors.orange),
                    SizedBox(width: 8),
                    Text(
                      '💡 Recuerda',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '• I siempre va con AM\n'
                  '• He, She, It siempre van con IS\n'
                  '• You, We, They siempre van con ARE',
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

  Widget _buildVerbTable() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Pronombre',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Verbo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Contracción',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Español',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ...verbToBeData.map((item) => Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        item['pronoun'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        item['verb'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        item['contraction'],
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        item['spanish'],
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // SECCIÓN 2: EJEMPLOS
  Widget _buildExamplesSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          color: Color(0xFFE8F5E9),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.green, size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Ejemplos en oraciones',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...verbToBeData.map((item) => _buildExampleCard(item)),
      ],
    );
  }

  Widget _buildExampleCard(Map<String, dynamic> item) {
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${item['pronoun']} ${item['verb']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item['contraction'],
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.record_voice_over,
                          size: 16, color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item['example'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
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
                          item['exampleSpanish'],
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

  // SECCIÓN 3: PRÁCTICA
  Widget _buildPracticeSection() {
    if (_currentExercise >= fillInExercises.length) {
      return _buildPracticeResults();
    }

    final exercise = fillInExercises[_currentExercise];

    return SingleChildScrollView(
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
                    'Ejercicio ${_currentExercise + 1} de ${fillInExercises.length}',
                    style: TextStyle(
                      color: Colors.purple.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Completa la oración con la forma correcta',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _currentExercise / fillInExercises.length,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.purple,
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
              child: Column(
                children: [
                  Text(
                    exercise['sentence'],
                    style: const TextStyle(
                      fontSize: 24,
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
            'Selecciona la respuesta correcta:',
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

  Widget _buildPracticeOption(String option, String correctAnswer, int exerciseIndex) {
    final selectedAnswer = _fillInAnswers[exerciseIndex];
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
      if (!showResult) return Colors.grey.shade300;
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
                _fillInAnswers[exerciseIndex] = option;
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
    final percentage = (_score / fillInExercises.length * 100).round();

    return Center(
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
              'Respuestas correctas: $_score/${fillInExercises.length}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade600,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _currentExercise = 0;
                  _score = 0;
                  _fillInAnswers.clear();
                });
              },
              icon: const Icon(Icons.replay),
              label: const Text('Practicar de Nuevo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SECCIÓN 4: QUIZ FINAL
  Widget _buildQuizSection() {
    if (_currentExercise >= multipleChoiceExercises.length) {
      return _buildQuizResults();
    }

    final question = multipleChoiceExercises[_currentExercise];

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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.quiz, color: Colors.amber),
                      SizedBox(width: 8),
                      Text(
                        'Evaluación Final',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pregunta ${_currentExercise + 1} de ${multipleChoiceExercises.length}',
                    style: TextStyle(
                      color: Colors.amber.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _currentExercise / multipleChoiceExercises.length,
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
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Completa la oración:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    question['question'],
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    question['translation'],
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
              const Icon(Icons.check_circle, color: Colors.green, size: 28),
            if (showResult && isSelected && option != correctAnswer)
              const Icon(Icons.cancel, color: Colors.red, size: 28),
            if (showResult) const SizedBox(width: 12),
            Text(
              option,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizResults() {
    final percentage = (_score / multipleChoiceExercises.length * 100).round();
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
              color: passed ? Colors.amber : Colors.blue,
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
              'Puntuación final: $_score/${multipleChoiceExercises.length}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: passed ? Colors.green : Colors.blue,
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
                label: const Text('Reintentar Evaluación'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
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
                      content: Text('¡Lección del Verb To Be completada con éxito!'),
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
                label: const Text('Repetir Evaluación'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  side: const BorderSide(color: Colors.blue),
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
    final canGoNext = _currentStep < 3 && 
        (_currentStep != 2 || _currentExercise >= fillInExercises.length);
    
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
                      _fillInAnswers.clear();
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
                          _fillInAnswers.clear();
                        }
                        _currentStep++;
                      });
                    }
                  : null,
              icon: const Icon(Icons.arrow_forward),
              label: Text(_currentStep < 3 ? 'Siguiente' : 'Finalizar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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