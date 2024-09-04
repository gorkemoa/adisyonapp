import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'home_screen.dart';  // HomePage widget'ınızı doğru bir şekilde import edin

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    // Örnek kullanıcı verisi (Bunu bir API'den veya veritabanından alabilirsiniz)
    const Map<String, String> users = {
      'fikret': '11111',
    };

    await Future.delayed(loginTime);

    if (!users.containsKey(data.name)) {
      return 'User not exists';
    }
    if (users[data.name] != data.password) {
      return 'Password does not match';
    }
    return null;
  }

  Future<String?> _signupUser(SignupData data) async {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    // Kullanıcı kaydı işlemleri burada yapılabilir
    await Future.delayed(loginTime);
    return null;
  }

  Future<String?> _recoverPassword(String name) async {
    debugPrint('Name: $name');
    // Şifre kurtarma işlemleri burada yapılabilir
    await Future.delayed(loginTime);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(

      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
