import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import '../../global_controllers/theme_controller.dart';
import '../../routes/routes.dart';

enum MobileVerificationState { showMobileFormState, showOtpFromState }

class MobileLoginPage extends StatefulWidget {
  const MobileLoginPage({Key? key}) : super(key: key);

  @override
  _MobileLoginPageState createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('usuarios');
  MobileVerificationState currentState =
      MobileVerificationState.showMobileFormState;

  final ButtonStyle styleButton = ElevatedButton.styleFrom(
    fixedSize: const Size(200, 75),
    primary: primaryDarkColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
    ),
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final phoneController = TextEditingController();
  final optController = TextEditingController();

  late String verificationId;
  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        await users.doc('${authCredential.user!.uid}').get().then((value) {        
          if (value.exists == true) {
            router.pushNamedAndRemoveUntil(
              Routes.SPLASH
            );
          } else {
            router.pushNamedAndRemoveUntil(
              Routes.REGISTER_CI,
              arguments: authCredential.user,
            );
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  getMobileMobileWidget(context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ListView(
      children: <Widget>[
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
        TextField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: "Su número de celular (+5959xxxxxxxx)",
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: ElevatedButton(
            onPressed: () async {
              setState(() {
                showLoading = true;
              });
                inspect(phoneController.text);
              await _auth.verifyPhoneNumber(
                phoneNumber: phoneController.text,
                verificationCompleted: (phoneAuthCredential) async {
                  setState(() {
                    showLoading = false;
                  });
                  signInWithPhoneAuthCredential(phoneAuthCredential);
                },
                verificationFailed: (verificationFailed) async {
                  setState(() {
                    showLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(verificationFailed.message.toString())));
                },
                codeSent: (verificationId, resendingToken) async {
                  setState(() {
                    showLoading = false;
                    currentState = MobileVerificationState.showOtpFromState;
                    this.verificationId = verificationId;
                  });
                },
                codeAutoRetrievalTimeout: (verificationId) async {},
              );
            },
            child: const Text('ENVIAR'),
            style: styleButton,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  getOtpPhoneWidget(context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        TextField(
          controller: optController,
          decoration: const InputDecoration(
            hintText: "Ingrese el código de verificación",
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: optController.text,
            );
            signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          child: const Text('VERIFICAR'),
          style: styleButton,
        ),
        const SizedBox(
          height: 30,
        ),
        const Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: showLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : currentState == MobileVerificationState.showMobileFormState
                ? getMobileMobileWidget(context)
                : getOtpPhoneWidget(context),
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}
