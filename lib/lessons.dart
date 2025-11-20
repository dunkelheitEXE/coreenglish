import 'package:coreenglish/lessons/intermediate/phrasal.dart';
import 'package:coreenglish/lessons/intermediate/prepositions.dart';
import 'package:flutter/material.dart';
import 'lessons/basic/greetings.dart';
import 'lessons/basic/verbtobe.dart';
import 'lessons/basic/personalPronouns.dart';
import 'lessons/intermediate/verbTenses.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade400, Colors.orange.shade600],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Basic Level Section
            const SectionHeader(title: 'Basic Level', icon: Icons.star),
            const SizedBox(height: 10),
            LessonCard(
              lessonNumber: 1,
              title: 'Greetings and Farewells',
              description: 'Hello, Goodbye, Good morning...',
              progress: 0.0,
              isLocked: false,
              onTap: () => _showLessonDetail(
                context,
                'Greetings and Farewells',
                lessonType: LessonType.greetings,
              ),
            ),
            LessonCard(
              lessonNumber: 2,
              title: 'Personal Pronouns',
              description: 'I, You, He, She, It, We, They',
              progress: 0.0,
              isLocked: false,
              onTap: () => _showLessonDetail(
                context,
                'Personal Pronouns',
                lessonType: LessonType.pronouns,
              ),
            ),
            LessonCard(
              lessonNumber: 3,
              title: 'Verb To Be',
              description: 'Am, Is, Are - Simple present',
              progress: 0.0,
              isLocked: false, // ✅ Desbloqueado
              onTap: () => _showLessonDetail(
                context,
                'Verb To Be',
                lessonType: LessonType.verbToBe,
              ),
            ),

            const SizedBox(height: 20),

            // Intermediate Level Section
            const SectionHeader(
                title: 'Intermediate Level', icon: Icons.trending_up),
            const SizedBox(height: 10),
            LessonCard(
              lessonNumber: 4,
              title: 'Verb Tenses',
              description: 'Present, Past, Future',
              progress: 0.0,
              isLocked: false, // ✅ Desbloqueado
              onTap: () => _showLessonDetail(
                context,
                'Verb Tenses',
                lessonType: LessonType.verbTenses,
              ),
            ),
            LessonCard(
              lessonNumber: 5,
              title: 'Prepositions',
              description: 'In, On, At, Under, Between...',
              progress: 0.0,
              isLocked: false, // ✅ Desbloqueado
              onTap: () => _showLessonDetail(
                context,
                'Prepositions',
                lessonType: LessonType.prepositions,
              ),
            ),

            const SizedBox(height: 20),

            // Advanced Level Section
            const SectionHeader(
                title: 'Advanced Level', icon: Icons.emoji_events),
            const SizedBox(height: 10),
            LessonCard(
              lessonNumber: 6,
              title: 'Phrasal Verbs',
              description: 'Give up, Look for, Take off...',
              progress: 0.0,
              isLocked: false, // ✅ Desbloqueado
              onTap: () => _showLessonDetail(
                context,
                'Phrasal Verbs',
                lessonType: LessonType.phrasalVerbs,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _showLessonDetail(
    BuildContext context,
    String lessonTitle, {
    LessonType? lessonType,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(lessonTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.play_circle_outline,
                size: 60, color: Colors.orange),
            const SizedBox(height: 20),
            const Text(
              'Ready to start!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'This lesson includes:\n• Explanation\n• Exercises\n• Final quiz',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo

              // Navega a la página correspondiente según la lección
              if (lessonType != null) {
                _navigateToLesson(context, lessonType);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }

  static void _navigateToLesson(BuildContext context, LessonType lessonType) {
    Widget? lessonPage;

    switch (lessonType) {
      case LessonType.greetings:
        lessonPage = const Greetings();
        break;

      case LessonType.pronouns:
        lessonPage = const PersonalPronouns();
        break;

      case LessonType.verbToBe:
        lessonPage = const VerbToBe(); // ✅ Navegación agregada
        break;

      case LessonType.verbTenses:
        lessonPage = const VerbTenses();
        break;

      case LessonType.prepositions:
        lessonPage = const Prepositions();
        break;

      case LessonType.phrasalVerbs:
        lessonPage = const PhrasalVerbs();
        break;
    }

    if (lessonPage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => lessonPage!),
      );
    }
  }
}

// Enum para identificar las lecciones
enum LessonType {
  greetings,
  pronouns,
  verbToBe,
  verbTenses,
  prepositions,
  phrasalVerbs,
}

// Widgets auxiliares
class SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionHeader({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class LessonCard extends StatelessWidget {
  final int lessonNumber;
  final String title;
  final String description;
  final double progress;
  final bool isLocked;
  final VoidCallback onTap;

  const LessonCard({
    Key? key,
    required this.lessonNumber,
    required this.title,
    required this.description,
    required this.progress,
    required this.isLocked,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: isLocked ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: isLocked ? Colors.grey : Colors.orange,
                child: isLocked
                    ? const Icon(Icons.lock, color: Colors.white)
                    : Text('$lessonNumber',
                        style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isLocked ? Colors.grey : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: isLocked ? Colors.grey : Colors.grey.shade600,
                      ),
                    ),
                    if (!isLocked && progress > 0) ...[
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.orange,
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                isLocked ? Icons.lock : Icons.arrow_forward_ios,
                color: isLocked ? Colors.grey : Colors.orange,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}