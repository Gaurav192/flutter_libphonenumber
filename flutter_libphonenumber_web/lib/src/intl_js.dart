@JS('Intl')
library intl;

import 'package:js/js.dart';

@JS()
class DisplayNames {
  external factory DisplayNames(String locale, Options options);
  external String of(String code);
}


@JS()
@anonymous
class Options {
  external String get type;
  external factory Options({String type});
}