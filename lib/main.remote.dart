import "package:universal_html/js.dart" as js;
import 'package:flutter/foundation.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/start_app.dart';

void main() async {
  String apiUrl = "https://api.politechnikagdanska.pl";
  if (kIsWeb) {
    if (js.context['configs'] != null &&
        (js.context['configs'] as js.JsObject)['API_URL'] != null) {
      apiUrl = (js.context['configs'] as js.JsObject)['API_URL'];
    }
  }

  startApp(Config(apiUrl: apiUrl));
}
