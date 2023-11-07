import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/datebase/drift_database.dart';
import 'package:flutter_first/screen/calendar/calendar_home_screen.dart';
import 'package:flutter_first/screen/dust/dust_home_screen.dart';
import 'package:flutter_first/screen/scrollview/scroll_view_screen.dart';
import 'package:flutter_first/screen/tapbar/tab_bar_home_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

const DEFAULT_COLORS = [
  // 빨강
  'F44336',
  // 주황
  'FF9800',
  // 노랑
  'FFEB3B',
  // 초록
  'FCAF50',
  // 파랑
  '2196F3',
  // 남
  '3F51B5',
  // 보라
  '9C27B0',
];

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // await initializeDateFormatting();
  //
  // final database = LocalDatabase();
  //
  // GetIt.I.registerSingleton<LocalDatabase>(database);
  //
  // final colors = await database.getCategoryColors();
  //
  // if(colors.isEmpty){
  //   for(String hexCode in DEFAULT_COLORS){
  //     await database.createCategoryColor(
  //       CategoryColorsCompanion(
  //         hexCode: Value(hexCode),
  //       ),
  //     );
  //   }
  // }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: "sunflower"
    ),
    home: TabBarHomeScreen(),
    // initialRoute: '/',
    // routes: {
    //   '/' : (context) => NavigationHomeScreen(),
    //   '/one' : (context) => RouteOneScreen(),
    //   '/two' : (context) => RouteTwoScreen(),
    //   '/three' : (context) => RouteThreeScreen(),
    // },
  ));
}


