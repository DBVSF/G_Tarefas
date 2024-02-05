import 'package:primeiro_projeto/components/task.dart';
import 'package:primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static const String _tablename = 'takTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task tarefa) async {
    print('iniciando o save');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.name);
    Map<String, dynamic> taskMap = toMap(tarefa);

    if (itemExists.isEmpty) {
      print('tarefa nao existia');
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      print('tarefa ja existia');
      return await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_name =?',
        whereArgs: [tarefa.name],
      );
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    print('convertentedo para map');
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = tarefa.name;
    mapaDeTarefas[_image] = tarefa.image;
    mapaDeTarefas[_difficulty] = tarefa.difficultyLevel;
    print('mapa de tarefas $mapaDeTarefas');
    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    print('acessando o findall');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('procurando dados no banco de dados.. ecnontrando: $result');
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('convertendo tolist');
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    print('lista de tarefas $tarefas');
    return tarefas;
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    print('acessando find');

    final Database bancoDeDados = await getDatabase();

    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name =?',
      whereArgs: [nomeDaTarefa],
    );
    print('tarefa encontrada>: ${toList(result)}');
    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print('deletando tarefa $nomeDaTarefa');
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
  }
}
