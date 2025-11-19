import 'package:flutter/material.dart';

class VerbTenses extends StatefulWidget {
  const VerbTenses({super.key});

  @override
  State<VerbTenses> createState() => _VerbTensesState();
}

class _VerbTensesState extends State<VerbTenses> {
  int _currentStep = 0;
  int _score = 0;
  int _currentExercise = 0;
  String? _selectedAnswer;
  final Map<int, String> _practiceAnswers = {};

  // Datos de los tiempos verbales
  final List<Map<String, dynamic>> tensesData = [
    {
      'tense': 'Simple Present',
      'spanish': 'Presente Simple',
      'usage': 'Para acciones habituales, hechos y verdades generales',
      'structure': 'Subject + Verb (s/es for 3rd person)',
      'examples': [
        {'english': 'I work every day', 'spanish': 'Yo trabajo todos los días'},
        {'english': 'She studies English', 'spanish': 'Ella estudia inglés'},
        {'english': 'They play soccer', 'spanish': 'Ellos juegan fútbol'},
      ],
      'keywords': ['always', 'usually', 'often', 'every day', 'sometimes'],
      'icon': Icons.today,
      'color': Colors.blue,
    },
    {
      'tense': 'Present Continuous',
      'spanish': 'Presente Continuo',
      'usage': 'Para acciones que están sucediendo ahora',
      'structure': 'Subject + am/is/are + Verb-ing',
      'examples': [
        {'english': 'I am working now', 'spanish': 'Estoy trabajando ahora'},
        {'english': 'She is studying', 'spanish': 'Ella está estudiando'},
        {'english': 'They are playing', 'spanish': 'Ellos están jugando'},
      ],
      'keywords': ['now', 'right now', 'at the moment', 'currently'],
      'icon': Icons.play_circle,
      'color': Colors.green,
    },
    {
      'tense': 'Simple Past',
      'spanish': 'Pasado Simple',
      'usage': 'Para acciones completadas en el pasado',
      'structure': 'Subject + Verb-ed (regular) / 2nd form (irregular)',
      'examples': [
        {'english': 'I worked yesterday', 'spanish': 'Yo trabajé ayer'},
        {'english': 'She studied last night', 'spanish': 'Ella estudió anoche'},
        {'english': 'They went home', 'spanish': 'Ellos fueron a casa'},
      ],
      'keywords': ['yesterday', 'last week', 'ago', 'in 2020'],
      'icon': Icons.history,
      'color': Colors.orange,
    },
    {
      'tense': 'Simple Future',
      'spanish': 'Futuro Simple',
      'usage': 'Para acciones que sucederán en el futuro',
      'structure': 'Subject + will + Verb',
      'examples': [
        {'english': 'I will work tomorrow', 'spanish': 'Yo trabajaré mañana'},
        {'english': 'She will study tonight', 'spanish': 'Ella estudiará esta noche'},
        {'english': 'They will travel soon', 'spanish': 'Ellos viajarán pronto'},
      ],
      'keywords': ['tomorrow', 'next week', 'soon', 'in the future'],
      'icon': Icons.event,
      'color': Colors.purple,
    },
  ];

  // Ejercicios de identificación
  final List<Map<String, dynamic>> identificationExercises = [
    {
      'sentence': 'I am reading a book now',
      'options': ['Present Simple', 'Present Continuous', 'Past Simple', 'Future'],
      'correct': 'Present Continuous',
      'translation': 'Estoy leyendo un libro ahora',
      'explanation': 'Usa "am + verb-ing" y la palabra "now"',
    },
    {
      'sentence': 'She worked yesterday',
      'options': ['Present Simple', 'Present Continuous', 'Past Simple', 'Future'],
      'correct': 'Past Simple',
      'translation': 'Ella trabajó ayer',
      'explanation': 'El verbo está en pasado y usa "yesterday"',
    },
    {
      'sentence': 'They will visit Paris next year',
      'options': ['Present Simple', 'Present Continuous', 'Past Simple', 'Future'],
      'correct': 'Future',
      'translation': 'Ellos visitarán París el próximo año',
      'explanation': 'Usa "will" y la expresión "next year"',
    },
    {
      'sentence': 'We play tennis every Saturday',
      'options': ['Present Simple', 'Present Continuous', 'Past Simple', 'Future'],
      'correct': 'Present Simple',
      'translation': 'Nosotros jugamos tenis cada sábado',
      'explanation': 'Es una acción habitual con "every Saturday"',
    },
    {
      'sentence': 'He is watching TV right now',
      'options': ['Present Simple', 'Present Continuous', 'Past Simple', 'Future'],
      'correct': 'Present Continuous',
      'translation': 'Él está viendo TV en este momento',
      'explanation': 'Usa "is + verb-ing" con "right now"',
    },
  ];

  // Quiz de completar oraciones
  final List<Map<String, dynamic>> quizQuestions = [
    {
      'question': 'I ___ to school every day',
      'options': ['go', 'going', 'went', 'will go'],
      'correct': 'go',
      'tense': 'Present Simple',
      'translation': 'Yo voy a la escuela todos los días',
    },
    {
      'question': 'She ___ a movie right now',
      'options': ['watch', 'is watching', 'watched', 'will watch'],
      'correct': 'is watching',
      'tense': 'Present Continuous',
      'translation': 'Ella está viendo una película ahora',
    },
    {
      'question': 'They ___ pizza yesterday',
      'options': ['eat', 'are eating', 'ate', 'will eat'],
      'correct': 'ate',
      'tense': 'Past Simple',
      'translation': 'Ellos comieron pizza ayer',
    },
    {
      'question': 'We ___ travel to Spain next month',
      'options': ['travel', 'are traveling', 'traveled', 'will travel'],
      'correct': 'will travel',
      'tense': 'Future',
      'translation': 'Nosotros viajaremos a España el próximo mes',
    },
    {
      'question': 'He ___ English at the moment',
      'options': ['study', 'is studying', 'studied', 'will study'],
      'correct': 'is studying',
      'tense': 'Present Continuous',
      'translation': 'Él está estudiando inglés en este momento',
    },
    {
      'question': 'I ___ my homework last night',
      'options': ['do', 'am doing', 'did', 'will do'],
      'correct': 'did',
      'tense': 'Past Simple',
      'translation': 'Yo hice mi tarea anoche',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verb Tenses'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade400, Colors.teal.shade600],
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
      color: Colors.teal.shade50,
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
                  color: Colors.teal.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (_currentStep + 1) / 4,
            backgroundColor: Colors.grey.shade300,
            color: Colors.teal,
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
        return 'Comparación';
      case 2:
        return 'Identificación';
      case 3:
        return 'Quiz Final';
      default:
        return '';
    }
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildTheorySection();
      case 1:
        return _buildComparisonSection();
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
          color: const Color(0xFFE0F2F1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.school, color: Colors.teal, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Tiempos Verbales en Inglés',
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
                  'Los tiempos verbales nos ayudan a expresar CUÁNDO ocurre una acción: '
                  'en el presente, pasado o futuro. Cada tiempo tiene su propia estructura y uso.',
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
        ...tensesData.map((tense) => _buildTenseCard(tense)),
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
                      '💡 Tips importantes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '• Las palabras clave te ayudan a identificar el tiempo\n'
                  '• Present Continuous usa "-ing" al final del verbo\n'
                  '• Past Simple: verbos regulares terminan en "-ed"\n'
                  '• Future Simple siempre usa "will" antes del verbo',
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

  Widget _buildTenseCard(Map<String, dynamic> tense) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
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
                    color: (tense['color'] as Color).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    tense['icon'],
                    color: tense['color'],
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tense['tense'],
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: tense['color'],
                        ),
                      ),
                      Text(
                        tense['spanish'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          tense['usage'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.architecture, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          tense['structure'],
                          style: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Ejemplos:',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...(tense['examples'] as List).map((example) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (tense['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: (tense['color'] as Color).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle,
                                size: 16, color: tense['color']),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                example['english'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Text(
                            example['spanish'],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (tense['keywords'] as List<String>)
                  .map((keyword) => Chip(
                        label: Text(
                          keyword,
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor:
                            (tense['color'] as Color).withOpacity(0.2),
                        side: BorderSide.none,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  // SECCIÓN 2: COMPARACIÓN
  Widget _buildComparisonSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          color: Color(0xFFE3F2FD),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.compare_arrows, color: Colors.blue),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Comparación de Tiempos Verbales',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildComparisonTable(),
        const SizedBox(height: 20),
        const Text(
          'Mismo verbo en diferentes tiempos:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildVerbComparison('work', 'trabajar'),
        _buildVerbComparison('study', 'estudiar'),
        _buildVerbComparison('play', 'jugar'),
      ],
    );
  }

  Widget _buildComparisonTable() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
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
                    'Tiempo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Cuándo usarlo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Palabra clave',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          _buildTableRow('Present', 'Acciones habituales', 'every day', Colors.blue),
          _buildTableRow('Present Cont.', 'Ahora mismo', 'now', Colors.green),
          _buildTableRow('Past', 'Completado', 'yesterday', Colors.orange),
          _buildTableRow('Future', 'Va a pasar', 'tomorrow', Colors.purple),
        ],
      ),
    );
  }

  Widget _buildTableRow(String tense, String when, String keyword, Color color) {
    return Container(
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
              tense,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              when,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                keyword,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerbComparison(String verb, String spanish) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$verb ($spanish)',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildTenseExample(Icons.today, 'Present', 'I $verb', Colors.blue),
            _buildTenseExample(Icons.play_circle, 'Present Continuous',
                'I am ${verb}ing', Colors.green),
            _buildTenseExample(
                Icons.history, 'Past', 'I ${verb}ed', Colors.orange),
            _buildTenseExample(
                Icons.event, 'Future', 'I will $verb', Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildTenseExample(
      IconData icon, String tense, String example, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              tense,
              style: TextStyle(
                fontSize: 13,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              example,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SECCIÓN 3: PRÁCTICA (Identificación)
  Widget _buildPracticeSection() {
    if (_currentExercise >= identificationExercises.length) {
      return _buildPracticeResults();
    }

    final exercise = identificationExercises[_currentExercise];

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
                    'Ejercicio ${_currentExercise + 1} de ${identificationExercises.length}',
                    style: TextStyle(
                      color: Colors.amber.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Identifica el tiempo verbal',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _currentExercise / identificationExercises.length,
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
                  const Icon(Icons.help_outline, size: 40, color: Colors.teal),
                  const SizedBox(height: 16),
                  Text(
                    exercise['sentence'],
                    style: const TextStyle(
                      fontSize: 22,
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
            '¿Qué tiempo verbal es?',
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
                exercise['explanation'],
                _currentExercise,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPracticeOption(
      String option, String correctAnswer, String explanation, int exerciseIndex) {
    final selectedAnswer = _practiceAnswers[exerciseIndex];
    final isSelected = selectedAnswer == option;
    final showResult = selectedAnswer != null;
    final isCorrect = option == correctAnswer;

    Color getColor() {
      if (!showResult) return Colors.white;
      if (isSelected) {
        return isCorrect ? Colors.green.shade100 : Colors.red.shade100;
      }
      if (isCorrect) return Colors.green.shade100;
      return Colors.white;
    }

    Color getBorderColor() {
      if (!showResult) return Colors.teal.shade200;
      if (isSelected) {
        return isCorrect ? Colors.green : Colors.red;
      }
      if (isCorrect) return Colors.green;
      return Colors.grey.shade300;
    }

    return Column(
      children: [
        InkWell(
          onTap: selectedAnswer == null
              ? () {
                  setState(() {
                    _practiceAnswers[exerciseIndex] = option;
                    if (isCorrect) {
                      _score++;
                    }
                  });
                  Future.delayed(const Duration(milliseconds: 2000), () {
                    if (mounted) {
                      setState(() {
                        _currentExercise++;
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showResult && isCorrect)
                  const Icon(Icons.check_circle, color: Colors.green, size: 24),
                if (showResult && isSelected && !isCorrect)
                  const Icon(Icons.cancel, color: Colors.red, size: 24),
                if (showResult) const SizedBox(width: 12),
                Text(
                  option,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showResult && isCorrect)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                const Icon(Icons.info, size: 16, color: Colors.green),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    explanation,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPracticeResults() {
    final percentage = (_score / identificationExercises.length * 100).round();

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
                'Respuestas correctas: $_score/${identificationExercises.length}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade600,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _currentExercise = 0;
                    _score = 0;
                    _practiceAnswers.clear();
                  });
                },
                icon: const Icon(Icons.replay),
                label: const Text('Practicar de Nuevo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
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
            color: Colors.teal.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: Colors.teal.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Tiempo: ${question['tense']}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text(
                    'Completa la oración:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    question['question'],
                    style: const TextStyle(
                      fontSize: 24,
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
    final isCorrect = option == correctAnswer;

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
                if (isCorrect) {
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
            if (showResult && isCorrect)
              const Icon(Icons.check_circle, color: Colors.green, size: 28),
            if (showResult && isSelected && !isCorrect)
              const Icon(Icons.cancel, color: Colors.red, size: 28),
            if (showResult) const SizedBox(width: 12),
            Text(
              option,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
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
                color: passed ? Colors.amber : Colors.teal,
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
                  color: passed ? Colors.green : Colors.teal,
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
                    backgroundColor: Colors.teal,
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
                        content: Text('¡Lección de Verb Tenses completada!'),
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
                    foregroundColor: Colors.teal,
                    side: const BorderSide(color: Colors.teal),
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
        (_currentStep != 2 || _currentExercise >= identificationExercises.length);

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
                      _practiceAnswers.clear();
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
                          _practiceAnswers.clear();
                        }
                        _currentStep++;
                      });
                    }
                  : null,
              icon: const Icon(Icons.arrow_forward),
              label: Text(_currentStep < 3 ? 'Siguiente' : 'Finalizar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
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