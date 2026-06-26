import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_sizes.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xffFFFFFF),
    secondary: Color(0XFF161F1B),
  ),
  scaffoldBackgroundColor: Color(0xffF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffF6F7F9),
    titleTextStyle: TextStyle(color: Color(0xff161F1B), fontSize: AppSizes.sp20),
    iconTheme: IconThemeData(color: Color(0xff161F1B)),
    centerTitle: true,
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
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      return Color(0xff9E9E9E);
    }),

    trackOutlineWidth: WidgetStateProperty.all(2),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xff15B86C),
      foregroundColor: Color(0xffFFFCFC),
      textStyle: TextStyle(fontSize: AppSizes.sp14, fontWeight: FontWeight.w500),
      minimumSize: Size.fromHeight(AppSizes.h40),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0xff161F1B)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: (Color(0xff15B86C)),
    foregroundColor: (Color(0xffFFFCFC)),
    extendedTextStyle: TextStyle(fontSize: AppSizes.sp14, fontWeight: FontWeight.w500),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: AppSizes.sp24,
      color: Color(0XFF161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize:  AppSizes.sp28,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize:  AppSizes.sp32,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xff161F1B),
      fontSize:  AppSizes.sp14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xff161F1B),
      fontSize:  AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: Color(0xff6A6A6A),
      fontSize:  AppSizes.sp16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff6A6A6A),
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(color: Color(0XFF161F1B), fontSize:  AppSizes.sp16),
    labelMedium: TextStyle(color: Color(0XFF161F1B), fontSize:  AppSizes.sp24),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0XFF9E9E9E)),
    filled: true,
    fillColor: Color(0XFFFFFFFF),
    focusColor: Color(0xffD1DAD6),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xffD1DAD6), width: AppSizes.w2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(AppSizes.r4),
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xff161F1B)),
  dividerTheme: DividerThemeData(color: Color(0xffD1DAD6)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(color: Color(0XFF161F1B), fontSize: AppSizes.sp20),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.blueAccent,
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xffF6F7F9),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xff3A4640),
    selectedItemColor: Color(0xff15B86C),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xffF6F7F9),
    elevation: 5,
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(16),
    ),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: AppSizes.sp20, fontWeight: FontWeight.w400, color: Colors.black),
    ),
  ),
);
