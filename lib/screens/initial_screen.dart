import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/task.dart';
import 'package:primeiro_projeto/data/task_dao.dart';
import 'package:primeiro_projeto/data/task_inherited.dart';
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
        actions: [IconButton(onPressed: (){setState((){});}, icon: Icon(Icons.refresh_outlined))],
        title: const Text('Tarefas'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<Task>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Carregando dados')
                      ],
                    ),
                  );
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Carregando dados')
                      ],
                    ),
                  );
                case ConnectionState.active:
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Carregando dados')
                      ],
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext contex, int index) {
                            final Task tarefa = items[index];
                            return tarefa;
                          });
                    }
                    return Center(
                      child: Column(children: [
                        Icon(Icons.error_outline, size: 128),
                        Text(
                          'Não há nenhuma tarefa!',
                          style: TextStyle(fontSize: 32),
                        ),
                      ]),
                    );
                  }
                  return Text('Erro ao carregar as Tarefas');
              }
              return Text('erro desconhecido');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(
                taskContext: context,
              ),
            ),
          ).then((value) => setState((){
            print('recarregando a tela');
          }));
        },
        child: const Icon(Icons.add_circle_outline),
      ),
    );
  }
}
