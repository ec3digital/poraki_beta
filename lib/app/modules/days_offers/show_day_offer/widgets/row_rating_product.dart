import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../../theme/app_theme.dart';

class RowRatingProduct extends StatelessWidget {

  final String voteRatingUsers;

  const RowRatingProduct({Key? key, required this.voteRatingUsers,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          itemSize: 12,
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: AppColors.primaryColor,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        const SizedBox(width: 08),
        Text(
          voteRatingUsers,
          style: Get.textTheme.bodyText1!.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.darkText,
          ),
        )
      ],
    );
  }
}
