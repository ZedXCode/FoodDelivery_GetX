import 'package:flutter/material.dart';
import 'package:food_delivery_getx/utils/colors.dart';
import 'package:food_delivery_getx/widgets/SmallText.dart';

import '../utils/dimentions.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor,size: Dimentions.iconSize24,),
        SizedBox(width: 5,),
        SmallText(text: text,)
      ],
    );
  }
}
