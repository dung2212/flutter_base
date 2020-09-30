import 'package:FlutterBase/Utils/ResourceUtil.dart';
import 'package:FlutterBase/Utils/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imageLink;
  final double cornerRadius;

  ImageWidget({Key key, this.imageLink = "", this.cornerRadius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(cornerRadius),
      child: FadeInImage.assetNetwork(
          width: double.infinity,
          fit: BoxFit.fill,
          placeholder: ResourceUtil.image("placeholder.png"),
          image: imageLink),
    );
  }
}
