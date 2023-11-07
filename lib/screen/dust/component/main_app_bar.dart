import 'package:flutter/material.dart';
import 'package:flutter_first/screen/dust/model/stat_model.dart';
import 'package:flutter_first/screen/dust/model/status_model.dart';
import 'package:flutter_first/screen/dust/utill/data_util.dart';

import '../../../constant/color.dart';

class MainAppBar extends StatelessWidget {
  final String region;
  final StatusModel status;
  final StatModel stat;

  const MainAppBar({super.key, required this.status, required this.stat, required this.region});

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(color: Colors.white, fontSize: 30);

    return SliverAppBar(
      backgroundColor: status.primaryColor,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: kToolbarHeight),
            child: Column(
              children: [
                Text(region,
                    style:
                        ts.copyWith(fontSize: 40, fontWeight: FontWeight.w700)),
                SizedBox(height: 20),
                Text(
                  DataUtils.getTimeFromDateTime(dateTime: stat.dataTime),
                  style: ts,
                ),
                SizedBox(height: 20),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(height: 20),
                Text(status.label,
                    style:
                        ts.copyWith(fontSize: 40, fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Text(status.comment,
                    style:
                        ts.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ),
    );
  }


  

}
