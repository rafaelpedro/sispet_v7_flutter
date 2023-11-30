import 'package:mysql1/mysql1.dart';

class Database {
  //localhost
  static const String _host = 'localhost';
  static const int _port = 3307;
  static const String _db = 'sispet_v7';
  static const String _user = 'root';
  static const String _password = '';

  Future<MySqlConnection> getConnection() async {
    var settings =
        ConnectionSettings(host: _host, port: _port, user: _user, db: _db);

    return await MySqlConnection.connect(settings);
  }

  Future<void> closeConnection(MySqlConnection conn) async {
    await conn.close();
  }
}
