class Categoria {
  String nome;
  String img;
  String desc;
  int quantidade;
  int cor;

  Categoria({this.nome, this.img, this.desc, this.quantidade, this.cor});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      nome: json['nome'],
      img: json['img'],
      desc: json['desc'],
      quantidade: json['quantidade'], 
      cor: json['cor'],
    );
  }

}