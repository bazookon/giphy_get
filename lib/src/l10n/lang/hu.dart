import '../default_localizations.dart';

class HuLocalizations extends GiphyGetUILocalizationLabels {
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

  const HuLocalizations({
    this.searchInputLabel = 'GIPHY keresés',
    this.emojisLabel = 'Emojik',
    this.gifsLabel = 'GIFek',
    this.stickersLabel = 'Matricák',
    this.moreBy = 'Több általa:',
    this.viewOnGiphy = 'Megtekintés GIPHY-n',
    this.poweredByGiphy = 'Powered by GIPHY',
  });
}
