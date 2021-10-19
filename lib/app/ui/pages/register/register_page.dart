import '../../global_controllers/seccion_controller.dart';
import '../../global_widgets/custom_input_field.dart';
import '../../pages/register/controller/register_controller.dart';
import '../../pages/register/controller/register_state.dart';
import '../../pages/register/utils/send_register_form.dart';
import '../../../utils/email_validator.dart';
import '../../../utils/name_validator.dart';
import '../../global_controllers/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              margin: EdgeInsets.only(top: 40),
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              color: Colors.transparent,
              child: Form(
                key: controller.formKey,
                child: ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    CustomInputField(
                      label: "Nombres",
                      onChanged: controller.onNameChanged,
                      validator: (text) {
                        return isValidName(text!) ? null : "Nombre no válido";
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomInputField(
                      label: "Apellidos",
                      onChanged: controller.onLastNameChanged,
                      validator: (text) {
                        return isValidName(text!) ? null : "Apellido no válido";
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomInputField(
                      label: "Número de cédula",
                      onChanged: controller.onCiChanged,
                      inputType: TextInputType.number,                     
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomInputField(
                      label: "E-mail",
                      inputType: TextInputType.emailAddress,
                      onChanged: controller.onEmailChanged,
                      validator: (text) {
                        return isValidEmail(text!) ? null : "E-mail no válido";
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomInputField(
                      label: "Password",
                      onChanged: controller.onPaswordChanged,
                      isPassword: true,
                      validator: (text) {
                        if (text!.trim().length >= 6) {
                          return null;
                        }
                        return "Password no válido";
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                      Consumer(builder: (_, watch, __) {
                        watch(
                          registerProvider.select(
                            (_) => _.password,
                          ),
                        );
                        return CustomInputField(
                          label: "Verificación de Password",
                          onChanged: controller.onVPaswordChanged,
                          isPassword: true,
                          validator: (text) {
                            if (controller.state.password != text) {
                              return "Los passwords no coinciden";
                            }
                            if (text!.trim().length >= 6) {
                              return null;
                            }
                            return "Password no coincide";
                          },
                        );
                      }),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton.icon(
                      label: const Text("REGISTRARSE"),
                      icon: const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      style: styleButton,
                      onPressed: () => sendRegisterForm(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
