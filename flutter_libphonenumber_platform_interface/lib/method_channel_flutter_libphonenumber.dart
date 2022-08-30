import 'dart:async';

import 'package:flutter/services.dart';

import 'flutter_libphonenumber_platform_interface.dart';

const MethodChannel _channel = MethodChannel('flutter_libphonenumber');

/// An implementation of [FlutterLibphonenumberPlatform] that uses method channels.
class MethodChannelFlutterLibphonenumber extends FlutterLibphonenumberPlatform {
  @override
  Future<Map<String, String>> format(String phone, String region) async {
    return await _channel.invokeMapMethod<String, String>('format', {
          'phone': phone,
          'region': region,
        }) ??
        <String, String>{};
  }

  @override
  Future<Map<String, dynamic>> getAllSupportedRegions() async {
    return (await _channel
            .invokeMapMethod<String, dynamic>('get_all_supported_regions')) ??
        <String, dynamic>{};
  }

  @override
  Future<Map<String, dynamic>> parse(String phone, {String? region}) async {
    return (await _channel
            .invokeMapMethod<String, dynamic>('get_all_supported_regions')) ??
        {};
  }
}
