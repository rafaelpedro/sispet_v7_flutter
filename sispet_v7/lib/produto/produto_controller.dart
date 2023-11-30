import 'package:flutter/cupertino.dart';
import 'package:gestor_market/databse/database.dart';
import 'package:gestor_market/models/produto_model.dart';
import 'package:gestor_market/util/data_util.dart';

class ProdutoController extends ChangeNotifier {

  List<ProdutoModel> _produtos = [];
  List<ProdutoModel> get produtos => List.unmodifiable(_produtos);

  Future<void> buscaTodos() async {
    final conn = await Database().getConnection();
    final result = await conn.query("SELECT * FROM produto");
    List<ProdutoModel> produtosConsulta = [];

    if (result.isNotEmpty) {
      for (var produto in result) {
        produtosConsulta.add(ProdutoModel(
          id: produto['id'],
          nome: produto['nome'],
          preco: produto['preco'],
          dataCadastro: produto['data_cadastro'],
          setor: produto['setor'],
        ));
      }
    }
    _produtos = produtosConsulta;
    notifyListeners();
  }

  Future<void> cadastrar({required ProdutoModel produto}) async {
    final conn = await Database().getConnection();
    await conn.query("INSERT INTO PRODUTO (nome, preco, data_cadastro, setor) VALUES ('${produto.nome}', ${produto.preco}, '${DataUtil.formatDateTimeToString(produto.dataCadastro)}', '${produto.setor}')");
  } 

  Future<void> delete({required int codigo}) async {
    final conn = await Database().getConnection();
    await conn.query("DELETE FROM PRODUTO WHERE ID = $codigo");
    _produtos.removeWhere((prod) => prod.id == codigo);
    final list = _produtos;
    _produtos = [...list];
    notifyListeners();
  }

  Future<void> editar({required ProdutoModel produto})async{
    final conn =  await Database().getConnection();
    await conn.query("UPDATE PRODUTO SET nome = '${produto.nome}', preco = ${produto.preco}, data_cadastro = '${DataUtil.formatDateTimeToString(produto.dataCadastro)}', setor = '${produto.setor}' WHERE id = ${produto.id}");
  }
  


}
