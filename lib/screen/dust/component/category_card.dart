import 'package:flutter/material.dart';
import 'package:flutter_first/screen/dust/component/card_title.dart';
import 'package:flutter_first/screen/dust/component/main_card.dart';

import '../../../constant/color.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        child: LayoutBuilder(builder: (context, constraint) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardTitle(title: '종류별 통계'),
              Expanded(
                child: ListView(
                  physics: PageScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    20,
                    (index) => MainStat(
                      category: "미세먼지$index",
                      imgPath: "asset/img/best.png",
                      level: "최고",
                      stat: "0㎍/㎥",
                      width: constraint.maxWidth / 3,
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
