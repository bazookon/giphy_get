# [3.6.1+1]

- Batch loading: Only visible GIFs are loaded/rendered, off-screen GIFs load as you scroll.
- Progressive loading: Blurred static thumbnail is shown while GIF loads, then swapped for the full GIF (YouTube-style experience).
- Custom loading/failed widgets: Pass your own widgets to display while loading or on error for a branded experience.
- See README for usage and details.

# [3.6.1] - 2024-06-28

- Added useRootNavigator parameter to showModalBottomSheet to allow GIFs to appear above bottom navigation bars

# [3.6.0] - 2024-12-18

- Up-to-date dependencies
- Fixed issue with emojis api v2

## [3.5.6] - 2024-05-14

- Up-to-date dependencies
- Arabic Added [#64](https://github.com/bazookon/giphy_get/pull/64) thanks to [anasalhajhasan](https://github.com/anasalhajhasan)

## [3.5.5] - 2024-05-14

- Up-to-date dependencies
- Fixed issue with the with of the bottom sheet
- Work's with flutter 3.22 🎉 and Webassembly

## [3.5.4] - 2024-01-09

- Up-to-date dependencies
- Hungarian Added [#60](https://github.com/bazookon/giphy_get/pull/60) thanks to [seelrd](https://github.com/seelrd)

## [3.5.3] - 2023-12-21

- Up-to-date ios dependencies

## [3.5.2] - 2023-10-31

- Up-to-date ios dependencies

## [3.5.1] - 2023-10-31

- Up-to-date dependencies

## [3.5.0] - 2023-08-01

- Up-to-date dependencies
- Allowing to override the default tab top (the handlebar)
- Allowing to override the default tab bottom (Giphy's credits)
- Allowing to override the search part component. In this case the logic part of the search is still made by the original component, only the UI part is overriden.
  thanks to [orevial](https://github.com/orevial)

## [3.4.2] - 2023-07-18

- Up-to-date dependencies

## [3.4.1] - 2023-05-11

- Turkish Added [#51](https://github.com/bazookon/giphy_get/pull/51) thanks to [mobisofts](https://github.com/mobisofts)

## [3.4.0] - 2023-05-11

- Up-to-date dependencies
- Ready to flutter 3.10 🎉

## [3.3.1] - 2023-04-03

- Up-to-date dependencies
- [Bug Fix] TabBar text color [#48](https://github.com/bazookon/giphy_get/pull/48) thanks to [sbis04](https://github.com/sbis04)

## [3.3.0] - 2023-03-09

- French Added [#46](https://github.com/bazookon/giphy_get/pull/46) thanks to [benco8186](https://github.com/benco8186)
- Material 3 supported [#44](https://github.com/bazookon/giphy_get/pull/44) Thanks to [hifiaz](https://github.com/hifiaz)
- Up-to-date dependencies

## [3.2.0] - 2022-12-19

- Search Debounce added [#30](https://github.com/bazookon/giphy_get/pull/40) thanks to [simplenotezy](https://github.com/simplenotezy)

## [3.1.1] - 2022-09-06

- Up-to-date dependencies

## [3.1.0] - 2022-06-09

- Update package and support flutter 3[#30](https://github.com/bazookon/giphy_get/pull/30) thanks to [hifiaz](https://github.com/hifiaz)
- Add SafeArea to Wrapper

## [3.0.5] - 2022-03-25

- Fixed null scroll position

## [3.0.4] - 2022-02-15

- Center Search Text

## [3.0.3] - 2022-02-14

- Search bar ui tweak [#26](https://github.com/bazookon/giphy_get/pull/26)

## [3.0.2] - 2022-02-12

- Up-to-date dependencies
- Automated Test

## [3.0.1] - 2022-02-02

- Fixed [Issue [#22](https://github.com/bazookon/giphy_get/issues/22)]
- Added "Powered by GIPHY" label

## [3.0.0] - 2022-01-24

- Readme updated
- Up-to-date dependencies
- Added new widgets
- Fixed aspect ratio

## [3.0.0-pre.1+2] - 2022-01-24

- Readme updated

## [3.0.0-pre.1+1] - 2022-01-24

- Automatic language for search

## [3.0.0-pre.1] - 2022-01-22

- Up-to-date dependencies
- Added new widgets
- Fixed aspect ratio

## [2.0.4] - 2021-12-19

- Up-to-date dependencies

## [2.0.3] - 2021-08-23

- Added gaplessPlayback parameter to network image to fix the issue with images dimming on scroll. [PR#15](https://github.com/bazospa/giphy_get/pull/15) Thanks to [Brazol](https://github.com/Brazol)
- Searchbar along Giphy guidelines [PR#16](https://github.com/bazospa/giphy_get/pull/16) Thanks to [Brazol](https://github.com/Brazol)
- Up-to-date dependencies

## [2.0.2] - 2021-06-10

- Fix Null Safety Thanks to [TramPamPam](https://github.com/TramPamPam)

## [2.0.1] - 2021-05-19

- Fix Null Safety

## [2.0.0] - 2021-05-01

- Up-to-date dependencies
- Fix Null Safety string in Giph class

## [2.0.0-nullsafety.3] - 2021-04-11

- Up-to-date dependencies
- Fix Null Safety string

## [2.0.0-nullsafety.2] - 2021-03-24

- Up-to-date dependencies

## [2.0.0-nullsafety.1] - 2021-03-11

- Null Safety Migration

## [1.1.1] - 2021-01-31

- Fix empty grid

## [1.1.0] - 2020-11-05

- Up-to-date dependencies
- Added Web support

## [1.0.1] - 2020-11-05

- Fix min giphy limit
- Added get Random ID

## [1.0.0] - 2020-10-15

- Fix rebuild gifs on textfield focus

## [0.9.5] - 2020-09-29

- Fix scroll focus

## [0.9.4] - 2020-09-29

- Fix loading gif speed

## [0.9.3] - 2020-09-23

- Fixes the toJson method of GiphyGif which was preventing the json to be stored in Firestore

## [0.9.2] - 2020-09-23

- Up-to-date dependencies

## [0.9.1] - 2020-09-19

- Publish preview

## [0.0.1] - 2020-09-12

- Initial release
