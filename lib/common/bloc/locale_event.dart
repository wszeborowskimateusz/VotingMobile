part of 'locale_bloc.dart';

abstract class LocaleEvent {
  const LocaleEvent();

  factory LocaleEvent.changeLocale(Locale locale) => _ChangeLocaleEvent(locale);
}

class _ChangeLocaleEvent extends LocaleEvent {
  final Locale locale;
  const _ChangeLocaleEvent(this.locale);
}
