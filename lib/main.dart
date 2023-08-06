import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    return MaterialApp(
        title: 'Users List',
        theme: ref.watch(customThemeProvider).getAppTheme(context, isDarkMode),
        home: const UsersScreen());
  }
}
