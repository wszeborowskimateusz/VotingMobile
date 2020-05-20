import 'package:get_it/get_it.dart';
import 'package:votingmobile/common/backend/user_repository.dart';
import 'package:votingmobile/localization/translations_delegate.dart';

GetIt locator = GetIt.instance;

void registerDependencies() {
  locator.registerLazySingleton<UserRepository>(() => UserRepository());
  locator.registerLazySingleton<TranslationsDelegate>(() => TranslationsDelegate());
}