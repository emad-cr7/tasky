import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xff282828),
    secondary: Color(0XFFFFFCFC),
  ),
  scaffoldBackgroundColor: Color(0XFF181818),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0XFF181818),
    titleTextStyle: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: AppSizes.sp20,
    ),
    iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
    centerTitle: false,
    scrolledUnderElevation: 0,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xff9E9E9E);
    }),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xff15B86C),
      foregroundColor: Color(0xffFFFCFC),
      textStyle: TextStyle(
        fontSize: AppSizes.sp14,
        fontWeight: FontWeight.w500,
      ),
      minimumSize: Size.fromHeight(AppSizes.h40),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0xffFFFCFC)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: (Color(0xff15B86C)),
    foregroundColor: (Color(0xffFFFCFC)),
    extendedTextStyle: TextStyle(
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w500,
    ),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: AppSizes.sp24,
      color: Color(0XFFFFFCFC),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: AppSizes.sp28,
      color: Color(0XFFFFFFFF),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: AppSizes.sp32,
      color: Color(0XFFFFFFFF),
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: Color(0xffA0A0A0),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xffC6C6C6),
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(color: Color(0XFFFFFCFC), fontSize: AppSizes.sp16),
    labelMedium: TextStyle(color: Color(0XFFFFFCFC), fontSize: AppSizes.sp24),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xff6D6D6D) , fontSize: AppSizes.sp16),
    filled: true,
    fillColor: Color(0xff282828),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xff282828), width: 0.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xff282828), width: 0.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xff6E6E6E), width: AppSizes.w2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(AppSizes.r4),
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xffFFFCFC)),

  dividerTheme: DividerThemeData(color: Color(0xff6E6E6E)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0XFFFFFCFC),
      fontSize: AppSizes.sp20,
    ),
  ),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.blueAccent,
    selectionHandleColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0XFF181818),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xffC6C6C6),
    selectedItemColor: Color(0xff15B86C),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xff282828),
    elevation: 5,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(AppSizes.r16),
    ),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: AppSizes.sp20, fontWeight: FontWeight.w400),
    ),
  ),
);
