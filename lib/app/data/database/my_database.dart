import 'package:loteria/app/model/numeros_sorteados_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static Database? _db;

  Future<Database> openConnection() async {
    //Guarda o caminho do path do celular
    final databasePath = await getDatabasesPath();

    //Concatena o caminho do path com a pasta onde irá salvar os documentos
    final databaseFinalPath = join(databasePath, 'megasena');

    return await openDatabase(
      databaseFinalPath,
      version: 1,
      onCreate: (Database db, int version) {
        final batch = db.batch();

        batch.execute(
            '''create table numeros(id Integer primary key autoincrement,
            concurso varchar,
            numero1 varchar,
            numero2 varchar,
            numero3 varchar,
            numero4 varchar,
            numero5 varchar,
            numero6 varchar,
            data varchar)''');

        batch.commit();
      },
      onUpgrade: (Database db, int oldVersion, int version) {
        // final batch = db.batch();
      },
      onDowngrade: (Database db, int oldVersion, int version) {
        //  final batch = db.batch();
      },
    );
  }

  Future<List<NumerosSorteadosModel>> listar() async {
    _db = await MyDatabase().openConnection();
    List<Map<String, dynamic>>? resultado = await _db?.query('numeros');
    List<NumerosSorteadosModel> lista = List.generate(
      resultado!.length,
      (index) {
        var linha = resultado[index];
        return NumerosSorteadosModel(
            numero1: linha['numero1'],
            numero2: linha['numero2'],
            numero3: linha['numero3'],
            numero4: linha['numero4'],
            numero5: linha['numero5'],
            numero6: linha['numero6'],
            data: linha['data'],
            id: linha['id'],
            concurso: linha['concurso']);
      },
    );

    return lista;
  }

  

  Future insert(NumerosSorteadosModel numerosSorteadosModel) async {
    _db = await MyDatabase().openConnection();
    await _db!.rawInsert(
      'insert into numeros values(null, ?,?,?,?,?,?,?,?)',
      [
        '${numerosSorteadosModel.concurso}',
        '${numerosSorteadosModel.numero1}',
        '${numerosSorteadosModel.numero2}',
        '${numerosSorteadosModel.numero3}',
        '${numerosSorteadosModel.numero4}',
        '${numerosSorteadosModel.numero5}',
        '${numerosSorteadosModel.numero6}',
        '${numerosSorteadosModel.data}',
      ],
    );
  }

  Future<List> buscarDados() async {
    final database = await MyDatabase().openConnection();
    String sql = "SELECT * FROM numeros";
    List listaBanco = await database.rawQuery(sql);

    return listaBanco;
  }

  deleteNumerosSalvos(int id) async {
    Database? db = _db;
    var sql = 'DELETE FROM numeros WHERE id =?';
    db!.rawDelete(sql, [id]);
  }
}
