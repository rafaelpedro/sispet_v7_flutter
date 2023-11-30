import 'package:flutter/cupertino.dart';
import 'package:gestor_market/databse/database.dart';
import 'package:gestor_market/models/user_model.dart';


class LoginController extends ChangeNotifier {


  Future<UserModel?> login({required String email, required String senha}) async {
    final conn = await Database().getConnection();
    UserModel? userLogged;

    final result = await conn.query(
        "SELECT * FROM USUARIO WHERE EMAIL = '$email' AND SENHA = '$senha'");

    if (result.isNotEmpty) {
      for (var user in result) {
        userLogged = UserModel(id: user['id'], email: user['email'], nome: user['nome'], senha: user['nome'], image: user['image'] ?? '', logado: user['logado']);
        await conn
            .query("UPDATE USUARIO SET LOGADO = 1 WHERE ID = ${user['id']}");
      }
    }
    return userLogged;
  }

  Future<UserModel?> isLogged() async {
    final conn = await Database().getConnection();
    UserModel? userLogged;

    final result = await conn.query("SELECT * FROM USUARIO WHERE LOGADO = 1");
    if (result.isNotEmpty) {
      for (var user in result) {
        userLogged = UserModel(id: user['id'], email: user['email'], nome: user['nome'], senha: user['nome'], image: user['image'] ?? '', logado: user['logado']);
        await conn
            .query("UPDATE USUARIO SET LOGADO = 1 WHERE ID = ${user['id']}");
      }
    }
    return userLogged;
  }

  Future<void> logout() async {
    final conn = await Database().getConnection();
    await conn.query("UPDATE USUARIO SET LOGADO = 0");
  }

}
