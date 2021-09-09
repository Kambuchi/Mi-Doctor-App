import 'dart:convert';

import 'package:app_mi_doctor/app/ui/global_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_meedu/router.dart' as router;
import '../../routes/routes.dart';
import '../../../domain/models/adhrent_model.dart';
import '../../../domain/models/insured_model.dart';
import '../../../services/constant.dart';

class SelectPlanPage extends StatelessWidget {
  const SelectPlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insuredList = router.arguments(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: insuredList.length,
                      itemBuilder: (context, index) =>
                          _BuildPlan(insuredModel: insuredList[index])),
                ),
              ],
            ),
          ),

          // Back Button
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 30),
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Material(
                    elevation: 0.0,
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                        ),
                        onPressed: () => router.pushNamed(Routes.HOME),
                      ),
                    ),
                  ),
                  const Text(
                    'Seleccione un plan',
                    style: kSubTitleStyle,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildPlan extends StatefulWidget {
  const _BuildPlan({Key? key, required this.insuredModel}) : super(key: key);

  final InsuredModel insuredModel;

  @override
  __BuildPlanState createState() => __BuildPlanState();
}

class __BuildPlanState extends State<_BuildPlan> {
  late AdherentList adherentList;
  bool isLoading = false;

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
    return GestureDetector(
      onTap: () => getMyAdherents(widget.insuredModel.nrocontrato.toString())
          .then((adherent) {
        widget.insuredModel.adherentes = adherent?.insureds;
        router.pushNamed(Routes.MY_PLAN, arguments: widget.insuredModel);
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        margin: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: primaryDarkColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                widget.insuredModel.plan.toUpperCase().substring(5),
                style: kCalloutStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18.0,
            )
          ],
        ),
      ),
    );
  }
}
