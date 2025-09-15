import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'default_localizations.dart';
import 'lang/en.dart';

const kDefaultLocale = Locale('en');

class GiphyGetUILocalizations<T extends GiphyGetUILocalizationLabels> {
  final Locale locale;
  final T labels;

  const GiphyGetUILocalizations(this.locale, this.labels);

  static GiphyGetUILocalizations of(BuildContext context) {
    final l = Localizations.of<GiphyGetUILocalizations>(
      context,
      GiphyGetUILocalizations,
    );

    if (l != null) {
      return l;
    }

    final defaultLocalizations = localizations[kDefaultLocale.languageCode]!;
    return GiphyGetUILocalizations(kDefaultLocale, defaultLocalizations);
  }

  static GiphyGetUILocalizationLabels labelsOf(BuildContext context) {
    return GiphyGetUILocalizations.of(context).labels;
  }

  static GiphyGetUILocalizationDelegate delegate =
      const GiphyGetUILocalizationDelegate();

  static GiphyGetUILocalizationDelegate
      withDefaultOverrides<T extends EnLocalizations>(T overrides) {
    return GiphyGetUILocalizationDelegate<T>(overrides);
  }
}

class GiphyGetUILocalizationDelegate<T extends GiphyGetUILocalizationLabels>
    extends LocalizationsDelegate<GiphyGetUILocalizations> {
  final T? overrides;
  final bool _forceSupportAllLocales;

  const GiphyGetUILocalizationDelegate([
    this.overrides,
    this._forceSupportAllLocales = false,
  ]);

  @override
  bool isSupported(Locale locale) {
    return _forceSupportAllLocales ||
        localizations.keys.contains(locale.languageCode);
  }

  @override
  Future<GiphyGetUILocalizations> load(Locale locale) {
    final l = GiphyGetUILocalizations(
      locale,
      overrides ?? localizations[locale.languageCode]!,
    );

    return SynchronousFuture<GiphyGetUILocalizations>(l);
  }

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<GiphyGetUILocalizations> old,
  ) {
    return false;
  }
}
