import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/constant/color.dart';
import 'package:flutter_first/constant/data.dart';
import 'package:flutter_first/constant/regions.dart';
import 'package:flutter_first/constant/status_level.dart';
import 'package:flutter_first/screen/dust/component/card_title.dart';
import 'package:flutter_first/screen/dust/component/category_card.dart';
import 'package:flutter_first/screen/dust/component/hourly_card.dart';
import 'package:flutter_first/screen/dust/component/main_app_bar.dart';
import 'package:flutter_first/screen/dust/component/main_card.dart';
import 'package:flutter_first/screen/dust/component/main_drawer.dart';
import 'package:flutter_first/screen/dust/component/main_stat.dart';
import 'package:flutter_first/screen/dust/model/stat_model.dart';
import 'package:flutter_first/screen/dust/repository/stat_repository.dart';

class DustHomeScreen extends StatefulWidget {
  const DustHomeScreen({super.key});

  @override
  State<DustHomeScreen> createState() => _DustHomeScreenState();
}

class _DustHomeScreenState extends State<DustHomeScreen> {
  String region = regions[0];


  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};

    List<Future> future = [];

    for(ItemCode itemCode in ItemCode.values){
      future.add(
          StatRepository.fetchData(itemCode: itemCode)
      );
    }

    final results = await Future.wait(future);

    for(int i =0; i<results.length; i++){
      final key = ItemCode.values[i];
      final value = results[i];

      stats.addAll({key: value});
    }

    return stats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      drawer: MainDrawer(
        onRegionTap: (String region) {
          setState(() {
            this.region = region;
          });
          Navigator.of(context).pop();
        },
        selectedRegion: region,
      ),
      body: FutureBuilder<Map<ItemCode, List<StatModel>>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("에러가 있습니다"),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            Map<ItemCode, List<StatModel>> stats = snapshot.data!;
            StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

            final status = statusLevel
                .where(
                  (element) => element.minFineDust < pm10RecentStat.seoul,
                )
                .last;
            print(pm10RecentStat.seoul);

            return CustomScrollView(
              slivers: [
                MainAppBar(
                  status: status,
                  stat: pm10RecentStat, region: region,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoryCard(),
                      const SizedBox(height: 16),
                      HourlyCard()
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
