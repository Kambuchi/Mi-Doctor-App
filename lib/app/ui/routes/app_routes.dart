
import '../pages/register_ci/register_ci.dart';
import '../pages/home/home_page.dart';
import '../pages/landing_page/landing_page.dart';
import '../pages/login/login_page.dart';
import '../pages/mobile_login/mobile_login.dart';
import '../pages/my_plan/my_plan_page.dart';
import '../pages/register/register_page.dart';
import '../pages/reset_password/reset_password_page.dart';
import '../pages/splash/splash_page.dart';
import '../pages/select_plan/select_plan.dart';
import '../pages/verify_email/veriy_email.dart';
import '../routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart' show Widget, BuildContext;
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.SPLASH: (_) => const SplashPage(),
      Routes.LOGIN: (_) => const LoginPage(),
      Routes.HOME: (_) => const HomePage(),
      Routes.REGISTER: (_) => const RegisterPage(),
      Routes.REGISTER_CI: (_) =>  RegisterCi(),
      Routes.RESET_PASSWORD: (_) => const ResetPasswordPage(),
      Routes.SELECT_PLAN: (_) => const SelectPlanPage(),
      Routes.MY_PLAN: (_) => const MyPlanPage(),
      Routes.VERIFY_EMAIL: (_) => const VerifyEmailPage(),
      Routes.LANDING_PAGE: (_) => const LandingPage(),
      Routes.MOBILE_LOGIN: (_) => const MobileLoginPage(),
    };
