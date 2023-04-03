# giphy_get

[![Flutter_Tests](https://github.com/bazookon/giphy_get/actions/workflows/test.yml/badge.svg)](https://github.com/bazookon/giphy_get/actions/workflows/test.yml)
[![pub package](https://img.shields.io/badge/pub-v3.1.0-orange)](https://pub.dev/packages/giphy_get)
[![pub package](https://img.shields.io/badge/platform-flutter-blue.svg)](https://github.com/bazospa)
[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)

## Overview

This package allow to get gifs, sticker or emojis from [GIPHY](https://www.giphy.com/) in pure dart code using [Giphy SDK](https://developers.giphy.com/docs/sdk) design guidelines.

### Inspiration

<img src="https://developers.giphy.com/branch/master/static/sdk-header@3x-bac7eb3abd9c3fa0e4454aceb0257a18.gif" width="360" />

### Result

<img src="https://github.com/bazookon/giphy_get/raw/main/example/assets/demo/giphy_get_widget.gif" width="360" />

## Getting Started

Important! you must register your app at [Giphy Develepers](https://developers.giphy.com/dashboard/) and get your APIKEY

## Localizations

Currently english and spanish is supported.

```dart
return MaterialApp(
      title: 'Giphy Get Demo',
      localizationsDelegates: [
        // Default Delegates
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,

        // Add this line
        GiphyGetUILocalizations.delegate
      ],
      supportedLocales: [
        // Your supported languages
        Locale('en', ''),
        Locale('es', ''),
        Locale('da', ''),
      ],
      home: MyHomePage(title: 'Giphy Get Demo'),
      themeMode: Provider.of<ThemeProvider>(context).currentTheme,
    );
```

### Get only Gif

This is for get gif without wrapper and tap to more

```dart
import 'package:giphy_get/giphy_get.dart';

GiphyGif gif = await GiphyGet.getGif(
  context: context, //Required
  apiKey: "your api key HERE", //Required.
  lang: GiphyLanguage.english, //Optional - Language for query.
  randomID: "abcd", // Optional - An ID/proxy for a specific user.
  tabColor:Colors.teal, // Optional- default accent color.
  debounceTimeInMilliseconds: 350, // Optional- time to pause between search keystrokes
);
```

### Options

| Value                        | Type   | Description                                                                                                     | Default                         |
| ---------------------------- | ------ | --------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| `lang`                       | String | Use [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) language code or use GiphyLanguage constants           | `GiphyLanguage.english`         |
| `randomID`                   | String | An ID/proxy for a specific user.                                                                                | `null`                          |
| `searchText`                 | String | Input search hint, we recomend use [flutter_18n package](https://pub.dev/packages/flutter_i18n) for translation | `"Search GIPHY"`                |
| `tabColor`                   | Color  | Color for tabs and loading progress,                                                                            | `Theme.of(context).accentColor` |
| `debounceTimeInMilliseconds` | int    | Time to pause between search keystrokes                                                                         | `350`                           |
| `showGIFs`                   | bool   | Whether to show the GIFs tab or not                                                                             | `true`                          |
| `showStickers`               | bool   | Whether to show the stickers tab or not                                                                         | `true`                          |
| `showEmojis`                 | bool   | Whether to show the emojis tab or not                                                                           | `true`                          |

### [Get Random ID](https://developers.giphy.com/docs/api/endpoint#random-id)

```dart
GiphyClient giphyClient = GiphyClient(apiKey: "YOUR API KEY");
String randomId = await giphyClient.getRandomId();
```

# Widgets

Optional but this widget is required if you get more gif's of user or view on Giphy following Giphy Design guidelines

![giphy](https://developers.giphy.com/branch/master/static/attribution@2x-d66dd0ec49c03f6ba401354859bfca13.png)

## GiphyGifWidget

Params
| Value                      | Type                                       | Description                                                                                                                                  | Default          |
| -------------------------- | ------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| gif `required`             | GiphyGif                                   | GiphyGif object from stream or JSON                                                                                                          | null             |
| giphyGetWrapper `required` | GiphyGetWrapper                            | instance required for tap to more                                                                                                            | null             |
| showGiphyLabel             | boolean                                    | show or hide `Powered by GIPHY`label at bottom                                                                                               | true             |
| borderRadius               | BorderRadius ex: BorderRadius.circular(10) | add border radius to image                                                                                                                   | null             |
| imageAlignment             | Alignment                                  | this widget is a [STACK](https://api.flutter.dev/flutter/widgets/Stack-class.html) with Image and tap buttons this property adjust alignment | Alignment.center |

## GiphyGetWrapper

Params
| Value                    | Type     | Description                                               | Default |
| ------------------------ | -------- | --------------------------------------------------------- | ------- |
| `giphy_api_key` required | String   | Your Giphy API KEY                                        | null    |
| `builder`                | function | return Stream\<GiphyGif\> and Instance of GiphyGetWrapper | null    |

## Methods

void getGif(String queryText,BuildContext context)

```dart
return GiphyGetWrapper(
    giphy_api_key: REPLACE_WITH YOUR_API_KEY,
    // Builder with Stream<GiphyGif> and Instance of GiphyGetWrapper
    builder: (stream, giphyGetWrapper) => StreamBuilder<GiphyGif>(
      stream: stream,
      builder: (context, snapshot) {
        return Scaffold(
          body: snapshot.hasData
              ? SizedBox(
                // GiphyGifWidget with tap to more
                child: GiphyGifWidget(
                  imageAlignment: Alignment.center,
                  gif: snapshot.data,
                  giphyGetWrapper: giphyGetWrapper,
                  borderRadius: BorderRadius.circular(30),
                  showGiphyLabel: true,
                ),
              )
              : Text("No GIF"),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              //Open Giphy Sheet
              giphyGetWrapper.getGif('', context);
            },
            tooltip: 'Open Sticker',
            child: Icon(Icons
                .insert_emoticon)),
        );
    })

    });

```

## Example APP

First export your giphy api key

```terminal
export GIPHY_API_KEY=YOUR_GIPHY_API_KEY
```

and ther run.

## Contrib

Feel free to make any PR's
