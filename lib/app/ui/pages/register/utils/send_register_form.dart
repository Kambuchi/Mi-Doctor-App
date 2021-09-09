import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import '../register_page.dart' show registerProvider;
import '../../../global_widgets/dialogs/dialogs.dart';
import '../../../global_widgets/dialogs/progress_dialog.dart';
import '../../../pages/register/register_page.dart';
import '../../../routes/routes.dart';
import '../../../../domain/responses/sign_up_response.dart';

Future<void> sendRegisterForm(BuildContext context) async {
  final controller = registerProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();

  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      late String content;
      switch (response.error) {
        case SignUpError.emailAlreadyInUse:
          content = "Esta dirección de correo ya está utilizada";
          break;
        case SignUpError.weakPassword:
          content = "El password es muy débil";
          break;
        case SignUpError.networkRequestFailed:
          content = "Se perdió la conexión a Internet";
          break;
        default:
          content = "Error desconocido";
          break;
      }
      Dialogs.alert(
        context,
        title: "ERROR",
        content: content,
      );
    } else {
      router.pushNamedAndRemoveUntil(
        Routes.HOME,
      );
    }
  } else {
    Dialogs.alert(
      context,
      title: "ERROR",
      content: "Campos no válidos",
    );
  }
}
