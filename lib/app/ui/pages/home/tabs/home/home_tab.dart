import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../domain/models/office_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_meedu/router.dart' as router;
import '../../../../global_controllers/theme_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../../domain/models/adhrent_model.dart';
import '../../../../../domain/models/insured_model.dart';
import '../../../../../services/constant.dart';
import '../../../../../ui/global_controllers/seccion_controller.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

final userCollection = FirebaseFirestore.instance.collection('usuarios');
final sessionController = sessionProvider.read;

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  final userDocument = userCollection.doc('${sessionController.user!.uid}');

  late InsuredModel insuredModel;
  late InsuredList _insuredList;
  late OfficeList officeList;
  late List<InsuredModel> planList;
  late AdherentList adherentList;

  bool isLoading = false;
  bool isActive = true;

  Future<OfficeList?> getOffices() async {
    http.Response response =
        await http.get(Uri.parse('https://odexapi.herokuapp.com/consultorio/'));
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final data = json.decode(body);
      officeList = OfficeList.fromJson(data);
    } else {
      setState(() {
        isLoading = false;
      });
      return null;
    }
    setState(() {
      isLoading = false;
    });
    return officeList;
  }

  Future<InsuredList?> getMyPlan(String id) async {
    http.Response response = await http
        .get(Uri.parse('https://odexapi.herokuapp.com/contratos/' + id));
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final data = json.decode(body);
      _insuredList = InsuredList.fromJson(data);
    } else {
      setState(() {
        isLoading = false;
      });
      return null;
    }
    setState(() {
      isLoading = false;
    });
    return _insuredList;
  }

  Future<AdherentList?> getMyAdherents(String id) async {
    http.Response response = await http
        .get(Uri.parse('https://odexapi.herokuapp.com/adherentes/' + id));
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final data = json.decode(body);
      adherentList = AdherentList.fromJson(data);
    } else {
      setState(() {
        isLoading = false;
      });
      return null;
    }
    setState(() {
      isLoading = false;
    });
    return adherentList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/Logo.png',
                      height: screenHeight * 0.4,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                isActive
                    ? GestureDetector(
                        onTap: () => _submitButtonOnPresses(context),
                        child: Container(
                          width: screenWidth * 0.85,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 36, vertical: 20),
                          margin: const EdgeInsets.only(bottom: 30, top: 30),
                          decoration: const BoxDecoration(
                              color: primaryDarkColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 18.0,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10.0),
                              Text(
                                "Ver mi plan".toUpperCase(),
                                style:
                                    kCalloutStyle.copyWith(color: Colors.white),
                              ),
                              const SizedBox(width: 10.0),
                            ],
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            GestureDetector(
                              onTap: () => _makingPhoneCall('+595986679771'),
                              child: Container(
                                width: screenWidth * 0.44,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                margin:
                                    const EdgeInsets.only(bottom: 30, top: 30),
                                decoration: const BoxDecoration(
                                    color: primaryDarkColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.phone,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      "Llamar".toUpperCase(),
                                      style: kCalloutStyle.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.05,
                            ),
                            GestureDetector(
                              onTap: () => launch('https://wa.me/595986679771'),
                              child: Container(
                                width: screenWidth * 0.44,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                margin:
                                    const EdgeInsets.only(bottom: 30, top: 30),
                                decoration: const BoxDecoration(
                                    color: primaryDarkColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.navigation,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      "Whatsapp".toUpperCase(),
                                      style: kCalloutStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                // const SizedBox(
                //   height: 10,
                // ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    getOffices().then((value) => {
                          router.pushNamed(
                            Routes.SERVICE_PROVIDERS,
                            arguments: value,
                          )
                        });
                  },
                  child: Container(
                    width: screenWidth * 0.85,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 20),
                    margin: const EdgeInsets.only(bottom: 30, top: 30),
                    decoration: const BoxDecoration(
                        color: primaryDarkColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Icons.work_outline_sharp,
                          size: 18.0,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Prestadores de Servicios".toUpperCase(),
                          style: kCalloutStyle.copyWith(color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          // Loading
          Center(
              child: isLoading
                  ? SpinKitCircle(
                      color: primaryDarkColor,
                      size: 60.0,
                      controller: AnimationController(
                          vsync: this,
                          duration: const Duration(milliseconds: 1200)),
                    )
                  : Container())
        ],
      ),
    );
  }

  Future<void> _submitButtonOnPresses(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final userCi =
        await userDocument.get().then((value) => value.get('ci')).catchError((
      error,
      stackTracer,
    ) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'No se encontró el usuario.',
          style: kBodyStyle,
          textAlign: TextAlign.center,
        ),
      )));
    });
    if (userCi.isEmpty == false) {
      getMyPlan(userCi).then((value) {
        if (value != null) {
          if (value.insureds.isNotEmpty) {
            planList = value.insureds.where((i) => i.negocioId == "3").toList();
            if (planList.isNotEmpty) {
              planList = planList.where((i) => i.estado == "Activo").toList();
              if (planList.isNotEmpty) {
                if (planList.length > 1) {
                  router.pushNamed(Routes.SELECT_PLAN, arguments: planList);
                } else {
                  getMyAdherents(planList[0].nrocontrato.toString())
                      .then((adherent) {
                    planList[0].adherentes = adherent?.insureds;
                    router.pushNamed(Routes.MY_PLAN, arguments: planList[0]);
                  });
                }
              } else {
                isActive = false;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Su plan no está activo.',
                    style: kBodyStyle,
                    textAlign: TextAlign.center,
                  ),
                )));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'No se encontró el usuario.',
                  style: kBodyStyle,
                  textAlign: TextAlign.center,
                ),
              )));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'No se encontró el usuario.',
                style: kBodyStyle,
                textAlign: TextAlign.center,
              ),
            )));
          }
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'No se encontró el usuario.',
          style: kBodyStyle,
          textAlign: TextAlign.center,
        ),
      )));
      setState(() {
        isLoading = false;
      });
    }
  }
}

_makingPhoneCall(String num) async {
  final url = 'tel:' + num;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No se encontro $url';
  }
}
