import 'package:simplest/simplest.dart';

import 'config.dart';

@LazySingleton(as: IAppConfig)
class AppConfig extends IAppConfig {
  @override
  String get appName => kAppName;

  @override
  String get baseUrl => BASE_URL;

  @override
  String get env => 'dev';
}
