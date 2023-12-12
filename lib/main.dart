import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent ,
          title: Text('Tarefas'),
        ),
        body: ListView(
          children: [
            Task('Aprender Flutter'),
            Task('Andar de Skate'),
            Task('Estudar'),
            Task('Aprender Flutter'),
            Task('Andar de Skate'),
            Task('Estudar'),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {}),
      ),
    );
  }
}

class Task extends StatefulWidget {
  final String name;

  const Task(this.name, {super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int nivel = 0;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Stack(
          children: [
            Container(
              color: Colors.blue,
              height: 140,
            ),
            Column(
              children: [
                Container(
                  color: Colors.amber,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.black,
                        width: 70,
                        height: 100,
                      ),
                      Container(
                          width: 200,
                          child: Text(widget.name,
                              style: TextStyle(
                                  fontSize: 20, overflow: TextOverflow.ellipsis))),
                      ElevatedButton(
                          onPressed: () {setState(() {
                            nivel++;
                          });}, child: Icon(Icons.add_circle))
                    ],
                  ),
                ),Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Container(child: LinearProgressIndicator(
                        value:nivel/10,
                      ), width: 200,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Nível: $nivel", style: TextStyle(fontSize: 15, color: Colors.white),),
                    ),
                  ],
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}
