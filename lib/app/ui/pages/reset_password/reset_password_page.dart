import '../../../domain/responses/reset_password_response.dart';
import '../../global_widgets/dialogs/dialogs.dart';
import '../../global_widgets/dialogs/progress_dialog.dart';
import '../../../utils/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';
import '../../global_widgets/custom_input_field.dart';
import '../reset_password/controller/reset_password_controller.dart';

final resetPasswordProvider = SimpleProvider(
  (_) => ResetPasswordController(),
);

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_, controller) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomInputField(
                    label: "Email",
                    onChanged: controller.onEmailChanged,
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    child: const Text("Enviar"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    final controller = resetPasswordProvider.read;
    if (isValidEmail(controller.email)) {
      ProgressDialog.show(context);
      final response = await controller.submit();
      Navigator.pop(context);
      if (response == ResetPasswordResponse.ok) {
        Dialogs.alert(
          context,
          title: "BIEN!!!",
          content: "El email recuperación fue enviado",
        );
      } else {
        String errorMessage = "";
        switch (response) {
          case ResetPasswordResponse.networkRequestFailed:
            errorMessage = "Se perdió la conexión a Internet";
            break;
          case ResetPasswordResponse.userDisabled:
            errorMessage = "El usuario está deshabilitado";
            break;
          case ResetPasswordResponse.userNotFound:
            errorMessage = "No se ha encontrado el usuario";
            break;
          case ResetPasswordResponse.tooManyRequests:
            errorMessage = "Demasiadas solicitudes equivocadas";
            break;
          default:
            errorMessage = "Error desconocido";
            break;
        }
        Dialogs.alert(
          context,
          title: "ERROR!!!",
          content: errorMessage,
        );
      }
    } else {
      Dialogs.alert(context, content: "El email no es válido");
    }
  }
}
