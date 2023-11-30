
import 'package:flutter/cupertino.dart';
import 'package:gestor_market/models/clientes_model.dart';

import '../databse/database.dart';

class ClientesController extends ChangeNotifier{
  List<ClientesModel> _clientes = [];
  List<ClientesModel> get clientes => List.unmodifiable(_clientes);

  Future<void> buscaTodos() async {
    final conn = await Database().getConnection();
    final result = await conn.query("SELECT * FROM cliente");

    List<ClientesModel> clientesConsulta = [];

    if (result.isNotEmpty) {
      for (var cliente in result) {
        clientesConsulta.add(ClientesModel(
          id: cliente['id'],
          nome: cliente['nome'],
          cpf: cliente['cpf'],
          email: cliente['email'],
          telefone: cliente['telefone'],
        ));
      }
    }
    _clientes = clientesConsulta;
    notifyListeners();
  }

   Future<void> cadastrar({required ClientesModel cliente}) async {
    final conn = await Database().getConnection();
    await conn.query("INSERT INTO cliente (nome, cpf, telefone, email) VALUES ('${cliente.nome}', '${cliente.cpf}', '${cliente.telefone}','${cliente.email}')");
  } 

  Future<void> delete({required int codigo}) async {
    final conn = await Database().getConnection();
    await conn.query("DELETE FROM cliente WHERE id = $codigo");

    _clientes.removeWhere((cli) => cli.id == codigo);
    final list = _clientes;
    _clientes = [...list];
    notifyListeners();
  }

  Future<void> editar({required ClientesModel cliente})async{
    final conn =  await Database().getConnection();
    await conn.query("UPDATE cliente SET nome = '${cliente.nome}', cpf = '${cliente.cpf}', telefone = '${cliente.telefone}', email = '${cliente.email}' WHERE id = ${cliente.id}");
  }

}