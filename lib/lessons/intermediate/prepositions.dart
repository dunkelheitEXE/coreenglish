import 'package:flutter/material.dart';

class Prepositions extends StatefulWidget {
  const Prepositions({super.key});

  @override
  State<Prepositions> createState() => _PrepositionsState();
}

class _PrepositionsState extends State<Prepositions> {
  int _currentStep = 0;
  int _score = 0;
  int _currentExercise = 0;
  String? _selectedAnswer;
  final Map<int, String> _practiceAnswers = {};

  // Datos de preposiciones - Estructura similar a VerbToBe
  final List<Map<String, dynamic>> prepositionsData = [
    {
      'preposition': 'IN',
      'spanish': 'En, Dentro de',
      'usage': 'Espacios cerrados, ciudades, países, meses, años',
      'examples': [
        'The book is in the box',
        'I live in Mexico',
        'My birthday is in May'
      ],
      'examplesSpanish': [
        'El libro está en la caja',
        'Yo vivo en México',
        'Mi cumpleaños es en mayo'
      ],
      'icon': Icons.inbox,
      'color': Colors.blue,
    },
    {
      'preposition': 'ON',
      'spanish': 'En, Sobre',
      'usage': 'Superficies, días específicos, fechas',
      'examples': [
        'The cup is on the table',
        'My exam is on Monday',
        'I was born on July 15th'
      ],
      'examplesSpanish': [
        'La taza está sobre la mesa',
        'Mi examen es el lunes',
        'Nací el 15 de julio'
      ],
      'icon': Icons.table_restaurant,
      'color': Colors.green,
    },
    {
      'preposition': 'AT',
      'spanish': 'En, A',
      'usage': 'Lugares específicos, horas, direcciones',
      'examples': [
        'I am at school',
        'The meeting is at 3 PM',
        'She lives at 123 Main Street'
      ],
      'examplesSpanish': [
        'Estoy en la escuela',
        'La reunión es a las 3 PM',
        'Ella vive en Main Street 123'
      ],
      'icon': Icons.location_on,
      'color': Colors.red,
    },
    {
      'preposition': 'UNDER',
      'spanish': 'Debajo de',
      'usage': 'Posición inferior a algo',
      'examples': [
        'The cat is under the table',
        'My shoes are under the bed'
      ],
      'examplesSpanish': [
        'El gato está debajo de la mesa',
        'Mis zapatos están debajo de la cama'
      ],
      'icon': Icons.arrow_downward,
      'color': Colors.brown,
    },
    {
      'preposition': 'OVER / ABOVE',
      'spanish': 'Sobre, Encima de',
      'usage': 'Posición superior a algo',
      'examples': [
        'The lamp is over the table',
        'Birds fly above the trees'
      ],
      'examplesSpanish': [
        'La lámpara está sobre la mesa',
        'Los pájaros vuelan sobre los árboles'
      ],
      'icon': Icons.arrow_upward,
      'color': Colors.lightBlue,
    },
    {
      'preposition': 'BETWEEN',
      'spanish': 'Entre (dos cosas)',
      'usage': 'Posición en medio de dos elementos',
      'examples': [
        'The park is between the school and the mall',
        'I sit between John and Mary'
      ],
      'examplesSpanish': [
        'El parque está entre la escuela y el centro comercial',
        'Me siento entre John y Mary'
      ],
      'icon': Icons.compare_arrows,
      'color': Colors.purple,
    },
    {
      'preposition': 'BEHIND',
      'spanish': 'Detrás de',
      'usage': 'Posición trasera a algo',
      'examples': [
        'The car is behind the house',
        'Hide behind the door'
      ],
      'examplesSpanish': [
        'El auto está detrás de la casa',
        'Escóndete detrás de la puerta'
      ],
      'icon': Icons.arrow_back,
      'color': Colors.indigo,
    },
    {
      'preposition': 'IN FRONT OF',
      'spanish': 'En frente de',
      'usage': 'Posición frontal a algo',
      'examples': [
        'The car is in front of the house',
        'Stand in front of the mirror'
      ],
      'examplesSpanish': [
        'El auto está en frente de la casa',
        'Párate en frente del espejo'
      ],
      'icon': Icons.arrow_forward,
      'color': Colors.orange,
    },
    {
      'preposition': 'NEXT TO / BESIDE',
      'spanish': 'Al lado de',
      'usage': 'Posición lateral a algo',
      'examples': [
        'The bank is next to the supermarket',
        'Sit beside me'
      ],
      'examplesSpanish': [
        'El banco está al lado del supermercado',
        'Siéntate a mi lado'
      ],
      'icon': Icons.compare,
      'color': Colors.teal,
    },
  ];

  // Ejercicios de práctica (llenar espacios) - Combinados lugar y tiempo
  final List<Map<String, dynamic>> practiceExercises = [
    {
      'sentence': 'The keys are ___ the drawer',
      'correct': 'in',
      'options': ['in', 'on', 'at', 'under'],
      'translation': 'Las llaves están en el cajón',
    },
    {
      'sentence': 'The picture is ___ the wall',
      'correct': 'on',
      'options': ['in', 'on', 'at', 'behind'],
      'translation': 'El cuadro está en la pared',
    },
    {
      'sentence': 'I am waiting ___ the bus stop',
      'correct': 'at',
      'options': ['in', 'on', 'at', 'between'],
      'translation': 'Estoy esperando en la parada de autobús',
    },
    {
      'sentence': 'The dog is sleeping ___ the bed',
      'correct': 'under',
      'options': ['in', 'on', 'under', 'between'],
      'translation': 'El perro está durmiendo debajo de la cama',
    },
    {
      'sentence': 'The restaurant is ___ the cinema and the bank',
      'correct': 'between',
      'options': ['in', 'on', 'at', 'between'],
      'translation': 'El restaurante está entre el cine y el banco',
    },
    {
      'sentence': 'The party is ___ Saturday',
      'correct': 'on',
      'options': ['in', 'on', 'at'],
      'translation': 'La fiesta es el sábado',
    },
    {
      'sentence': 'I wake up ___ 7 AM',
      'correct': 'at',
      'options': ['in', 'on', 'at'],
      'translation': 'Me despierto a las 7 AM',
    },
    {
      'sentence': 'School starts ___ September',
      'correct': 'in',
      'options': ['in', 'on', 'at'],
      'translation': 'La escuela empieza en septiembre',
    },
  ];

  // Quiz final (opción múltiple)
  final List<Map<String, dynamic>> quizExercises = [
    {
      'question': 'The book is ___ the shelf',
      'options': ['in', 'on', 'at', 'under'],
      'correct': 'on',
      'translation': 'El libro está en el estante',
    },
    {
      'question': 'We arrived ___ midnight',
      'options': ['in', 'on', 'at', 'between'],
      'correct': 'at',
      'translation': 'Llegamos a medianoche',
    },
    {
      'question': 'She lives ___ Paris',
      'options': ['in', 'on', 'at', 'behind'],
      'correct': 'in',
      'translation': 'Ella vive en París',
    },
    {
      'question': 'The cat jumped ___ the fence',
      'options': ['in', 'on', 'over', 'at'],
      'correct': 'over',
      'translation': 'El gato saltó sobre la cerca',
    },
    {
      'question': 'My birthday is ___ December 25th',
      'options': ['in', 'on', 'at', 'between'],
      'correct': 'on',
      'translation': 'Mi cumpleaños es el 25 de diciembre',
    },
    {
      'question': 'The café is ___ the library',
      'options': ['next to', 'in', 'at', 'on'],
      'correct': 'next to',
      'translation': 'El café está al lado de la biblioteca',
    },
    {
      'question': 'The ball is ___ the box',
      'options': ['in', 'on', 'at', 'between'],
      'correct': 'in',
      'translation': 'La pelota está en la caja',
    },
    {
      'question': 'I was born ___ 1995',
      'options': ['in', 'on', 'at', 'between'],
      'correct': 'in',
      'translation': 'Nací en 1995',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prepositions'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange.shade400, Colors.deepOrange.shade600],
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
      color: Colors.deepOrange.shade50,
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
                  color: Colors.deepOrange.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (_currentStep + 1) / 4,
            backgroundColor: Colors.grey.shade300,
            color: Colors.deepOrange,
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
          color: const Color(0xFFFFF3E0),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.school, color: Colors.deepOrange, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '¿Qué son las Preposiciones?',
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
                  'Las preposiciones son palabras que conectan elementos y muestran la relación '
                  'entre ellos, especialmente de LUGAR, TIEMPO y DIRECCIÓN.',
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
          'Preposiciones Principales:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildPrepositionsTable(),
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
                      '💡 Regla de oro',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'IN - ON - AT para tiempo:\n'
                  '• IN → meses, años, estaciones (in July, in 2023)\n'
                  '• ON → días específicos, fechas (on Monday, on May 5th)\n'
                  '• AT → horas exactas (at 3 PM, at noon)',
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

  Widget _buildPrepositionsTable() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade100,
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
                    'Preposición',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Significado',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'Uso',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ...prepositionsData.map((item) => Container(
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
                        item['preposition'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
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
                    Expanded(
                      flex: 4,
                      child: Text(
                        item['usage'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
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
        ...prepositionsData.map((item) => _buildExampleCard(item)),
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
                    color: item['color'].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(item['icon'], size: 18, color: item['color']),
                      const SizedBox(width: 6),
                      Text(
                        item['preposition'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: item['color'],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item['spanish'],
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...List.generate(
              (item['examples'] as List).length,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.record_voice_over,
                            size: 16, color: Colors.deepOrange),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item['examples'][index],
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
                            item['examplesSpanish'][index],
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
            ),
          ],
        ),
      ),
    );
  }

  // SECCIÓN 3: PRÁCTICA
  Widget _buildPracticeSection() {
    if (_currentExercise >= practiceExercises.length) {
      return _buildPracticeResults();
    }

    final exercise = practiceExercises[_currentExercise];

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
                    'Ejercicio ${_currentExercise + 1} de ${practiceExercises.length}',
                    style: TextStyle(
                      color: Colors.purple.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Completa la oración con la preposición correcta',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _currentExercise / practiceExercises.length,
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
            'Selecciona la preposición correcta:',
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
    final selectedAnswer = _practiceAnswers[exerciseIndex];
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
                _practiceAnswers[exerciseIndex] = option;
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
              option.toUpperCase(),
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
    final percentage = (_score / practiceExercises.length * 100).round();

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
              'Respuestas correctas: $_score/${practiceExercises.length}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade600,
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
                backgroundColor: Colors.deepOrange,
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

  // SECCIÓN 4: EVALUACIÓN (QUIZ)
  Widget _buildQuizSection() {
    if (_currentExercise >= quizExercises.length) {
      return _buildQuizResults();
    }

    final question = quizExercises[_currentExercise];

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
                    'Pregunta ${_currentExercise + 1} de ${quizExercises.length}',
                    style: TextStyle(
                      color: Colors.amber.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _currentExercise / quizExercises.length,
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
              option.toUpperCase(),
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
    final percentage = (_score / quizExercises.length * 100).round();
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
              color: passed ? Colors.amber : Colors.deepOrange,
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
              'Puntuación final: $_score/${quizExercises.length}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: passed ? Colors.green : Colors.deepOrange,
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
                  backgroundColor: Colors.deepOrange,
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
                      content: Text('¡Lección de Preposiciones completada con éxito!'),
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
                  foregroundColor: Colors.deepOrange,
                  side: const BorderSide(color: Colors.deepOrange),
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
        (_currentStep != 2 || _currentExercise >= practiceExercises.length);
    
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
                backgroundColor: Colors.deepOrange,
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