// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProdutoModel {
  
  final int? id;
  final String nome;
  final double preco;
  final DateTime dataCadastro;
  final String setor;
  
  ProdutoModel({
    this.id,
    required this.nome,
    required this.preco,
    required this.dataCadastro,
    required this.setor,
  });



}
