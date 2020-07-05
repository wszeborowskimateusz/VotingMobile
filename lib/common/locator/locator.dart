import 'package:get_it/get_it.dart';
import 'package:votingmobile/common/backend/locale_repository.dart';
import 'package:votingmobile/login/backend/user_repository.dart';
import 'package:votingmobile/localization/translations_delegate.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';

GetIt locator = GetIt.instance;

Future<void> registerDependencies() async {
  final localeRepository = LocaleRepository();
  await localeRepository.init();
  final userRepository = UserRepository();
  await userRepository.init();
  locator.registerLazySingleton<UserRepository>(() => userRepository);
    locator.registerLazySingleton<VotingsRepository>(() => VotingsRepository());
  locator.registerLazySingleton<LocaleRepository>(() => localeRepository);
  locator.registerLazySingleton<TranslationsDelegate>(
      () => TranslationsDelegate());
}