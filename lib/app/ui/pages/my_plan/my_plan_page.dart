import 'package:app_mi_doctor/app/domain/models/insured_model.dart';
import 'package:app_mi_doctor/app/ui/global_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'utils/build_image.dart';
import 'utils/color_selector.dart';
import '../../routes/routes.dart';
import '../../../services/constant.dart';

class MyPlanPage extends StatelessWidget {
  const MyPlanPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final InsuredModel insuredModel = router.arguments as InsuredModel;

    return Scaffold(
      backgroundColor: selectColorCard(insuredModel.plan),
      body: Stack(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 6, spreadRadius: 1, offset: Offset(2, 2))
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: <Widget>[
                      BuildImage(
                        planId: insuredModel.planId,
                        key: UniqueKey(),
                      ),
                      Positioned(
                        top: 35,
                        left: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              insuredModel.plan ,
                              style: kHeadlineStyle.copyWith(
                                  color: Colors.white,
                                  shadows: [
                                    const Shadow(
                                        color: Colors.black,
                                        blurRadius: 3,
                                        offset: Offset(1, 1))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 15,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'N° CÉDULA:',
                              style: kFootnoteStyle.copyWith(
                                  color: Colors.black,
                                  shadows: [
                                    const Shadow(
                                        color: Colors.grey,
                                        blurRadius: 2,
                                        offset: Offset(1, 1))
                                  ]),
                            ),
                            Text(
                              insuredModel.nrocedula.toString(),
                              style: kBodyStyle.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  shadows: [
                                    const Shadow(
                                        color: Colors.grey,
                                        blurRadius: 1,
                                        offset: Offset(1, 1))
                                  ]),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'ASEGURADO:',
                              style: kFootnoteStyle.copyWith(
                                  color: Colors.black,
                                  shadows: [
                                    const Shadow(
                                        color: Colors.grey,
                                        blurRadius: 3,
                                        offset: Offset(1, 1))
                                  ]),
                            ),
                            SizedBox(
                              width: screenWidth * 0.9,
                              child: Text(
                                insuredModel.nombreAsegurado,
                                style: kBodyStyle.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                    shadows: [
                                      const Shadow(
                                          color: Colors.grey,
                                          blurRadius: 1,
                                          offset: Offset(1, 1))
                                    ]),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 85,
                        right: 32,
                        child: Column(
                          children: <Widget>[
                            //       insuredModel.estado == 'Activo'
                            //           ? const SizedBox.shrink()
                            //           : const Icon(
                            //               Icons.warning_rounded,
                            //               color: Colors.red,
                            //               size: 34,
                            //             ),
                            //       Text(
                            //         insuredModel.estado.toUpperCase(),
                            //         style: kCalloutStyle.copyWith(
                            //             color: Colors.white,
                            //             shadows: [
                            //               const Shadow(
                            //                   color: Colors.black,
                            //                   blurRadius: 3,
                            //                   offset: Offset(1, 1))
                            //             ]),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Positioned(
                            //   top: 100,
                            //   right: 15,
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     crossAxisAlignment: CrossAxisAlignment.end,
                            //     children: <Widget>[
                            //       Text(
                            //         insuredModel.plan,
                            //         style: kHeadlineStyle.copyWith(
                            //             color: Colors.white,
                            //             shadows: [
                            //               const Shadow(
                            //                   color: Colors.black,
                            //                   blurRadius: 3,
                            //                   offset: Offset(1, 1))
                            //             ]),
                            //       ),
                            //       Row(
                            //         crossAxisAlignment: CrossAxisAlignment.end,
                            //         children: [
                            //           Text(
                            //             insuredModel.tipoAsegurado.toString(),
                            //             style: kBodyStyle.copyWith(
                            //                 color: Colors.white,
                            //                 shadows: [
                            //                   const Shadow(
                            //                       color: Colors.black,
                            //                       blurRadius: 3,
                            //                       offset: Offset(1, 1))
                            //                 ]),
                            //           ),
                            //         ],
                            //       ),
                            //       Row(
                            //         crossAxisAlignment: CrossAxisAlignment.end,
                            //         children: [
                            //           Text(
                            //             'Contrato: ',
                            //             style: kFootnoteStyle.copyWith(
                            //                 color: Colors.white,
                            //                 shadows: [
                            //                   const Shadow(
                            //                       color: Colors.black,
                            //                       blurRadius: 3,
                            //                       offset: Offset(1, 1))
                            //                 ]),
                            //           ),
                            //           Text(
                            //             insuredModel.nrocontrato.toString(),
                            //             style: kBodyStyle.copyWith(
                            //                 color: Colors.white,
                            //                 shadows: [
                            //                   const Shadow(
                            //                       color: Colors.black,
                            //                       blurRadius: 3,
                            //                       offset: Offset(1, 1))
                            //                 ]),
                            //           ),
                            //         ],
                            //       ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  if (insuredModel.tipoAsegurado ==
                                      'TITULAR') ...[
                                    if (insuredModel.adherentes != null) ...[
                                      Text(
                                        'Adherentes',
                                        style: kBodyStyle.copyWith(
                                            color: Colors.white,
                                            shadows: [
                                              const Shadow(
                                                  color: Colors.black87,
                                                  blurRadius: 3,
                                                  offset: Offset(1, 1))
                                            ]),
                                      ),
                                      for (var item in insuredModel.adherentes!)
                                        Text(
                                          item.nombreAdherente.toString(),
                                          style: kBodyStyle.copyWith(
                                              fontSize: 12,
                                              color: Colors.white,
                                              shadows: [
                                                const Shadow(
                                                    color: Colors.black87,
                                                    blurRadius: 3,
                                                    offset: Offset(1, 1))
                                              ]),
                                        )
                                    ]
                                  ]
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Back Button
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 30),
            child: Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 0.0,
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                    onPressed: () => router.pushNamed(
                      Routes.HOME,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
