import 'package:flutter/material.dart';
import '../../../pages/home/home_page.dart';
import '../../../utils/dark_mode_extention.dart';
import '../../../../ui/global_controllers/theme_controller.dart';

class HomeTabBar extends StatelessWidget {
  HomeTabBar({Key? key}) : super(key: key);
  final _homeControler = homeProvider.read;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final color = primaryDarkColor;
    return SafeArea(
        top: false,
        child: TabBar(
          labelColor: color,
          indicator: _CustomIndicator(color),
          unselectedLabelColor: isDark ? primaryDarkColor : Colors.grey,
          tabs: const [
            Tab(
              icon: Icon(Icons.home_rounded),
            ),
            Tab(
              icon: Icon(Icons.person_rounded),
            ),
          ],
          controller: _homeControler.tabController,
        ));
  }
}

class _CustomIndicator extends Decoration {
  final Color _color;
  const _CustomIndicator(this._color);
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(_color);
  }
}

class _CirclePainter extends BoxPainter {
  final Color _color;
  _CirclePainter(this._color);
  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    final size = configuration.size!;
    final paint = Paint();
    paint.color = _color;
    final center = Offset(offset.dx + size.width * 0.5, size.height * 0.8);
    canvas.drawCircle(center, 5, paint);
  }
}
