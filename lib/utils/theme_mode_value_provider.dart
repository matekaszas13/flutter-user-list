import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeModeValueProvider =
    StateNotifierProvider<ThemeModeValueProvider, bool>((ref) {
  return ThemeModeValueProvider();
});

class ThemeModeValueProvider extends StateNotifier<bool> {
  ThemeModeValueProvider() : super(false);

  void setThemeMode() {
    state = !state;
  }

  get getThemeMode => state;
}
