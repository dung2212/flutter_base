import 'package:flutter/material.dart';
import 'package:FlutterBase/Utils/Util.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionItemHouseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
          ResourceUtil.hexToColor('4C4B5D').withAlpha(32),
          ResourceUtil.hexToColor('AFAFB7').withAlpha(4),
        ])),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SvgPicture.asset(
              ResourceUtil.icon('ic_compare.svg'),
              height: 18,
            ),
            SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              ResourceUtil.icon('ic_note_item.svg'),
              height: 18,
            ),
            SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              ResourceUtil.icon('ic_favorite_item.svg'),
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}
