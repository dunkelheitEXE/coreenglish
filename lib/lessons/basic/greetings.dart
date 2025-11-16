import 'package:flutter/material.dart';

class Greetings extends StatefulWidget {
  const Greetings({super.key});

  @override
  State<Greetings> createState() => _GreetingsState();
}

class _GreetingsState extends State<Greetings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecciones'),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Color.fromARGB(255, 199, 199, 199),
                shadowColor: Color.fromARGB(255, 48, 48, 48),
                child: Row(
                  children: [
                    Text("HI! I")
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}