import 'package:flutter/cupertino.dart';
import 'package:flutter_base/utils/util.dart';

//Dùng để kiểm tra bộ đếm được hành động
//VD: 3 lần thì đc click 1 cái gì đó
class CheckCountUtil {
  final Function()? onAction;
  final String keySaveCheck;
  final int countCheck;
  final bool isResetCount; //có reset count về 0 nếu quá countCheck không
  String _keySave = "";
  int _count = 0;

  CheckCountUtil({
    this.onAction,
    required this.keySaveCheck,
    required this.countCheck,
    this.isResetCount = true,
  }) {
    _keySave = "_count_check_$keySaveCheck";
  }

  Future onStart() async {
    await PreferUtil.createInt(_keySave, 0);
    _count = await PreferUtil.getInt(_keySave) ?? 0;
    debugPrint("check_count_$keySaveCheck : $_count");
    if (_count >= countCheck) {
      onAction?.call();
      if (isResetCount) {
        _count = 0;
        await PreferUtil.setInt(_keySave, 0);
      }
    } else {
      _count++;
      await PreferUtil.setInt(_keySave, _count);
    }
  }
}
