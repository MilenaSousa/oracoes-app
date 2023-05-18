class CoresAlternadas {
  
  static List<int> cores = [0xffF59C7A, 0xffFFC38B, 0xffF7CB77];
  static var i, cor;

  static getColor(int index, ) {
    cor = i;       
    i++; 
    if(index == cores.length-1) i = 0; 
    return cores[cor];
  }

}