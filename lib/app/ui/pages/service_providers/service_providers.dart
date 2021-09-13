import '../../global_controllers/theme_controller.dart';

import '../../../domain/models/office_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;

class ServiceProviders extends StatelessWidget {
  const ServiceProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OfficeList officeList = router.arguments(context);
    return Scaffold(
      body: Center(
        child: ListView(
          children: List.generate(
            officeList.offices.length,
            (index) {
              final item = officeList.offices[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromRGBO(220, 220, 220, 1)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        item.nombre,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.apartment,
                        size: 75,
                        color: primaryDarkColor,
                      ),
                      Text(
                        'Télefono: ' + item.telefono,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Dirección: ' + item.direccion.toUpperCase(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 130,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () => launch(
                                    'http://maps.google.com?q=' +
                                        item.ubicacion +
                                        '&ll=' +
                                        item.ubicacion +
                                        ',17z'),
                                child: Row(
                                  children: [
                                    Icon(Icons.pin_drop_rounded),
                                    Text(
                                      "Ver en Maps",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 130,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  _makingPhoneCall(item.telefono);
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.phone),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Llamar",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ])),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

_makingPhoneCall(String num) async {
  final url = 'tel:' + num;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
