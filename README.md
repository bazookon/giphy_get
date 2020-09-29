# giphy_get

[![pub package](https://img.shields.io/badge/pub-v0.9.2-orange)](https://pub.dev/packages/giphy_get)
[![pub package](https://img.shields.io/badge/platform-flutter-blue.svg)](https://github.com/bazospa)


## Overview
This package allow to get gifs, sticker or emojis from [GIPHY](https://www.giphy.com/) in pure dart code using [Giphy SDK](https://developers.giphy.com/docs/sdk) design guidelines.


### Inspiration
<img src="https://developers.giphy.com/branch/master/static/sdk-header@3x-bac7eb3abd9c3fa0e4454aceb0257a18.gif" width="360" />


### Result
<img src="https://github.com/bazospa/giphy_get/raw/master/example/assets/demo/giphy_get.webp" width="360" />



## Getting Started

Important! you must register your app at [Giphy Develepers](https://developers.giphy.com/dashboard/) and get your APIKEY


```dart 
import 'package:giphy_get/giphy_get.dart';

GiphyGif gif = await GiphyGet.getGif(
  context: context, //Required
  apiKey: "your api key HERE", //Required.
  lang: GiphyLanguage.english, //Optional - Language for query.
  randomID: "abcd", // Optional - An ID/proxy for a specific user. 
  searchText :"Search GIPHY",//Optional - AppBar search hint text.
  tabColor:Colors.teal, // Optional- default accent color.
);
```

### Options

| Value   | Type    |    Description                |   Default      |
| ---------|-------------|--------------------|--------------- |
| `lang` | String | Use [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) language code or use GiphyLanguage constants | `GiphyLanguage.english` | 
| `randomID` | String | An ID/proxy for a specific user.  |  `null`  | 
| `searchText` | String | Input search hint, we recomend use [flutter_18n pcakage](https://pub.dev/packages/flutter_i18n) for translation   |  `"Search GIPHY"`  | 
| `tabColor` | Color | Color for tabs and loading progress,    |  `Theme.of(context).accentColor`  | 



## Contrib
Feel free to make any PR's
