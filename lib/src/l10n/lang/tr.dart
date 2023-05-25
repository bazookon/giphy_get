import '../default_localizations.dart';

class TrLocalizations extends GiphyGetUILocalizationLabels {
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

  const TrLocalizations({
    this.searchInputLabel = 'GIPHY\'i ara',
    this.emojisLabel = 'Emojiler',
    this.gifsLabel = 'GIFler',
    this.stickersLabel = 'Stickerler',
    this.moreBy = 'Daha fazla',
    this.viewOnGiphy = 'GIPHY\'de gör',
    this.poweredByGiphy = 'Powered by GIPHY',
  });
}
