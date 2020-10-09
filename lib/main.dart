import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/start_app.dart';

void main() async {
  startApp(Config(apiUrl: "http://192.168.99.100:8082"));
}
