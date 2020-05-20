import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/localization/translations_delegate.dart';

part 'locale_state.dart';
part 'locale_event.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  @override
  LocaleState get initialState => LocaleState.initial();

  @override
  Stream<LocaleState> mapEventToState(LocaleEvent event) async* {
    if(event is _ChangeLocaleEvent) {
      locator.get<TranslationsDelegate>().load(event.locale);
      yield LocaleState.select(event.locale);
    }
  }

}