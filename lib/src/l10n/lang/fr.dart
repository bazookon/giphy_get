import '../default_localizations.dart';

class FrLocalizations extends GiphyGetUILocalizationLabels {
  @override
  final String emojisLabel;

  @override
  final String gifsLabel;

  @override
  final String moreBy;

  @override
  final String poweredByGiphy;

  @override
  final String searchInputLabel;

  @override
  final String stickersLabel;

  @override
  final String viewOnGiphy;
  const FrLocalizations({
    this.searchInputLabel = 'Recherche GIPHY',
    this.emojisLabel = 'Emojis',
    this.gifsLabel = 'GIFs',
    this.stickersLabel = 'Stickers',
    this.moreBy = 'Plus de',
    this.viewOnGiphy = 'Voir sur GIPHY',
    this.poweredByGiphy = 'Powered by GIPHY',
  });
}
