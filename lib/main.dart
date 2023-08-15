import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_user_list/i18n/i18n.dart';
import 'package:flutter_user_list/modules/users/screens/users_screen.dart';
import 'package:flutter_user_list/presentation/theme/scale.dart';
import 'package:flutter_user_list/utils/theme_data_provider.dart';
import 'package:flutter_user_list/utils/theme_mode_value_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

// select field for status

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Scale.setup(
      screenSize: MediaQuery.of(context).size,
      designSize: const Size(360, 640),
    );
    final isDarkMode = ref.watch(themeModeValueProvider);

    return CustomTheme(
      isDarkMode: isDarkMode,
      child: Builder(
        builder: (context) {
          return I18n(
            builder: (context, locale, localizationsDelegates, supportedLocales, initializeAppContext) {
              return MaterialApp(
                title: 'Users List',
                theme: CustomTheme.of(context).theme,
                locale: locale,
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                home: Builder(
                  builder: (context) {
                    initializeAppContext(context);
                    return const UsersScreen();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
