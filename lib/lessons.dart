import 'package:flutter/material.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({Key? key}) : super(key: key);

  void grettings() {}

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
              onTap: () => _showLessonDetail(context, 'Greetings and Farewells'),
            ),
            LessonCard(
              lessonNumber: 2,
              title: 'Personal Pronouns',
              description: 'I, You, He, She, It, We, They',
              progress: 0.0,
              isLocked: false,
              onTap: () => _showLessonDetail(context, 'Personal Pronouns'),
            ),
            LessonCard(
              lessonNumber: 3,
              title: 'Verb To Be',
              description: 'Am, Is, Are - Simple present',
              progress: 0.0,
              isLocked: true,
              onTap: () {},
            ),
            
            const SizedBox(height: 20),
            
            // Intermediate Level Section
            const SectionHeader(title: 'Intermediate Level', icon: Icons.trending_up),
            const SizedBox(height: 10),
            LessonCard(
              lessonNumber: 4,
              title: 'Verb Tenses',
              description: 'Present, Past, Future',
              progress: 0.0,
              isLocked: true,
              onTap: () {},
            ),
            LessonCard(
              lessonNumber: 5,
              title: 'Prepositions',
              description: 'In, On, At, Under, Between...',
              progress: 0.0,
              isLocked: true,
              onTap: () {},
            ),
            
            const SizedBox(height: 20),
            
            // Advanced Level Section
            const SectionHeader(title: 'Advanced Level', icon: Icons.emoji_events),
            const SizedBox(height: 10),
            LessonCard(
              lessonNumber: 6,
              title: 'Phrasal Verbs',
              description: 'Give up, Look for, Take off...',
              progress: 0.0,
              isLocked: true,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  static void _showLessonDetail(BuildContext context, String lessonTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(lessonTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.play_circle_outline, size: 60, color: Colors.orange),
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
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lesson content coming soon...'),
                  duration: Duration(seconds: 2),
                ),
              );
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
}

// Widget for section headers
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
        Icon(icon, color: Colors.orange.shade700, size: 28),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade700,
          ),
        ),
      ],
    );
  }
}

// Widget for each lesson card
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
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: isLocked ? null : onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Lesson number or lock
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isLocked ? Colors.grey.shade300 : Colors.orange.shade100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isLocked
                      ? const Icon(Icons.lock, color: Colors.grey)
                      : Text(
                          '$lessonNumber',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade700,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Lesson content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isLocked ? Colors.grey : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: isLocked ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),
                    if (progress > 0 && !isLocked) ...[
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.shade200,
                        color: Colors.orange,
                      ),
                    ],
                  ],
                ),
              ),
              
              // Status icon
              Icon(
                isLocked
                    ? Icons.lock_outline
                    : progress >= 1.0
                        ? Icons.check_circle
                        : Icons.play_circle_outline,
                color: isLocked
                    ? Colors.grey
                    : progress >= 1.0
                        ? Colors.green
                        : Colors.orange,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}