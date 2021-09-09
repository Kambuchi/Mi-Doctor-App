import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/meedu.dart';
import '../../global_controllers/theme_controller.dart';
import '../../global_controllers/seccion_controller.dart';
import '../../global_widgets/custom_input_field.dart';
import '../../pages/login/controller/login_controller.dart';
import '../../pages/login/utils/send_login_form.dart';
import '../../routes/routes.dart';
import '../../../utils/email_validator.dart';

final loginProvider = SimpleProvider(
  (_) => LoginController(sessionProvider.read),
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final ButtonStyle styleButton = ElevatedButton.styleFrom(
      fixedSize: const Size(150, 55),
      primary: primaryDarkColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    );
    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, controller) {
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
                  key: controller.formKey,
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
                          const SizedBox(height: 10),
                          CustomInputField(
                            label: "Email",
                            onChanged: controller.onEmailChanged,
                            inputType: TextInputType.emailAddress,
                            validator: (text) {
                              if (isValidEmail(text!)) {
                                return null;
                              } else {
                                return "El email no es válido";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomInputField(
                            label: "Password",
                            onChanged: controller.onPasswordChanged,
                            isPassword: true,
                            validator: (text) {
                              if (text!.trim().length >= 6) {
                                return null;
                              } else {
                                return "El password no es válido";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                label: const Text("Ingresar"),
                                icon: const Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.white,
                                  size: 34.0,
                                ),
                                onPressed: () => sendLoginForm(context),
                                style: styleButton,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () => router.pushNamed(
                              Routes.RESET_PASSWORD,
                            ),
                            child: const Text("Olvidó su password?"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.check_circle_rounded,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            style: styleButton,
                            onPressed: () => router.pushNamed(
                              Routes.REGISTER,
                            ),
                            label: const Text("Registrarse"),
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
      },
    );
  }
}
