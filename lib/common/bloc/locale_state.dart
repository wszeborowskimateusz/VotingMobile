part of 'locale_bloc.dart';

class LocaleState extends Equatable {
  final Locale selectedLocale;

  LocaleState._({this.selectedLocale});

  factory LocaleState.initial() => LocaleState._();

  factory LocaleState.select(Locale locale) => LocaleState._(selectedLocale: locale);

  @override
  List<Object> get props => [selectedLocale];
}
