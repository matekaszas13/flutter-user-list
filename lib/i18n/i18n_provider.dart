import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_user_list/i18n/i18n.dart';

final i18nProvider = AutoDisposeNotifierProvider<I18nProvider, Locale?>(I18nProvider.new);

class I18nProvider extends AutoDisposeNotifier<Locale?> {
  @override
  Locale? build({Locale? locale}) => locale;

  BuildContext? context;

  Locale get platformLocale => Locale(Platform.localeName.substring(0, 2));

  void initializeAppContext(BuildContext context) {
    this.context = context;
  }

  Future setLocale(Locale? locale) async {
    assert(context != null, "context is not set in I18nProvider");
    await FlutterI18n.refresh(context!, locale);
    state = locale;
  }

  Locale getCurrentLocale() {
    assert(context != null, "context is not set in I18nProvider");
    return FlutterI18n.currentLocale(context!) ?? const Locale('de');
  }

  String tr(String key) {
    return context?.tr(key) ?? "context is not set in I18nProvider, so cannot retrieve translation for $key";
  }
}

// extension I18nContextExtension on BuildContext {
//   String tr(String key, {int? count, Map<String, String>? params}) {
//     if (count != null) {
//       return FlutterI18n.plural(this, key, count);
//     }
//     return FlutterI18n.translate(this, key, translationParams: params);
//   }
// }
