import 'package:get_it/get_it.dart';
import 'package:votingmobile/common/backend/locale_repository.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/http/http_client.dart';
import 'package:votingmobile/login/backend/user_authentication_api.dart';
import 'package:votingmobile/login/backend/user_repository.dart';
import 'package:votingmobile/localization/translations_delegate.dart';
import 'package:votingmobile/voting/backend/votings_api.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';

GetIt locator = GetIt.instance;

Future<void> registerDependencies(Config config) async {
  locator.registerLazySingleton<Config>(() => config);

  final httpClient = CommonHttpClient();
  await httpClient.init();
  final localeRepository = LocaleRepository();
  await localeRepository.init();

  locator.registerLazySingleton<CommonHttpClient>(() => httpClient);
  locator.registerLazySingleton<VotingsApi>(() => VotingsApi());
  locator.registerLazySingleton<UserAuthenticationApi>(
      () => UserAuthenticationApi());
  locator.registerLazySingleton<UserRepository>(() => UserRepository());
  locator.registerLazySingleton<VotingsRepository>(() => VotingsRepository());
  locator.registerLazySingleton<LocaleRepository>(() => localeRepository);
  locator.registerLazySingleton<TranslationsDelegate>(
      () => TranslationsDelegate());
}
