import 'package:flutter/material.dart';
import 'package:flutter_user_list/models/field/field_type.dart';
import 'package:flutter_user_list/presentation/theme/scale.dart';
import 'package:flutter_user_list/presentation/widgets/input_field/input_field_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme extends InheritedWidget {
  const CustomTheme({Key? key, required Widget child, required this.isDarkMode}) : super(child: child, key: key);
  final bool isDarkMode;

  @override
  bool updateShouldNotify(CustomTheme oldWidget) => oldWidget.isDarkMode != isDarkMode;

  static CustomTheme of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<CustomTheme>()!;

  static const darkModeDarkBlue = Color.fromARGB(255, 12, 19, 79);
  static const darkModeLightBlue = Color.fromARGB(255, 29, 38, 125);
  static const darkModeDarkPurple = Color.fromARGB(255, 92, 70, 156);
  static const darkModeLightPurple = Color.fromARGB(255, 212, 173, 252);

  static const lightModeDarkBlue = Color.fromARGB(255, 114, 134, 211);
  static const lightModeLightBlue = Color.fromARGB(255, 142, 167, 233);
  static const lightModeLightPurple = Color.fromARGB(255, 229, 224, 255);
  static const lightModeCreamWhite = Color.fromARGB(255, 255, 242, 242);

  static const grayDark = Color(0xFFBCBCBC);
  static const grayLight = Color(0xFFDADADA);

  static const redLight = Color.fromARGB(255, 253, 53, 77);
  static const redDark = Color(0xFFDC0018);

  Color get primary => isDarkMode ? darkModeDarkBlue : lightModeDarkBlue;
  Color get disabledColor => isDarkMode ? grayDark : grayLight;

  TextStyle get h1 => GoogleFonts.roboto(fontSize: 96.hs, height: 1.1, fontWeight: FontWeight.w100);
  TextStyle get h2 => GoogleFonts.roboto(fontSize: 60.hs, height: 1.2, fontWeight: FontWeight.w100);
  TextStyle get h3 => GoogleFonts.roboto(fontSize: 36.hs, height: 1.1, fontWeight: FontWeight.w100);
  TextStyle get h4 => GoogleFonts.roboto(fontSize: 30.hs, height: 1.2, fontWeight: FontWeight.w500);
  TextStyle get h5 => GoogleFonts.roboto(fontSize: 24.hs, height: 1.3, fontWeight: FontWeight.w500);
  TextStyle get h6 => GoogleFonts.roboto(fontSize: 20.hs, height: 1.3, fontWeight: FontWeight.w500);
  TextStyle get subtitle1 => GoogleFonts.roboto(fontSize: 12.hs, height: 1.4, fontWeight: FontWeight.w500);
  TextStyle get subtitle2 => GoogleFonts.roboto(fontSize: 12.hs, height: 1.4, fontWeight: FontWeight.w300);
  TextStyle get bodyText1 => GoogleFonts.roboto(fontSize: 16.hs, height: 1.4, fontWeight: FontWeight.normal);
  TextStyle get bodyText2 => GoogleFonts.roboto(fontSize: 12.hs, height: 1.4, fontWeight: FontWeight.normal);
  TextStyle get button => GoogleFonts.roboto(fontSize: 14.hs, height: 1.35, fontWeight: FontWeight.w500);
  TextStyle get caption => GoogleFonts.roboto(fontSize: 12.hs, height: 1.45, fontWeight: FontWeight.normal);
  TextStyle get overline => GoogleFonts.roboto(fontSize: 12.hs, height: 1.45, fontWeight: FontWeight.w500);

  Color get scaffoldBackground => isDarkMode ? darkModeDarkBlue : lightModeLightBlue;
  Color get iconColor => isDarkMode ? Colors.white : Colors.black;
  Color get appBarBackground => isDarkMode ? darkModeDarkBlue : lightModeDarkBlue;
  Color get cardBackground => isDarkMode ? darkModeLightBlue : lightModeLightPurple;
  Color get dialogBackground => isDarkMode ? darkModeDarkPurple : lightModeLightBlue;
  Color get buttonBackground => isDarkMode ? darkModeLightBlue : lightModeDarkBlue;
  Color get onBackground => isDarkMode ? Colors.white : Colors.black;
  Color get error => isDarkMode ? redLight : redDark;

  ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: scaffoldBackground,
        // textTheme: Theme.of(context)
        //     .textTheme
        //     .copyWith(
        //       titleSmall: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 11),
        //     )
        //     .apply(
        //       bodyColor: isDarkMode ? Colors.white : Colors.black,
        //       displayColor: Colors.grey,
        //     ),
        listTileTheme: ListTileThemeData(iconColor: iconColor),
        appBarTheme: AppBarTheme(
            backgroundColor: appBarBackground,
            titleTextStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black, fontSize: 20),
            iconTheme: IconThemeData(color: iconColor)),
        cardTheme: CardTheme(
          color: cardBackground,
        ),
        dialogTheme: DialogTheme(
          backgroundColor: dialogBackground,
          titleTextStyle: const TextStyle(
            fontSize: 16,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: buttonBackground,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonBackground,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDarkMode ? const Color.fromARGB(100, 29, 38, 125) : Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isDarkMode ? const Color.fromARGB(100, 29, 38, 125) : Colors.black,
            ),
          ),
        ),
      );

  InputFieldTheme getInputFieldTheme(FieldType fieldType) {
    final selectFieldInsets = EdgeInsets.only(top: 12.hs, left: 15.hs);

    return InputFieldTheme(
      textStyle: InputFieldStateProperty(
        active: bodyText2.copyWith(color: onBackground),
        disabled: bodyText2.copyWith(color: disabledColor),
      ),
      labelStyle: InputFieldStateProperty(
        active: TextStyle(color: onBackground),
        focused: TextStyle(color: primary),
        disabled: TextStyle(color: disabledColor),
        error: TextStyle(color: error),
      ),
      border: InputFieldStateProperty(
        active: createInputBorder(color: onBackground),
        focused: createInputBorder(color: primary),
        disabled: createInputBorder(color: disabledColor),
        error: createInputBorder(color: error),
      ),
      suffixIconStyle: InputFieldIconStyle(
        constraints: BoxConstraints.loose(Size(50.hs, 50.hs)),
        color: InputFieldStateProperty(
          active: onBackground,
          disabled: disabledColor,
        ),
        margin: fieldType.maybeWhen(
          select: () => selectFieldInsets,
          multiSelect: () => selectFieldInsets,
          date: () => EdgeInsets.all(10.hs),
          orElse: () => EdgeInsets.zero,
        ),
      ),
    );
  }
}

UnderlineInputBorder createInputBorder({
  required Color color,
  double width = 1.0,
}) {
  return UnderlineInputBorder(
    borderSide: BorderSide(
      width: width,
      color: color,
    ),
  );
}

extension BuildContextX on BuildContext {
  CustomTheme get appTheme => CustomTheme.of(this);
}
