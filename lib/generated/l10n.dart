// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Shivani Bagal`
  String get homePage_userName {
    return Intl.message(
      'Shivani Bagal',
      name: 'homePage_userName',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Route`
  String get wrongRoute_message_error {
    return Intl.message(
      'Wrong Route',
      name: 'wrongRoute_message_error',
      desc: '',
      args: [],
    );
  }

  /// `Back To Top`
  String get button_backToTop {
    return Intl.message(
      'Back To Top',
      name: 'button_backToTop',
      desc: '',
      args: [],
    );
  }

  /// `-------`
  String get field_emptyTextData {
    return Intl.message(
      '-------',
      name: 'field_emptyTextData',
      desc: '',
      args: [],
    );
  }

  /// `{fieldName} is required`
  String formField_error_isEmpty(Object fieldName) {
    return Intl.message(
      '$fieldName is required',
      name: 'formField_error_isEmpty',
      desc: '',
      args: [fieldName],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
