import 'package:flutter/cupertino.dart';
import 'package:gestor_market/databse/database.dart';
import 'package:gestor_market/models/user_model.dart';

class RegistrarController extends ChangeNotifier {
  Future<void> registrar({required UserModel user}) async {
    final conn = await Database().getConnection();
    await conn.query(
        "INSERT INTO USUARIO (nome, email, senha, logado, image) VALUES ('${user.nome}', '${user.email}','${user.senha}',0,'')");
  }
}
