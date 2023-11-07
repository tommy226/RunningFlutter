import 'package:flutter/material.dart';
import 'package:flutter_first/constant/color.dart';

import '../../../constant/regions.dart';

typedef OnRegionTap = void Function(String region);

class MainDrawer extends StatelessWidget {
  final OnRegionTap onRegionTap;
  final String selectedRegion;

  const MainDrawer({super.key, required this.onRegionTap, required this.selectedRegion});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: DARK_COLOR,
      child: ListView(
        children: [
          DrawerHeader(child: Text("지역 선택", style:  TextStyle(fontSize: 20, color: Colors.white),)),
          ...regions.map((e) => ListTile(
            tileColor: Colors.white,
            selectedTileColor: LIGHT_COLOR,
            selectedColor: Colors.black,
            selected: e == selectedRegion,
            onTap: (){
              onRegionTap(e);
            },
            title: Text(e),
          )).toList()
        ],
      ),
    );
  }
}
