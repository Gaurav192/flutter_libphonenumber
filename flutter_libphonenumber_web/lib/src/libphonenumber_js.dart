// ignore_for_file: non_constant_identifier_names

@JS('libphonenumber')
library libphonenumber;

import 'package:js/js.dart';

@JS()
@anonymous
class PhoneNumberUtil {
  external static PhoneNumberUtil getInstance();
  external List<String> getSupportedRegions();
  external PhoneNumber? getExampleNumberForType(
      String regionCode, /* PhoneNumberType */ int type);
  external int getCountryCodeForRegion(String region);
  external bool isValidNumber(PhoneNumber number);
  external String format(
      PhoneNumber phoneNumber, /* PhoneNumberFormat */ int format);
  external PhoneNumber? parseAndKeepRawInput(String number, String? regionCode);
  external /* PhoneNumberType */ int getNumberType(PhoneNumber phoneNumber);
}

@JS()
class AsYouTypeFormatter {
  external factory AsYouTypeFormatter(String region);
  external String? inputDigit(String digit);
  external void clear();
}

@JS()
@anonymous
class PhoneNumber {
  external int getCountryCode();
  external int getCountryCodeOrDefault();
  external void setCountryCode(int value);
  external bool hasCountryCode();
  external int countryCodeCount();
  external void clearCountryCode();
  external int? getNationalNumber();
  external int? getNationalNumberOrDefault();
  external int setNationalNumber(int value);
  external bool hasNationalNumber();
  external int nationalNumberCount();
  external void clearNationalNumber();

  external String? getExtension();
  external String getExtensionOrDefault();
  external void setExtension(String value);
  external bool hasExtension();
  external int extensionCount();
  external void clearExtension();
}

enum PhoneNumberFormat {
  e164(0),
  international(1),
  national(2),
  rfc3966(3);

  const PhoneNumberFormat(this.value);
  final int value;
}

enum PhoneNumberType {
  fixedLine(0),
  mobile(1),
  fixedOrMobile(2),
  notParsed(3),
  premiumRate(4),
  sharedCost(5),
  voip(6),
  personalNumber(7),
  pager(8),
  uan(9),
  voicemail(10),
  unknown(-1);

  const PhoneNumberType(this.value);
  final int value;

  factory PhoneNumberType.fromValue(int value) =>
      PhoneNumberType.values.firstWhere((e) => e.value == value,
          orElse: () => PhoneNumberType.unknown);
}
