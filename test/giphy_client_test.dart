import 'dart:io';

import 'package:giphy_get/giphy_get.dart';
import 'package:http/http.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockClient extends Mock implements Client {}

void main() {
  var _apiKey = 'your api key here';

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
      expect(gif.title, 'drunk bbc two GIF by BBC');
    });

    test('should load a gif by id', () async {
      final client = GiphyClient(
        apiKey: _apiKey,
        randomId: '',
      );

      final gif = await client.byId('l46Cc0Ped9R0uiTkY');

      expect(gif, TypeMatcher<GiphyGif>());
      expect(gif.title, 'beyonce freedom GIF by BET Awards');
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
      expect(gif.id, 'l49JIgBhX4X6hyCGY');
      expect(gif.slug, 'adweek-water-cary-elwes-l49JIgBhX4X6hyCGY');
      expect(
        gif.url,
        'https://giphy.com/gifs/adweek-water-cary-elwes-l49JIgBhX4X6hyCGY',
      );
      expect(gif.bitlyGifUrl, 'https://gph.is/2EVgGCt');
      expect(gif.bitlyUrl, 'https://gph.is/2EVgGCt');
      expect(gif.embedUrl, 'https://giphy.com/embed/l49JIgBhX4X6hyCGY');
      expect(gif.username, 'adweek');
      expect(gif.source, '');
      expect(gif.rating, 'g');
      expect(gif.contentUrl, '');
      expect(gif.sourceTld, '');
      expect(gif.sourcePostUrl, '');
      expect(gif.isSticker, 0);
      expect(gif.importDatetime, DateTime.parse('2018-01-04 18:58:22'));
      expect(gif.trendingDatetime, DateTime.parse('2018-04-27 23:15:01'));
      expect(gif.title, 'cary elwes water GIF by ADWEEK');
    });

    test('should parse users correctly', () async {
      final client = GiphyClient(
        apiKey: _apiKey,
        randomId: '',
      );

      // Gif Validation
      final user = (await client.trending()).data!.first.user;
      expect(user!.avatarUrl,
          'https://media2.giphy.com/avatars/adweek/iLI6u94qEbnR.jpg');
      expect(user.bannerUrl,
          'https://media2.giphy.com/avatars/adweek/UJKiOn3S78hf.gif');
      expect(user.profileUrl, 'https://giphy.com/adweek/');
      expect(user.username, 'adweek');
      expect(user.displayName, 'ADWEEK');
      expect(user.twitter, '@adweek');
      expect(user.guid, 'YWxmcmVkLm1hc2tlcm9uaUBhZHdlZWsuY29t');
      expect(user.metadataDescription, 'The best GIFs in advertising.');
      expect(user.attributionDisplayName, 'ADWEEK');
      expect(user.name, 'ADWEEK');
      expect(
        user.description,
        'Welcome to Adweek on Giphy. The best advertising GIFs on the internet. Need a GIF from an ad? Hit us up on Twitter.',
      );
      expect(user.facebookUrl, 'https://www.facebook.com/Adweek');
      expect(user.twitterUrl, 'https://twitter.com/adweek');
      expect(user.instagramUrl, 'https://instagram.com/adweek');
      expect(user.tumblrUrl, 'https://adweekmag.tumblr.com/');
      expect(user.suppressChrome, false);
      expect(user.websiteUrl, 'https://adweek.com/');
      expect(user.websiteDisplayUrl, 'adweek.com');
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
