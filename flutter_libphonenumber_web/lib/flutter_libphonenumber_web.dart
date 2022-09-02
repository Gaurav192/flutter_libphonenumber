import 'dart:async';

import 'src/libphonenumber_js.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:flutter_libphonenumber_platform_interface/flutter_libphonenumber_platform_interface.dart';

import 'src/intl_js.dart';

/// An implementation of [FlutterLibphonenumberPlatform] that uses method channels.
class FlutterLibphonenumber extends FlutterLibphonenumberPlatform {
  static void registerWith(Registrar registrar) {
    FlutterLibphonenumberPlatform.instance = FlutterLibphonenumber();
  }

  @override
  Future<Map<String, String>> format(String phone, String region) async {
    final formatter = AsYouTypeFormatter(region);
    final number = formatter.inputDigit(phone);
    return {'formatted': number ?? ''};
  }

  @override
  Future<Map<String, dynamic>> getAllSupportedRegions() async {
    final regions = <String, dynamic>{};
    final phoneUtil = PhoneNumberUtil.getInstance();

    for (final region in phoneUtil.getSupportedRegions()) {
      final details = <String, dynamic>{};
      final phoneNumber = phoneUtil.getExampleNumberForType(
          region, PhoneNumberType.mobile.value);
      final fixedLineNumber = phoneUtil.getExampleNumberForType(
          region, PhoneNumberType.fixedLine.value);
      details['phoneCode'] =
          phoneUtil.getCountryCodeForRegion(region).toString();
      if (phoneNumber != null) {
        details["exampleNumberMobileNational"] =
            phoneUtil.format(phoneNumber, PhoneNumberFormat.national.value);
        details["exampleNumberMobileInternational"] = phoneUtil.format(
            phoneNumber, PhoneNumberFormat.international.value);
        details["phoneMaskMobileNational"] = maskNumber(
            phoneUtil.format(phoneNumber, PhoneNumberFormat.national.value));
        details["phoneMaskMobileInternational"] = maskNumber(phoneUtil.format(
            phoneNumber, PhoneNumberFormat.international.value));
      }
      if (fixedLineNumber != null) {
        details["exampleNumberFixedLineNational"] =
            phoneUtil.format(fixedLineNumber, PhoneNumberFormat.national.value);

        details["phoneMaskFixedLineNational"] = maskNumber(phoneUtil.format(
            fixedLineNumber, PhoneNumberFormat.national.value));

        details["exampleNumberFixedLineInternational"] = phoneUtil.format(
            fixedLineNumber, PhoneNumberFormat.international.value);
        details["phoneMaskFixedLineInternational"] = maskNumber(phoneUtil
            .format(fixedLineNumber, PhoneNumberFormat.international.value));
      }
      details["countryName"] =
          DisplayNames("en", Options(type: 'region')).of(region);
      regions[region] = details;
    }
    return regions;
  }

  @override
  Future<Map<String, dynamic>> parse(String phone, {String? region}) async {
    final phoneUtil = PhoneNumberUtil.getInstance();
    final phoneNumber = phoneUtil.parseAndKeepRawInput(phone, region);

    if (phoneNumber != null && phoneUtil.isValidNumber(phoneNumber)) {
      final info = <String, dynamic>{};
      info['type'] =
          PhoneNumberType.fromValue(phoneUtil.getNumberType(phoneNumber)).name;
      info['e164'] =
          phoneUtil.format(phoneNumber, PhoneNumberFormat.e164.value);
      info['international'] =
          phoneUtil.format(phoneNumber, PhoneNumberFormat.international.value);
      info['national'] =
          phoneUtil.format(phoneNumber, PhoneNumberFormat.national.value);
      info['country_code'] = phoneNumber.getCountryCode().toString();
      info['national_number'] = phoneNumber.getNationalNumber().toString();
      return info;
    } else {
      throw Exception('Invalid Number');
    }
  }

  String maskNumber(String number) => number.replaceAll(RegExp(r'\d'), "0");
}
