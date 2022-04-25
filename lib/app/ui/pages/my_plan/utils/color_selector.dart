
import '../../../../services/constant.dart';
import 'package:flutter/material.dart';

Color selectColorCard(String plan) {
  Color _temp;
  switch (plan) {
    case 'PLAN ESCENCIAL':
      _temp = kEscencialPlanColor;
      break;
    case 'PLAN BASICO':
      _temp = kBasicoPlanColor;
      break;
    case 'PLAN PREFERENTE':
      _temp = kPreferentPlanColor;
      break;
    case 'PLAN PREFERENTE PLUS':
      _temp = kPreferentPlusPlanColor;
      break;
    default:
      _temp = kBlackChocolate;
  }
  return _temp;
}
