import 'package:flutter/material.dart';

class PhrasalVerbs extends StatefulWidget {
  const PhrasalVerbs({super.key});

  @override
  State<PhrasalVerbs> createState() => _PhrasalVerbsState();
}

class _PhrasalVerbsState extends State<PhrasalVerbs> {
  int _currentStep = 0;
  int _score = 0;
  int _currentExercise = 0;
  String? _selectedAnswer;
  final Map<int, String> _practiceAnswers = {};

  // Datos de Phrasal Verbs
  final List<Map<String, dynamic>> phrasalVerbsData = [
    {
      'phrasalVerb': 'Give up',
      'spanish': 'Rendirse, Dejar de hacer algo',
      'usage': 'Cuando abandonas una actividad o dejas de intentar algo',
      'examples': [
        'I will never give up learning English',
        'He gave up smoking last year',
        'Don\'t give up on your dreams'
      ],
      'examplesSpanish': [
        'Nunca me rendiré aprendiendo inglés',
        'Él dejó de fumar el año pasado',
        'No te rindas en tus sueños'
      ],
      'icon': Icons.flag,
      'color': Colors.red,
    },
    {
      'phrasalVerb': 'Look for',
      'spanish': 'Buscar',
      'usage': 'Cuando intentas encontrar algo o alguien',
      'examples': [
        'I am looking for my keys',
        'She is looking for a new job',
        'We looked for the restaurant for hours'
      ],
      'examplesSpanish': [
        'Estoy buscando mis llaves',
        'Ella está buscando un nuevo trabajo',
        'Buscamos el restaurante por horas'
      ],
      'icon': Icons.search,
      'color': Colors.blue,
    },
    {
      'phrasalVerb': 'Turn on',
      'spanish': 'Encender, Activar',
      'usage': 'Cuando activas un dispositivo o máquina',
      'examples': [
        'Can you turn on the light?',
        'I turned on the TV to watch the news',
        'Turn on the computer, please'
      ],
      'examplesSpanish': [
        '¿Puedes encender la luz?',
        'Encendí la TV para ver las noticias',
        'Enciende la computadora, por favor'
      ],
      'icon': Icons.power,
      'color': Colors.green,
    },
    {
      'phrasalVerb': 'Turn off',
      'spanish': 'Apagar, Desactivar',
      'usage': 'Cuando desactivas un dispositivo o máquina',
      'examples': [
        'Please turn off your phone',
        'Don\'t forget to turn off the lights',
        'I turned off the engine'
      ],
      'examplesSpanish': [
        'Por favor apaga tu teléfono',
        'No olvides apagar las luces',
        'Apagué el motor'
      ],
      'icon': Icons.power_off,
      'color': Colors.orange,
    },
    {
      'phrasalVerb': 'Get up',
      'spanish': 'Levantarse',
      'usage': 'Cuando te levantas de la cama o de una silla',
      'examples': [
        'I get up at 7 AM every day',
        'She got up from the chair slowly',
        'Get up, it\'s time for school'
      ],
      'examplesSpanish': [
        'Me levanto a las 7 AM todos los días',
        'Ella se levantó de la silla lentamente',
        'Levántate, es hora de la escuela'
      ],
      'icon': Icons.directions_walk,
      'color': Colors.purple,
    },
    {
      'phrasalVerb': 'Wake up',
      'spanish': 'Despertarse',
      'usage': 'Cuando dejas de dormir y abres los ojos',
      'examples': [
        'I wake up early on weekdays',
        'The alarm clock wakes me up at 6 AM',
        'She woke up suddenly'
      ],
      'examplesSpanish': [
        'Me despierto temprano entre semana',
        'El despertador me despierta a las 6 AM',
        'Ella se despertó repentinamente'
      ],
      'icon': Icons.alarm,
      'color': Colors.teal,
    },
    {
      'phrasalVerb': 'Look forward to',
      'spanish': 'Tener ganas de, Esperar con ansias',
      'usage': 'Cuando estás emocionado por algo que va a pasar',
      'examples': [
        'I look forward to seeing you',
        'We are looking forward to the vacation',
        'He looked forward to his birthday'
      ],
      'examplesSpanish': [
        'Tengo ganas de verte',
        'Estamos ansiosos por las vacaciones',
        'Él esperaba con ansias su cumpleaños'
      ],
      'icon': Icons.emoji_events,
      'color': Colors.amber,
    },
    {
      'phrasalVerb': 'Run out of',
      'spanish': 'Quedarse sin',
      'usage': 'Cuando se te acaba el suministro de algo',
      'examples': [
        'We ran out of milk',
        'Don\'t run out of battery',
        'I ran out of ideas'
      ],
      'examplesSpanish': [
        'Se nos acabó la leche',
        'No te quedes sin batería',
        'Se me acabaron las ideas'
      ],
      'icon': Icons.battery_alert,
      'color': Colors.deepOrange,
    },
    {
      'phrasalVerb': 'Take off',
      'spanish': 'Despegar, Quitarse',
      'usage': 'Cuando un avión despega o te quitas la ropa',
      'examples': [
        'The plane takes off at 3 PM',
        'Take off your shoes, please',
        'He took off his jacket'
      ],
      'examplesSpanish': [
        'El avión despega a las 3 PM',
        'Quítate los zapatos, por favor',
        'Él se quitó la chaqueta'
      ],
      'icon': Icons.flight_takeoff,
      'color': Colors.indigo,
    },
    {
      'phrasalVerb': 'Put on',
      'spanish': 'Ponerse',
      'usage': 'Cuando te vistes con alguna prenda',
      'examples': [
        'Put on your coat, it\'s cold',
        'She put on her glasses to read',
        'I need to put on my uniform'
      ],
      'examplesSpanish': [
        'Ponte tu abrigo, hace frío',
        'Ella se puso sus lentes para leer',
        'Necesito ponerme mi uniforme'
      ],
      'icon': Icons.checkroom,
      'color': Colors.brown,
    },
  ];

  // Ejercicios de práctica
  final List<Map<String, dynamic>> practiceExercises = [
    {
      'sentence': 'I need to ___ smoking for my health',
      'correct': 'give up',
      'options': ['give up', 'look for', 'turn on', 'get up'],
      'translation': 'Necesito dejar de fumar por mi salud',
    },
    {
      'sentence': 'Can you ___ the lights? It\'s too dark',
      'correct': 'turn on',
      'options': ['turn on', 'turn off', 'wake up', 'put on'],
      'translation': '¿Puedes encender las luces? Está muy oscuro',
    },
    {
      'sentence': 'I ___ my keys everywhere but I can\'t find them',
      'correct': 'look for',
      'options': ['look for', 'give up', 'run out of', 'take off'],
      'translation': 'Busco mis llaves por todas partes pero no las encuentro',
    },
    {
      'sentence': 'We ___ milk, can you buy some?',
      'correct': 'ran out of',
      'options': ['ran out of', 'looked for', 'gave up', 'took off'],
      'translation': 'Se nos acabó la leche, ¿puedes comprar?',
    },
    {
      'sentence': 'I usually ___ at 6 AM on weekdays',
      'correct': 'get up',
      'options': ['get up', 'wake up', 'turn on', 'put on'],
      'translation': 'Normalmente me levanto a las 6 AM entre semana',
    },
    {
      'sentence': 'Don\'t forget to ___ the TV before sleeping',
      'correct': 'turn off',
      'options': ['turn off', 'turn on', 'take off', 'put on'],
      'translation': 'No olvides apagar la TV antes de dormir',
    },
    {
      'sentence': 'I ___ seeing my family at Christmas',
      'correct': 'look forward to',
      'options': ['look forward to', 'run out of', 'give up', 'get up'],
      'translation': 'Tengo ganas de ver a mi familia en Navidad',
    },
    {
      'sentence': 'The plane will ___ in 10 minutes',
      'correct': 'take off',
      'options': ['take off', 'get up', 'wake up', 'turn on'],
      'translation': 'El avión despegará en 10 minutos',
    },
  ];

  // Quiz final
  final List<Map<String, dynamic>> quizExercises = [
    {
      'question': 'When you stop trying to do something, you ___',
      'options': ['give up', 'look for', 'turn on', 'get up'],
      'correct': 'give up',
      'translation': 'Cuando dejas de intentar hacer algo, te rindes',
    },
    {
      'question': 'When you try to find something, you ___ it',
      'options': ['look for', 'give up', 'turn off', 'wake up'],
      'correct': 'look for',
      'translation': 'Cuando intentas encontrar algo, lo buscas',
    },
    {
      'question': 'When a plane leaves the ground, it ___',
      'options': ['takes off', 'gets up', 'wakes up', 'turns on'],
      'correct': 'takes off',
      'translation': 'Cuando un avión deja el suelo, despega',
    },
    {
      'question': 'When you have no more of something, you ___ it',
      'options': ['run out of', 'look for', 'give up', 'turn on'],
      'correct': 'run out of',
      'translation': 'Cuando no tienes más de algo, se te acaba',
    },
    {
      'question': 'When you are excited about something future, you ___ it',
      'options': ['look forward to', 'run out of', 'give up', 'take off'],
      'correct': 'look forward to',
      'translation': 'Cuando estás emocionado por algo futuro, lo esperas con ansias',
    },
    {
      'question': 'When you leave your bed in the morning, you ___',
      'options': ['get up', 'wake up', 'turn on', 'put on'],
      'correct': 'get up',
      'translation': 'Cuando dejas tu cama en la mañana, te levantas',
    },
    {
      'question': 'When you stop sleeping and open your eyes, you ___',
      'options': ['wake up', 'get up', 'turn on', 'look for'],
      'correct': 'wake up',
      'translation': 'Cuando dejas de dormir y abres los ojos, te despiertas',
    },
    {
      'question': 'When you start using an electronic device, you ___ it',
      'options': ['turn on', 'turn off', 'take off', 'give up'],
      'correct': 'turn on',
      'translation': 'Cuando empiezas a usar un dispositivo electrónico, lo enciendes',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phrasal Verbs'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.indigo.shade600],
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
      color: Colors.indigo.shade50,
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
                  color: Colors.indigo.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (_currentStep + 1) / 4,
            backgroundColor: Colors.grey.shade300,
            color: Colors.indigo,
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
          color: const Color(0xFFE8EAF6),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.school, color: Colors.indigo, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '¿Qué son los Phrasal Verbs?',
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
                  'Los Phrasal Verbs son verbos compuestos formados por un verbo principal '
                  'más una partícula (preposición o adverbio). Juntos crean un significado '
                  'diferente al del verbo original.',
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
          'Phrasal Verbs Comunes:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildPhrasalVerbsTable(),
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
                      '💡 Características importantes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '• Pueden ser separables o inseparables\n'
                  '• Algunos aceptan objeto, otros no\n'
                  '• El significado es idiomático (no literal)\n'
                  '• Son muy comunes en inglés conversacional',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          color: const Color(0xFFE3F2FD),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.warning, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      '📝 Tipos de Phrasal Verbs',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Separables: El objeto puede ir entre el verbo y la partícula\n'
                  '• "Turn on the light" o "Turn the light on"\n\n'
                  'Inseparables: El objeto va después de la partícula\n'
                  '• "Look for my keys" (no "Look my keys for")',
                  style: TextStyle(
                    fontSize: 14,
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

  Widget _buildPhrasalVerbsTable() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.indigo.shade100,
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
                    'Phrasal Verb',
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
          ...phrasalVerbsData.map((item) => Container(
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
                        item['phrasalVerb'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
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
                    'Ejemplos en contexto',
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
        ...phrasalVerbsData.map((item) => _buildExampleCard(item)),
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
                        item['phrasalVerb'],
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
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.record_voice_over,
                            size: 16, color: Colors.indigo),
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
                    'Completa la oración con el phrasal verb correcto',
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
            'Selecciona el phrasal verb correcto:',
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
              option,
              style: const TextStyle(
                fontSize: 18,
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
                color: Colors.indigo.shade600,
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
                backgroundColor: Colors.indigo,
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

  // SECCIÓN 4: EVALUACIÓN
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
                    'Selecciona el phrasal verb correcto:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    question['question'],
                    style: const TextStyle(
                      fontSize: 22,
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
              color: passed ? Colors.amber : Colors.indigo,
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
                color: passed ? Colors.green : Colors.indigo,
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
                  backgroundColor: Colors.indigo,
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
                      content: Text('¡Lección de Phrasal Verbs completada con éxito!'),
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
                  foregroundColor: Colors.indigo,
                  side: const BorderSide(color: Colors.indigo),
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
                backgroundColor: Colors.indigo,
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