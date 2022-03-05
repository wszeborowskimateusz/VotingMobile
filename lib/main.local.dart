import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/start_app.dart';

void main() async {
  startApp(Config(apiUrl: "http://localhost:8082"));
}
