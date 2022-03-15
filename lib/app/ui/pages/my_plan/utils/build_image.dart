import 'package:app_mi_doctor/app/domain/models/insured_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;

class BuildImage extends StatelessWidget {
  const BuildImage({required Key key, planId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insuredModel = router.arguments as InsuredModel;
    final planId = insuredModel.planId;
    String cardImage;
    switch (planId) {
      case 31:
        cardImage = 'assets/images/plans/plan_31.png';
        break;
      case 32:
        cardImage = 'assets/images/plans/plan_32.png';
        break;
      case 33:
        cardImage = 'assets/images/plans/plan_33.png';
        break;
      case 34:
        cardImage = 'assets/images/plans/plan_34.png';
        break;
      default:
        cardImage = 'assets/images/plans/plan_31.png';
    }
    return Image.asset(cardImage);
  }
}
