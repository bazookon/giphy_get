import '../default_localizations.dart';

class DaLocalizations extends GiphyGetUILocalizationLabels {
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

  const DaLocalizations({
    this.searchInputLabel = 'Søg GIPHY',
    this.emojisLabel = 'Emojis',
    this.gifsLabel = 'GIFs',
    this.stickersLabel = 'Klistremærker',
    this.moreBy = 'Flere fra',
    this.viewOnGiphy = 'Se på GIPHY',
    this.poweredByGiphy = 'Powered by GIPHY',
  });
}
