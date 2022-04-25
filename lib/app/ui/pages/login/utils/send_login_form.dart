import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import '../login_page.dart' show loginProvider;
import '../../../../domain/responses/sign_in_response.dart';
import '../../../global_widgets/dialogs/dialogs.dart';
import '../../../global_widgets/dialogs/progress_dialog.dart';
import '../../../routes/routes.dart';

Future<void> sendLoginForm(BuildContext context) async {
  final controller = loginProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();
  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      late String errorMessage = "";
      switch (response.error) {
        case SignInError.networkRequestFailed:
          errorMessage = "Se perdió la conexión a Internet";
          break;
        case SignInError.userDisabled:
          errorMessage = "El usuario está deshabilitado";
          break;
        case SignInError.userNotFound:
          errorMessage = "No se ha encontrado el usuario";
          break;
        case SignInError.wrongPassword:
          errorMessage = "El password es incorrecto";
          break;
        case SignInError.tooManyRequests:
          errorMessage = "Demasiadas solicitudes equivocadas";
          break;
        default:
          errorMessage = "Error desconocido";
          break;
      }

      Dialogs.alert(
        context,
        title: "ERROR",
        content: errorMessage,
      );
    } else {
      router.pushReplacementNamed(
        Routes.HOME,
      );
    }
  }
}
