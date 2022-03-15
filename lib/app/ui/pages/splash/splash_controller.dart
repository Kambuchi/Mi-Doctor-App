import '../../../domain/repositories/authentication_repository.dart';
import '../../global_controllers/seccion_controller.dart';
import '../../routes/routes.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class SplashController extends SimpleNotifier {
  final SessionController _sessionController;
  final _authRepository = Get.find<AuthenticationRepository>();

  String? _routeName;
  String? get routeName => _routeName;

  SplashController(this._sessionController) {
    _init();
  }

  void _init() async {
    final user = await _authRepository.user;
    if (user != null) {
      _routeName = Routes.HOME;
      _sessionController.setUser(user);
    
    } else {
      _routeName = Routes.LANDING_PAGE;
    }
    notify();
      this.dispose();
  }

  // @override
  // void dispose() {
  //   print("dispose splash");
  //   super.dispose();
  // }
}
