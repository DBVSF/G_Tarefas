

import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/task.dart';
import 'package:primeiro_projeto/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Tarefas'),
      ),
      body: ListView(
        children: const [
          Task('Aprender Flutter', 'assets/images/flutter.png', 4),
          Task('Caminhar', 'assets/images/caminhar.jpeg', 5),
          Task('Estudar', 'assets/images/estudar.png', 3),
          Task('Jogar', 'assets/images/jogar.jpg', 1),
          SizedBox(
            height: 80,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add_circle_outline),
      ),
    );
  }
}
