
import 'package:flutter/cupertino.dart';
import 'package:gestor_market/models/fornecedor_model.dart';

import '../databse/database.dart';

class FornecedorController extends ChangeNotifier{
  List<FornecedorModel> _fornecedores = [];
  List<FornecedorModel> get fornecedores => List.unmodifiable(_fornecedores);

  Future<void> buscaTodos() async {
    final conn = await Database().getConnection();
    final result = await conn.query("SELECT * FROM fornecedor");

    List<FornecedorModel> fornecedoresConsulta = [];

    if (result.isNotEmpty) {
      for (var cliente in result) {
        fornecedoresConsulta.add(FornecedorModel(
          id: cliente['id'],
          cnpj: cliente['cnpj'],
          email: cliente['email'],
          nome: cliente['nome'],
          telefone: cliente['telefone']
        ));
      }
    }
    _fornecedores = fornecedoresConsulta;
    notifyListeners();
  }

   Future<void> cadastrar({required FornecedorModel fornecedor}) async {
    final conn = await Database().getConnection();
    await conn.query("INSERT INTO fornecedor (nome, email, telefone, cnpj) VALUES ('${fornecedor.nome}', '${fornecedor.email}', '${fornecedor.telefone}','${fornecedor.cnpj}')");
  } 

  Future<void> delete({required int codigo}) async {
    final conn = await Database().getConnection();
    await conn.query("DELETE FROM fornecedor WHERE id = $codigo");

    _fornecedores.removeWhere((cli) => cli.id == codigo);
    final list = _fornecedores;
    _fornecedores = [...list];
    notifyListeners();
  }

  Future<void> editar({required FornecedorModel fornecedor})async{
    final conn =  await Database().getConnection();
    await conn.query("UPDATE fornecedor SET nome = '${fornecedor.nome}', email = '${fornecedor.email}', telefone = '${fornecedor.telefone}', cnpj = '${fornecedor.cnpj}' WHERE id = ${fornecedor.id}");
  }

}