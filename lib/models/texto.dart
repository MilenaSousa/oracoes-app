class Texto {
  int id;
  int cor;
  String titulo;
  String fonte;
  String categNome;
  String categImg;
  String texto;

  Texto({
    this.id,
    this.cor,
    this.titulo,
    this.fonte,
    this.categNome,
    this.categImg,
    this.texto
  });

  factory Texto.fromJson(Map<String, dynamic> json) {
    return Texto(
      id: json['id'],
      cor: json['cor'],
      titulo: json['titulo'],
      fonte: json['fonte'],
      categNome: json['categNome'],
      categImg: json['categImg'],
      texto: json['texto'],
    );
  }
}