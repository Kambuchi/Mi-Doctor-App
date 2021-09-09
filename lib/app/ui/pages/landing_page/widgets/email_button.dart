import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import '../../../global_controllers/theme_controller.dart';
import '../../../routes/routes.dart';

class EmailButton extends StatelessWidget {
  const EmailButton({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(
          Icons.favorite,
          color: Colors.pink,
          size: 24.0,
        ),
        label: const Text('Elevated Button'),
        onPressed: () => router.pushNamed(
          Routes.LOGIN,
        ),
        style: styleButton,
      ),
    );
  }
}
