import 'lang/en.dart';
import 'lang/es.dart';

abstract class GiphyGetUILocalizationLabels {
  const GiphyGetUILocalizationLabels();

  String get searchInputLabel;
  String get gifsLabel;
  String get stickersLabel;
  String get emojisLabel;
  String get viewOnGiphy;
  String get moreBy;
  String get poweredByGiphy;
}


const localizations = <String, GiphyGetUILocalizationLabels>{
  'en': EnLocalizations(),
  'es': EsLocalizations()
};

class DefaultLocalizations extends EnLocalizations {
  const DefaultLocalizations();
}