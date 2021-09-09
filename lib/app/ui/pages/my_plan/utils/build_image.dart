import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;

class BuildImage extends StatelessWidget {
  const BuildImage({required Key key, planId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insuredModel = router.arguments(context);
    final planId = insuredModel.planId;
    String cardImage;
    switch (planId) {
      case 31:
        cardImage = 'assets/images/plans/plan_1.png';
        break;
      case 32:
        cardImage = 'assets/images/plans/plan_2.png';
        break;
      case 33:
        cardImage = 'assets/images/plans/plan_3.png';
        break;
      case 34:
        cardImage = 'assets/images/plans/plan_4.png';
        break;
      default:
        cardImage = 'assets/images/plans/plan_1.png';
    }
    return Image.asset(cardImage);
  }
}
