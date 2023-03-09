import 'lang/en.dart';
import 'lang/es.dart';
import 'lang/da.dart';
import 'lang/fr.dart';
import 'lang/et.dart';
import 'lang/lv.dart';
import 'lang/lt.dart';

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
  'es': EsLocalizations(),
  'da': DaLocalizations(),
  'lt': LtLocalizations(),
  'lv': LvLocalizations(),
  'et': EtLocalizations(),
  'fr': FrLocalizations()
};

class DefaultLocalizations extends EnLocalizations {
  const DefaultLocalizations();
}
