import '../default_localizations.dart';

class LtLocalizations extends GiphyGetUILocalizationLabels {
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

  const LtLocalizations({
    this.searchInputLabel = 'Ieškoti GIPHY',
    this.emojisLabel = 'Jaustukai',
    this.gifsLabel = 'GIFai',
    this.stickersLabel = 'Lipdukai',
    this.moreBy = 'Daugiau iš',
    this.viewOnGiphy = 'Peržiūrėti GIPHY',
    this.poweredByGiphy = 'Veikia per GIPHY',
  });
}
