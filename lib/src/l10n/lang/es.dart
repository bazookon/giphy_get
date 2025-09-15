import '../default_localizations.dart';

class EsLocalizations extends GiphyGetUILocalizationLabels {
  @override
  final String searchInputLabel;

  @override
  final String emojisLabel;

  @override
  final String gifsLabel;

  @override
  final String stickersLabel;

  @override
  final String moreBy;

  @override
  final String viewOnGiphy;

  @override
  final String poweredByGiphy;

  const EsLocalizations({
    this.searchInputLabel = 'Buscar GIPHY',
    this.emojisLabel = 'Emojis',
    this.gifsLabel = 'Gifs',
    this.stickersLabel = 'Stickers',
    this.moreBy = 'Más de',
    this.viewOnGiphy = 'Ver en GIPHY',
    this.poweredByGiphy = 'Potenciado por GIPHY',
  });
}
