import 'dart:convert';
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
  late dynamic planList;
  late AdherentList adherentList;

  bool isLoading = false;

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
                GestureDetector(
                  onTap: () => _submitButtonOnPresses(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 20),
                    margin: const EdgeInsets.only(bottom: 30, top: 30),
                    decoration: const BoxDecoration(
                        color: primaryDarkColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Ver mi plan".toUpperCase(),
                          style: kCalloutStyle.copyWith(color: Colors.white),
                        ),
                        const SizedBox(width: 20.0),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18.0,
                          color: Colors.white,
                        )
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
          planList = value.insureds.where((i) => i.negocioId == "3").toList();
          if (!planList.isEmpty) {
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