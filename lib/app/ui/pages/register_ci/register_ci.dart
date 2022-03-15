import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import '../../global_controllers/theme_controller.dart';
import '../../../ui/routes/routes.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('usuarios');

class RegisterCi extends StatefulWidget {
  RegisterCi({Key? key}) : super(key: key);

  @override
  _RegisterCiState createState() => _RegisterCiState();
}

class _RegisterCiState extends State<RegisterCi> {
  final _text = TextEditingController();
  bool _validate = false;
  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  final ButtonStyle _styleButton = ElevatedButton.styleFrom(
    fixedSize: Size(200, 75),
    primary: primaryDarkColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final User user = router.arguments as User;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
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
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              keyboardType: TextInputType.phone,
              controller: _text,
              decoration: InputDecoration(
                hintText: "Ingrese su número de cédula.",
                errorText:
                    _validate ? 'Por favor ingrese su número de cédula.' : null,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  _text.text.isEmpty ? _validate = true : _validate = false;
                });
                if (_validate == false) {
                  await users.doc(user.uid).set({
                    'ci': _text.text,
                    'telefono': user.phoneNumber,
                  });
                  router.pushNamedAndRemoveUntil(
                    Routes.SPLASH,
                  );
                }
              },
              child: Text('ENVIAR'),
              style: _styleButton,
            ),
          )
        ],
      ),
    );
  }
}
