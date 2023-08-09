import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_user_list/i18n/i18n_provider.dart';
import 'package:flutter_user_list/modules/users/screens/users_screen.dart';
import 'package:flutter_user_list/utils/theme_data_provider.dart';
import 'package:flutter_user_list/utils/theme_mode_value_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    final isDarkMode = ref.watch(themeModeValueProvider);

    final locale = ref.watch(i18nProvider.select((locale) => locale));

    return MaterialApp(
      title: 'Users List',
      theme: ref.watch(customThemeProvider).getAppTheme(context, isDarkMode),
      locale: locale,
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            basePath: 'lib/i18n/locales',
          ),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('hu'),
      ],

      home: const UsersScreen(),
      // home: const UsersScreen(),
    );
  }
}
