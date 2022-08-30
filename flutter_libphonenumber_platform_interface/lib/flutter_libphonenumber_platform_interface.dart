import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_flutter_libphonenumber.dart';

/// The interface that implementations of flutter_libphonenumber must implement.
///
/// Platform implementations should extend this class rather than implement it as `flutter_libphonenumber`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [FlutterLibphonenumberPlatform] methods.
abstract class FlutterLibphonenumberPlatform extends PlatformInterface {
  /// Constructs a FlutterLibphonenumberPlatform.
  FlutterLibphonenumberPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterLibphonenumberPlatform _instance =
      MethodChannelFlutterLibphonenumber();

  /// The default instance of [FlutterLibphonenumberPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterLibphonenumber].
  static FlutterLibphonenumberPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [FlutterLibphonenumberPlatform] when they register themselves.
  static set instance(FlutterLibphonenumberPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Formats a phone number using platform libphonenumber. Will return the parsed number.
  ///
  /// Example response:
  /// ```
  /// {
  ///   formatted: "1 (414) 444-4444",
  /// }
  /// ```
  Future<Map<String, String>> format(String phone, String region) async {
    throw UnimplementedError('format() has not been implemented.');
  }

  /// Parse a single string and return a map in the format below. Throws an error if the
  /// number is not a valid e164 phone number.
  ///
  /// Given a passed [phone] like '+4930123123123', the response will be:
  /// ```
  /// {
  ///   country_code: 49,
  ///   e164: '+4930123123123',
  ///   national: '030 123 123 123',
  ///   type: 'mobile',
  ///   international: '+49 30 123 123 123',
  ///   national_number: '030123123123',
  /// }
  /// ```
  Future<Map<String, dynamic>> parse(String phone, {String? region}) async {
     throw UnimplementedError('parse() has not been implemented.');
  }

  /// Return all available regions with their country code, phone code, and formatted
  /// example number as a mask. Useful to later format phone numbers using a mask.
  ///
  /// The response will be a [CountryWithPhoneCode]:
  ///
  /// There are some performance considerations for this so you might want to cache the
  /// result and re-use it elsewhere. There's a lot of data to iterate over.
  Future<Map<String, dynamic>> getAllSupportedRegions() async {
     throw UnimplementedError('getAllSupportedRegions() has not been implemented.');
  }
}
