import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// PANTALLA PRINCIPAL DE LISTENING
class ListeningScreen extends StatelessWidget {
  const ListeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listening Practice'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade600],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.headphones,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 32),
            const Text(
              '🎧 Listening Practice',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Card(
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Instrucciones:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '1. Escucha el audio atentamente\n'
                      '2. Solo podrás reproducirlo UNA vez\n'
                      '3. Responde las 6 preguntas\n'
                      '4. Obtén al menos 70% para aprobar',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListeningLevelsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward, size: 28),
              label: const Text(
                'Siguiente',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PANTALLA DE SELECCIÓN DE NIVELES
class ListeningLevelsScreen extends StatelessWidget {
  const ListeningLevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Level'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade600],
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose a Listening Exercise',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              _buildLevelButton(
                context,
                level: 'A2',
                title: 'David is planning a Vacation',
                color: Colors.green,
                audioPath: 'audios/david_vacation.mp3',
                questions: _getA2Questions(),
              ),
              const SizedBox(height: 16),
              _buildLevelButton(
                context,
                level: 'B1',
                title: 'Caught in a Rainstorm',
                color: Colors.blue,
                audioPath: 'audios/rainstorm.mp3',
                questions: _getB1Questions(),
              ),
              const SizedBox(height: 16),
              _buildLevelButton(
                context,
                level: 'B2',
                title: 'Bonnie and Clyde',
                color: Colors.orange,
                audioPath: 'audios/bonnie_clyde.mp3',
                questions: _getB2_1Questions(),
              ),
              const SizedBox(height: 16),
              _buildLevelButton(
                context,
                level: 'B2',
                title: 'Going to the Store',
                color: Colors.purple,
                audioPath: 'audios/going_store.mp3',
                questions: _getB2_2Questions(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelButton(
    BuildContext context, {
    required String level,
    required String title,
    required Color color,
    required String audioPath,
    required List<Map<String, dynamic>> questions,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListeningExerciseScreen(
                level: level,
                title: title,
                audioPath: audioPath,
                questions: questions,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          children: [
            Text(
              level,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // PREGUNTAS A2
  static List<Map<String, dynamic>> _getA2Questions() {
    return [
      {
        'question': 'Where did the family vacation last year?',
        'options': ['Italy', 'France', 'Florida', 'California'],
        'correct': 'Florida',
      },
      {
        'question': "What is the name of David's wife?",
        'options': ['Erin', 'Elizabeth', 'Edie', 'Emily'],
        'correct': 'Emily',
      },
      {
        'question': "How old are David's sons?",
        'options': ['Three', 'Four', 'Five', 'Their ages are not known.'],
        'correct': 'Three',
      },
      {
        'question': "In what city does David's family live?",
        'options': ['Atlantic City', 'New York', 'Atlanta', 'Miami'],
        'correct': 'Atlanta',
      },
      {
        'question': "What are the name of David's sons?",
        'options': ['Brian and Brandon', 'Brandon and Brent', 'Brandon and Brooks', 'Brian and Brent'],
        'correct': 'Brandon and Brent',
      },
      {
        'question': 'Which state is not being considered for vacation?',
        'options': ['Georgia', 'Colorado', 'California', 'Idaho'],
        'correct': 'Georgia',
      },
    ];
  }

  // PREGUNTAS B1
  static List<Map<String, dynamic>> _getB1Questions() {
    return [
      {
        'question': 'What does Alice keep forgetting?',
        'options': ['Her purse', 'Her hat', 'Her dog', 'Her umbrella'],
        'correct': 'Her umbrella',
      },
      {
        'question': 'How is Alice shielding herself from the rain?',
        'options': ['With her coat', 'With her hands', 'Under a tree', "She doesn't have a shield"],
        'correct': 'With her coat',
      },
      {
        'question': 'Who is watching Alice?',
        'options': ['The mailman', 'People with umbrellas', 'No one', "Alice's dog"],
        'correct': 'People with umbrellas',
      },
      {
        'question': 'What season is it?',
        'options': ['Summer', 'Winter', 'Spring', 'Autumn'],
        'correct': 'Spring',
      },
      {
        'question': 'What month is it?',
        'options': ['December', 'April', 'July', 'February'],
        'correct': 'April',
      },
      {
        'question': "What happened to Alice's hair?",
        'options': ['It got frizzy', 'Nothing', 'It got wet', "It's tangled"],
        'correct': 'It got wet',
      },
    ];
  }

  // PREGUNTAS B2-1
  static List<Map<String, dynamic>> _getB2_1Questions() {
    return [
      {
        'question': 'In which years were Bonnie and Clyde famous?',
        'options': ["The early 1700's", "The mid-1800's", "The early 1900's", "The mid-1900's"],
        'correct': "The early 1900's",
      },
      {
        'question': 'In which country was the couple famous?',
        'options': ['Canada', 'Germany', 'The United States of America', 'China'],
        'correct': 'The United States of America',
      },
      {
        'question': 'Why was the couple famous in the country?',
        'options': [
          'Their brutal robberies',
          'Their youth',
          'Their good looks',
          'The fact that Bonnie, a woman, performed brutal crimes'
        ],
        'correct': 'The fact that Bonnie, a woman, performed brutal crimes',
      },
      {
        'question': 'In which year was the couple apprehended?',
        'options': ['1774', '1934', '1882', '1995'],
        'correct': '1934',
      },
      {
        'question': 'When was the couple ambushed?',
        'options': [
          'As they were traveling to visit a friend',
          'As they were having lunch at a restaurant',
          'They were hiding in the forest',
          'On their way home'
        ],
        'correct': 'As they were traveling to visit a friend',
      },
      {
        'question': 'What did the officers do upon catching the criminals?',
        'options': [
          'They took them to the station',
          'They shot them dead',
          'They let them go',
          'They did not catch the criminals'
        ],
        'correct': 'They shot them dead',
      },
    ];
  }

  // PREGUNTAS B2-2
  static List<Map<String, dynamic>> _getB2_2Questions() {
    return [
      {
        'question': 'Who is the main character of the passage?',
        'options': ["Sally's husband", 'Sally', 'the narrator', 'No main character'],
        'correct': 'Sally',
      },
      {
        'question': 'Why is Sally going shopping?',
        'options': [
          'She needs new clothes for her new job.',
          'Her husband is dieting and needs healthier food.',
          'She won a shopping spree through a raffle.',
          'She has been very busy and they have been running low on food.'
        ],
        'correct': 'She has been very busy and they have been running low on food.',
      },
      {
        'question': 'Why did Sally write a grocery list?',
        'options': [
          'She is very forgetful.',
          'She was in a rush.',
          'She made it for her husband to go grocery shopping.',
          'To stick on the fridge for future use.'
        ],
        'correct': 'She is very forgetful.',
      },
      {
        'question': 'What did Sally do right before leaving her apartment?',
        'options': [
          'Get her keys from the office room',
          'Call her husband',
          'Glance around the apartment',
          "She didn't do anything."
        ],
        'correct': 'Glance around the apartment',
      },
      {
        'question': "Which one of the following snacks was NOT in Sally's pantry?",
        'options': ['Candy bars', 'Bags of chips', 'Crackers', 'Granola bars'],
        'correct': 'Granola bars',
      },
      {
        'question': 'Where did Sally find her keys in the office room?',
        'options': ['On her desk', 'Hanging on a keyholder', 'On a chair', 'Near her laptop'],
        'correct': 'On her desk',
      },
    ];
  }
}

// PANTALLA DE EJERCICIO DE LISTENING
class ListeningExerciseScreen extends StatefulWidget {
  final String level;
  final String title;
  final String audioPath;
  final List<Map<String, dynamic>> questions;

  const ListeningExerciseScreen({
    super.key,
    required this.level,
    required this.title,
    required this.audioPath,
    required this.questions,
  });

  @override
  State<ListeningExerciseScreen> createState() => _ListeningExerciseScreenState();
}

class _ListeningExerciseScreenState extends State<ListeningExerciseScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _hasPlayedAudio = false;
  bool _isPlaying = false;
  final Map<int, String> _answers = {};
  bool _showResults = false;
  int _score = 0;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio() async {
    if (_hasPlayedAudio) return;

    setState(() {
      _isPlaying = true;
    });

    await _audioPlayer.play(AssetSource(widget.audioPath));

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _hasPlayedAudio = true;
        _isPlaying = false;
      });
    });
  }

  void _submitAnswers() {
    if (_answers.length < widget.questions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor responde todas las preguntas'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    int score = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (_answers[i] == widget.questions[i]['correct']) {
        score++;
      }
    }

    setState(() {
      _score = score;
      _showResults = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showResults) {
      return _buildResultsScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.level} - ${widget.title}'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade600],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Audio Player Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 2),
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.headphones,
                  size: 60,
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _hasPlayedAudio ? null : _playAudio,
                  icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                  label: Text(
                    _hasPlayedAudio
                        ? 'Audio reproducido'
                        : _isPlaying
                            ? 'Reproduciendo...'
                            : 'Reproducir Audio',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _hasPlayedAudio ? Colors.grey : Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _hasPlayedAudio
                      ? '✓ Solo puedes escuchar el audio una vez'
                      : '⚠️ Solo podrás escucharlo UNA vez',
                  style: TextStyle(
                    fontSize: 14,
                    color: _hasPlayedAudio ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Questions Section
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.questions.length,
              itemBuilder: (context, index) {
                return _buildQuestionCard(index);
              },
            ),
          ),
          // Submit Button
          Container(
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
            child: ElevatedButton.icon(
              onPressed: _submitAnswers,
              icon: const Icon(Icons.check_circle, size: 24),
              label: const Text(
                'Enviar Respuestas',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(int index) {
    final question = widget.questions[index];
    final selectedAnswer = _answers[index];

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Pregunta ${index + 1}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              question['question'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              (question['options'] as List).length,
              (optionIndex) {
                final option = question['options'][optionIndex];
                final isSelected = selectedAnswer == option;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _answers[index] = option;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade100 : Colors.grey.shade100,
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? Colors.blue : Colors.grey,
                                width: 2,
                              ),
                              color: isSelected ? Colors.blue : Colors.white,
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    final percentage = (_score / widget.questions.length * 100).round();
    final passed = percentage >= 70;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade600],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
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
              'Puntuación: $_score/${widget.questions.length}',
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
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Respuestas:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              widget.questions.length,
              (index) {
                final question = widget.questions[index];
                final userAnswer = _answers[index];
                final correctAnswer = question['correct'];
                final isCorrect = userAnswer == correctAnswer;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isCorrect ? Icons.check_circle : Icons.cancel,
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Pregunta ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          question['question'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tu respuesta: $userAnswer',
                          style: TextStyle(
                            fontSize: 14,
                            color: isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (!isCorrect) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Respuesta correcta: $correctAnswer',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver a Niveles'),
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
}