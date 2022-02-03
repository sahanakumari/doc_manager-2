
import 'package:doc_manager/data/models/models.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? _database;
  var kTableName = "Doctor";

  Future<Database> _openDb() {
    var _kCreateTable = "CREATE TABLE $kTableName ("
        "id INTEGER PRIMARY KEY,"
        "first_name TEXT,"
        "last_name TEXT NULL,"
        "profile_pic TEXT NULL,"
        "specialization TEXT NULL,"
        "description TEXT NULL,"
        "rating TEXT NULL,"
        "gender TEXT NULL,"
        "primary_contact_no TEXT,"
        "dob TEXT NULL,"
        "blood_group TEXT NULL,"
        "height TEXT NULL,"
        "weight TEXT NULL)";

    return openDatabase("doc.db", version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(_kCreateTable);
        }, onOpen: (Database db) {
          _database ??= db;
        });
  }

  Future<List<Doctor>> getDoctors() async {
    _database ??= await _openDb();
    var list = await _database!.query(kTableName);
    return list.map((e) => Doctor.fromJson(e)).toList();
  }

  Future<Doctor?> addOrUpdateDoctor(Doctor doctor) async {
    _database ??= await _openDb();
    try {
      var id = await _database!.insert(kTableName, doctor.toJson(doctor));
      return getDoctor(id);
    } on DatabaseException {
      return _updateDoctor(doctor, doctor.id!);
    }
  }

  Future<Doctor?> _updateDoctor(Doctor doctor, int id) async {
    _database ??= await _openDb();
    await _database!.update(kTableName, doctor.toJson(doctor),
        where: "id=?", whereArgs: [id]);
    return getDoctor(id);
  }

  Future<Doctor?> getDoctor(int? id) async {
    if (id == null) return null;
    _database ??= await _openDb();
    var query =
    await _database!.query(kTableName, where: "id=?", whereArgs: [id]);
    if (query.isNotEmpty) return Doctor.fromJson(query.first);
    return null;
  }
}
