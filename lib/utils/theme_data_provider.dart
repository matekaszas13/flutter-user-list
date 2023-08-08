import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_data_provider.g.dart';

@riverpod
CustomTheme customTheme(CustomThemeRef ref) => CustomTheme(ref);

class CustomTheme {
  CustomTheme(this.ref);

  final Ref ref;

  ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme
          ? const Color.fromARGB(255, 12, 19, 79)
          : const Color.fromARGB(255, 142, 167, 233),
      textTheme: Theme.of(context)
          .textTheme
          .copyWith(
            titleSmall:
                Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 11),
          )
          .apply(
            bodyColor: isDarkTheme ? Colors.white : Colors.black,
            displayColor: Colors.grey,
          ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(
            isDarkTheme ? Colors.orange : Colors.purple),
      ),
      listTileTheme: ListTileThemeData(
          iconColor: isDarkTheme
              ? const Color.fromARGB(100, 212, 173, 252)
              : Colors.black),
      appBarTheme: AppBarTheme(
          backgroundColor: isDarkTheme
              ? const Color.fromARGB(100, 12, 19, 79)
              : const Color.fromARGB(255, 114, 133, 211),
          titleTextStyle: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black, fontSize: 20),
          iconTheme:
              IconThemeData(color: isDarkTheme ? Colors.white : Colors.black)),
      cardTheme: CardTheme(
        color: isDarkTheme
            ? const Color.fromARGB(100, 29, 38, 125)
            : const Color.fromARGB(255, 229, 224, 255),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: isDarkTheme
            ? const Color.fromARGB(255, 92, 70, 156)
            : const Color.fromARGB(255, 142, 167, 233),
        titleTextStyle: const TextStyle(
          fontSize: 16,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: isDarkTheme
              ? const Color.fromARGB(143, 29, 39, 125)
              : const Color.fromARGB(148, 142, 167, 233),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: isDarkTheme
                ? const Color.fromARGB(181, 29, 39, 125)
                : const Color.fromARGB(255, 142, 166, 233),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkTheme
                ? const Color.fromARGB(100, 29, 38, 125)
                : Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkTheme
                ? const Color.fromARGB(100, 29, 38, 125)
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
