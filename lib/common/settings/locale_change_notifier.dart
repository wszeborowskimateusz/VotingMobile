import 'package:flutter/widgets.dart';
import 'package:votingmobile/common/backend/locale_repository.dart';
import 'package:votingmobile/common/locator/locator.dart';

class LocaleChangeNotifier extends ChangeNotifier {
  final LocaleRepository _localeRepository = locator.get();

  Locale _selectedLocale;

  LocaleChangeNotifier() {
    _localeRepository.getLocaleFromStorage().then((value) {
      _selectedLocale = value;
    });
  }

  Locale get selectedLocale => _selectedLocale;

  Future<void> changeLocale(Locale newLocale) async {
    _selectedLocale = newLocale;
    await _localeRepository.setLocale(newLocale);
    notifyListeners();
  }
}
