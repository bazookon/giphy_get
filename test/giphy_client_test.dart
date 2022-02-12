import 'dart:io';

import 'package:giphy_get/giphy_get.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockClient extends Mock implements Client {}

Future<void> main() async {

  var _apiKey = Platform.environment['GIPHY_API_KEY']??'';

  group('GiphyClient', () {
    test('should fetch trending gifs', () async {
      final client = GiphyClient(
        apiKey: _apiKey,
        randomId: '',
      );

      final collection = await client.trending();

      expect(collection, TypeMatcher<GiphyCollection>());
    });

    test('should search gifs', () async {
      final client = GiphyClient(
        apiKey: _apiKey,
        randomId: '',
      );

      final collection = await client.search('');

      expect(collection, TypeMatcher<GiphyCollection>());
    });

    test('should fetch emojis', () async {
      final client = GiphyClient(
        apiKey: _apiKey,
        randomId: '',
      );

      final collection = await client.emojis();

      expect(collection, TypeMatcher<GiphyCollection>());
    });

    test('should load a random gif', () async {
      final client = GiphyClient(
        apiKey: _apiKey,
        randomId: '',
      );

      final gif = await client.random(tag: '');

      expect(gif, TypeMatcher<GiphyGif>());
     
    });

    test('should load a gif by id', () async {
      final client = GiphyClient(
        apiKey: _apiKey,
        randomId: '',
      );

      final gif = await client.byId('l46Cc0Ped9R0uiTkY');

      expect(gif, TypeMatcher<GiphyGif>());
      expect(gif.title?.toLowerCase(), 'Beyonce freedom GIF by BET Awards'.toLowerCase());
    });

    test('should parse gifs correctly', () async {
      final client = GiphyClient(
        apiKey: _apiKey,
        randomId: '',
      );

      // Gif Validation
      final gif = (await client.trending()).data!.first;
      expect(gif.rating, GiphyRating.g);
      expect(gif.type, 'gif');
    
    });

    test('should parse users correctly', () async {
      final client = GiphyClient(
        apiKey: _apiKey,
        randomId: '',
      );

      // Gif Validation
      final user = (await client.trending()).data!.first.user;
     
      expect(user?.profileUrl, isNotNull);
    });

    test('should parse images correctly', () async {
      final client = GiphyClient(
        apiKey: _apiKey,
        randomId: '',
      );

      // Gif Validation
      final images = (await client.trending()).data!.first.images;
      expect(images!.fixedHeightStill, TypeMatcher<GiphyStillImage>());
      expect(images.originalStill, TypeMatcher<GiphyStillImage>());
      // expect(images.fixedWidth, GiphyFullImage());
      expect(images.fixedHeightSmallStill, TypeMatcher<GiphyStillImage>());
      // expect(
      //   images.fixedHeightDownsampled,
      //   GiphyDownsampledImage(),
      // );
      expect(images.preview, TypeMatcher<GiphyPreviewImage>());
      expect(images.fixedHeightSmall, TypeMatcher<GiphyFullImage>());
      expect(images.downsizedStill, TypeMatcher<GiphyStillImage>());
      expect(images.downsized, TypeMatcher<GiphyDownsizedImage>());
      expect(images.downsizedLarge, TypeMatcher<GiphyDownsizedImage>());
      expect(images.fixedWidthSmallStill, TypeMatcher<GiphyStillImage>());
      expect(images.previewWebp, TypeMatcher<GiphyWebPImage>());
      expect(images.fixedWidthStill, TypeMatcher<GiphyStillImage>());
      expect(images.fixedWidthSmall, TypeMatcher<GiphyFullImage>());
      expect(images.downsizedSmall, TypeMatcher<GiphyPreviewImage>());
      expect(images.downsizedMedium, TypeMatcher<GiphyPreviewImage>());
      expect(images.original, TypeMatcher<GiphyOriginalImage>());
      expect(images.fixedHeight, TypeMatcher<GiphyFullImage>());
      expect(images.looping, TypeMatcher<GiphyLoopingImage>());
      expect(images.originalMp4, TypeMatcher<GiphyPreviewImage>());
      expect(images.previewGif, TypeMatcher<GiphyDownsizedImage>());
      expect(images.w480Still, TypeMatcher<GiphyStillImage>());
    });
  });
}
