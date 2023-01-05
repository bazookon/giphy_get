import 'package:giphy_get/src/l10n/lang/et.dart';
import 'package:giphy_get/src/l10n/lang/lt.dart';
import 'package:giphy_get/src/l10n/lang/lv.dart';

import 'lang/en.dart';
import 'lang/es.dart';
import 'lang/da.dart';

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
};

class DefaultLocalizations extends EnLocalizations {
  const DefaultLocalizations();
}
