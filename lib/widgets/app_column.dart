import 'package:flutter/material.dart';
import 'package:food_delivery_getx/utils/colors.dart';
import 'package:food_delivery_getx/utils/dimentions.dart';
import 'package:food_delivery_getx/widgets/BigText.dart';
import 'package:food_delivery_getx/widgets/SmallText.dart';
import 'package:food_delivery_getx/widgets/item_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimentions.font26,),
        SizedBox(
          height: Dimentions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                      (index) => Icon(
                    Icons.star,
                    color: AppColors.mainColor,
                    size: 15,
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(text: '4.5'),
            SizedBox(
              width: 10,
            ),
            SmallText(text: '1287'),
            SizedBox(
              width: 10,
            ),
            SmallText(text: 'comments')
          ],
        ),
        SizedBox(
          height: Dimentions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: 'Normal',
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: '1.7km',
                iconColor: AppColors.mainColor),
            IconAndTextWidget(
                icon: Icons.access_time_rounded,
                text: '32min',
                iconColor: AppColors.iconColor2)
          ],
        )
      ],
    );
  }
}
