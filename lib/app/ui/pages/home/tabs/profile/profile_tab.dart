import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_meedu/router.dart' as router;
import '../../../../routes/routes.dart';
import '../../../../global_widgets/dialogs/dialogs.dart';
import '../../../../global_widgets/dialogs/progress_dialog.dart';
import '../../../../global_widgets/dialogs/show_input_dialog.dart';
import '../../../../global_controllers/seccion_controller.dart';
import '../../../../global_controllers/theme_controller.dart';
import '../../../../utils/dark_mode_extention.dart';
import './widgets/label_button.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({Key? key}) : super(key: key);
  void _updateDisplayName(BuildContext context) async {
    final sessionController = sessionProvider.read;
    final value = await showInputDialog(
      context,
      initialValue: sessionController.user!.displayName ?? '',
    );
    if (value != null) {
      ProgressDialog.show(context);
      final user = await sessionController.updateDisplayName(value);
      Navigator.pop(context);
      if (user == null) {
        Dialogs.alert(
          context,
          title: "ERROR",
          content: "Por favor verifique su conexión de Internet",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, watch) {
    final sessionController = watch(sessionProvider);
    final isDark = context.isDarkMode;
    final user = sessionController.user!;
    final displayName = user.displayName ?? '';
    final firstLetter = displayName.isNotEmpty ? displayName[0] : "";
    return ListView(
      children: [
        //if() Image.network(user.photoURL!),
        const SizedBox(
          height: 20,
        ),
        CircleAvatar(
          radius: 75,
          child: user.photoURL == null
              ? Text(
                  firstLetter,
                  style: const TextStyle(fontSize: 60),
                )
              : null,
          backgroundColor: isDark ? primaryDarkColor : Colors.green[900],
          backgroundImage:
              user.photoURL != null ? NetworkImage(user.photoURL!) : null,
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            displayName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(child: Text(user.email ?? '')),
        const SizedBox(
          height: 50,
        ),
        const Center(
          child: Text(
            "Datos de Usuario",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        LabelButton(
          label: "Nombre de usuario: ",
          value: displayName,
          onPressed: () => _updateDisplayName(context),
        ),
        LabelButton(
          label: "Email: ",
          value: user.email ?? '',
        ),
        LabelButton(
          label: "Email verificado: ",
          value: user.emailVerified ? "Si" : 'NO',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dark Mode"),
              CupertinoSwitch(
                value: isDark,
                activeColor: isDark ? Colors.green[500] : Colors.green[900],
                onChanged: (_) {
                  themeProvider.read.toggle();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        LabelButton(
          label: "Salir",
          value: '',
          onPressed: () async {
            await sessionProvider.read.signOut();
            router.pushNamedAndRemoveUntil(Routes.LOGIN);
          },
        ),
      ],
    );
  }
}
