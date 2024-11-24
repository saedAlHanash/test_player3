import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../models/vimeo_models.dart';
import 'dailymotion_response.dart';

String podErrorString(String val) {
  return '*\n------error------\n\n$val\n\n------end------\n*';
}

class VideoApis {
  static Future<Response> _makeRequestHash(String videoId, String? hash) {
    if (hash == null) {
      return http.get(
        Uri.parse('https://player.vimeo.com/video/$videoId/config'),
      );
    } else {
      return http.get(
        Uri.parse('https://player.vimeo.com/video/$videoId/config?h=$hash'),
      );
    }
  }

  static Future<List<VideoQalityUrls>?> getVimeoVideoQualityUrls(
    String videoId,
    String? hash,
  ) async {
    try {
      final response = await _makeRequestHash(videoId, hash);
      final jsonData = jsonDecode(response.body)['request']['files'];
      final dashData = jsonData['dash'];
      final hlsData = jsonData['hls'];
      final defaultCDN = hlsData['default_cdn'];
      final cdnVideoUrl = (hlsData['cdns'][defaultCDN]['url'] as String?) ?? '';
      final List<dynamic> rawStreamUrls =
          (dashData['streams'] as List<dynamic>?) ?? <dynamic>[];

      final List<VideoQalityUrls> vimeoQualityUrls = [];

      for (final item in rawStreamUrls) {
        final sepList = cdnVideoUrl.split('/sep/video/');
        final lastUrlPiece =
            ((sepList.lastOrNull ?? '').split('/').lastOrNull) ??
                (sepList.lastOrNull ?? '');
        final String urlId =
            ((item['id'] ?? '') as String).split('-').firstOrNull ?? '';
        vimeoQualityUrls.add(
          VideoQalityUrls(
            quality: int.parse(
              (item['quality'] as String?)?.split('p').first ?? '0',
            ),
            url: cdnVideoUrl,
          ),
        );
      }
      if (vimeoQualityUrls.isEmpty) {
        vimeoQualityUrls.add(
          VideoQalityUrls(
            quality: 720,
            url: cdnVideoUrl,
          ),
        );
      }

      return vimeoQualityUrls;
    } catch (error) {
      if (error.toString().contains('XMLHttpRequest')) {
        log(
          podErrorString(
            '(INFO) To play vimeo video in WEB, Please enable CORS in your browser',
          ),
        );
      }
      debugPrint('===== VIMEO API ERROR: $error ==========');
      rethrow;
    }
  }

  static Future<List<VideoQalityUrls>?> getVimeoPrivateVideoQualityUrls(
    String videoId,
    Map<String, String> httpHeader,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.vimeo.com/videos/$videoId'),
        headers: httpHeader,
      );
      final jsonData =
          (jsonDecode(response.body)['files'] as List<dynamic>?) ?? [];

      final List<VideoQalityUrls> list = [];

      for (int i = 0; i < jsonData.length; i++) {
        final String quality =
            (jsonData[i]['rendition'] as String?)?.split('p').first ?? '0';
        final int? number = int.tryParse(quality);
        if (number != null && number != 0) {
          list.add(
            VideoQalityUrls(
              quality: number,
              url: jsonData[i]['link'] as String,
            ),
          );
        }
      }
      return list;
    } catch (error) {
      if (error.toString().contains('XMLHttpRequest')) {
        log(
          podErrorString(
            '(INFO) To play vimeo video in WEB, Please enable CORS in your browser',
          ),
        );
      }
      debugPrint('===== VIMEO API ERROR: $error ==========');
      rethrow;
    }
  }

  static Future<List<VideoQalityUrls>?> getYoutubeVideoQualityUrls(
    String youtubeIdOrUrl,
    bool live,
  ) async {
    try {
      final yt = YoutubeExplode();
      final urls = <VideoQalityUrls>[];
      if (live) {
        final url = await yt.videos.streamsClient.getHttpLiveStreamUrl(
          VideoId(youtubeIdOrUrl),
        );
        urls.add(
          VideoQalityUrls(
            quality: 360,
            url: url,
          ),
        );
      } else {
        final manifest =
            await yt.videos.streamsClient.getManifest(youtubeIdOrUrl);
        urls.addAll(
          manifest.muxed.map(
            (element) => VideoQalityUrls(
              quality: int.parse(element.qualityLabel.split('p')[0]),
              url: element.url.toString(),
            ),
          ),
        );
      }
      // Close the YoutubeExplode's http client.
      yt.close();
      return urls;
    } catch (error) {
      if (error.toString().contains('XMLHttpRequest')) {
        log(
          podErrorString(
            '(INFO) To play youtube video in WEB, Please enable CORS in your browser',
          ),
        );
      }
      debugPrint('===== YOUTUBE API ERROR: $error ==========');
      rethrow;
    }
  }

  static Future<List<VideoQalityUrls>?> getDailymotionVideoQualityUrls(
    String vId,
    String token,
  ) async {
    try {
      final urls = <VideoQalityUrls>[];
      final response = await http.get(
        Uri.parse(
          'https://api.dailymotion.com/video/$vId?fields=stream_h264_hd_url,stream_h264_hq_url,stream_h264_qhd_url,stream_h264_l2_url,stream_h264_l1_url,stream_h264_hd1080_url,stream_h264_url',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'Application/json',
        },
      );
      final json = jsonDecode(response.body);
      if (json['stream_h264_hd1080_url'] != null) {
        urls.add(
          VideoQalityUrls(
              quality: 1080, url: json['stream_h264_hd1080_url'].toString()),
        );
      }
      if (json['stream_h264_hd_url'] != null) {
        urls.add(
          VideoQalityUrls(
              quality: 720, url: json['stream_h264_hd_url'].toString()),
        );
      }
      if (json['stream_h264_hq_url'] != null) {
        urls.add(
          VideoQalityUrls(
              quality: 480, url: json['stream_h264_hq_url'].toString()),
        );
      }
      if (json['stream_h264_qhd_url'] != null) {
        urls.add(
          VideoQalityUrls(
              quality: 360, url: json['stream_h264_qhd_url'].toString()),
        );
      }
      if (json['stream_h264_l2_url'] != null) {
        urls.add(
          VideoQalityUrls(
              quality: 240, url: json['stream_h264_l2_url'].toString()),
        );
      }
      if (json['stream_h264_url'] != null) {
        urls.add(
          VideoQalityUrls(
              quality: 144, url: json['stream_h264_url'].toString()),
        );
      }
      return urls;
    } catch (error) {
      if (error.toString().contains('XMLHttpRequest')) {
        log(
          podErrorString(
            '(INFO) To play youtube video in WEB, Please enable CORS in your browser',
          ),
        );
      }
      debugPrint('===== YOUTUBE API ERROR: $error ==========');
      rethrow;
    }
  }

  static Future<List<VideoQalityUrls>?> getDailymotionVideoQualityM3U8Urls(
    String vId,
  ) async {
    try {
      final urls = <VideoQalityUrls>[];
      final response = await http.get(
        Uri.parse(
          'https://www.dailymotion.com/player/metadata/video/$vId',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'Application/json',
        },
      );

      final result = DailymotionResponse.fromJson(jsonDecode(response.body));
      final f = await http.get(
        Uri.parse(result.qualities?.auto.firstOrNull?.url ?? ''),
      );
      final s = f.body;
      // Regular expression to match EXT-X-STREAM-INF lines and URLs
      RegExp pattern = RegExp(
          r'#EXT-X-STREAM-INF:[^\n]+,NAME="(\d+)"\n(https?://[^\s]+\.m3u8)');

      // Find all matches
      Iterable<RegExpMatch> matches = pattern.allMatches(s);

      // Create the Map to store quality (key) and URL (value)
      Map<String, String> qualityToUrlMap = {};

      // Iterate over matches and populate the map
      for (var match in matches) {
        // Extract the quality (stream resolution) from the metadata
        String quality = match.group(1) ?? '';

        // Extract the URL (second match)
        String url = match.group(2) ?? '';

        // Add the quality and URL to the map
        qualityToUrlMap[quality] = url;
      }

      qualityToUrlMap.forEach(
        (key, value) {
          urls.add(
            VideoQalityUrls(
              quality: int.tryParse(key) ?? 0,
              url: value,
            ),
          );
        },
      );
      return urls;
    } catch (error) {
      if (error.toString().contains('XMLHttpRequest')) {
        log(
          podErrorString(
            '(INFO) To play youtube video in WEB, Please enable CORS in your browser',
          ),
        );
      }
      debugPrint('===== YOUTUBE API ERROR: $error ==========');
      rethrow;
    }
  }
}

//https://api.dailymotion.com/video/k2V1WuTvYVUQC4BT7IE?fields=

//preview_480p_url,
// preview_360p_url,
// preview_240p_url,
// stream_h264_ld_url,
// stream_h264_uhd_url,
// stream_hls_url,
// stream_h264_url,
// stream_h264_qhd_url,
// stream_h264_l2_url,
// stream_h264_l1_url,
// stream_h264_hq_url,
// stream_h264_hd_url,
// stream_h264_hd1080_url
