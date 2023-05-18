import 'package:pontodeluz/models/texto.dart';
import 'package:pontodeluz/payload/oracoes_textos.dart' as payload;
import 'package:pontodeluz/payload/categorias.dart' as categoria;

class OracoesService {
  List<Texto> getOracoes() {
    List<Texto> oracoes = [];
    Texto texto;
    for(var i = 0; i<payload.oracoesTextos.length; i++) {
      payload.oracoesTextos[i]['id'] = i; // add um id unico a cada texto
      texto = Texto.fromJson(payload.oracoesTextos[i]);
      oracoes.add(texto);
    }
    return oracoes;
  }

  List<Texto> getOracoesCateg(String categoria) {
    List<Texto> oracoes = [];
    Texto texto;
    for(var i = 0; i<payload.oracoesTextos.length; i++) {
      payload.oracoesTextos[i]['id'] = i; // add um id unico a cada texto
      if(categoria == payload.oracoesTextos[i]['categNome']) {
        texto = Texto.fromJson(payload.oracoesTextos[i]);
        oracoes.add(texto);
      }
    }
    return oracoes;
  }

  getCategorias() {
    List<Map<String, dynamic>> ctgrs = [];
    categoria.categorias.forEach((str, val) {
      ctgrs.add(val);
    });
    
    return ctgrs;
  }

}