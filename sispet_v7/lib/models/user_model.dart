// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  
  final int? id;
  final String nome;
  final String email;
  final String senha;
  final int logado;
  final String image;

  
  UserModel({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.logado,
    required this.image,
  });

}
