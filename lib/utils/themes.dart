import 'package:pontodeluz/utils/constants.dart' as cor;

themeLight() {
  cor.backgroundColor = cor.BACKGROUND_LIGHT;
  cor.backgroundItem = cor.WHITE;
  cor.shadow = cor.GREY;
  // cor.fontAppBar = cor.BLACK800;
  cor.fontApp = cor.BLACK800;
  cor.fontSubtitle = cor.BLACK400;
  cor.lightOn = true;
}

themeDark() {
  cor.backgroundColor = cor.BACKGROUND_DARK;
  cor.backgroundItem = cor.BACKGROUND_DARK;
  cor.shadow = cor.BACKGROUND_DARK;
  // cor.fontAppBar = cor.WHITE; // tirar
  cor.fontApp = cor.WHITE;
  cor.fontSubtitle = cor.WHITE400;
  cor.lightOn = false; 
}