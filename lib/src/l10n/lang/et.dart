import '../default_localizations.dart';

class EtLocalizations extends GiphyGetUILocalizationLabels {
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

  const EtLocalizations({
    this.searchInputLabel = 'Otsi GIPHY',
    this.emojisLabel = 'Emotikonid',
    this.gifsLabel = 'GIF-id’',
    this.stickersLabel = 'Kleepsud',
    this.moreBy = 'Vaata veel',
    this.viewOnGiphy = 'Vaata GIPHY',
    this.poweredByGiphy = 'Platvorm GIPHY',
  });
}
