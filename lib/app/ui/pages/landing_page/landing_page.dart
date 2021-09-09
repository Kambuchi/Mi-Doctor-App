import '../../global_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import '../../routes/routes.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final ButtonStyle styleButton = ElevatedButton.styleFrom(
      fixedSize: const Size(250, 75),
      primary: primaryDarkColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Image.asset(
                            'assets/images/Logo.png',
                            height: screenHeight * 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        style: styleButton,
                        onPressed: () => router.pushNamed(
                          Routes.LOGIN,
                        ),
                        label: const Text("Ingresar con su correo"),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.phone_android,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        style: styleButton,
                        onPressed: () => router.pushNamed(
                          Routes.MOBILE_LOGIN,
                        ),
                        label: const Text("Ingresar mediante sms"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
