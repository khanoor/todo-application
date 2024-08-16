import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/repository/auth_repository.dart';
import 'package:todoapp/utils/utils.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  User? get user => _user;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(value) {
    _loading = value;
    notifyListeners();
  }

  AuthProvider() {
    _authService.user.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> register(
      String email, String password, BuildContext context) async {
    try {
      setLoading(true);
      await _authService.registerWithEmailPassword(email, password);

      setLoading(false);
      Utils.toastMessage('Welcome');
      return true;
    } catch (e) {
      setLoading(false);
      Utils.flushbarErrorMessage('Register Failed', context);
      return false;
    }
  }

  bool _loginLoading = false;
  bool get logInLoading => _loginLoading;
  loginLoading(value) {
    _loginLoading = value;
    notifyListeners();
  }

  Future<bool> logIn(
      String email, String password, BuildContext context) async {
    try {
      loginLoading(true);
      await _authService.signInWithEmailPassword(email, password);
      loginLoading(false);
      Utils.toastMessage('Welcome');
      return true;
    } catch (e) {
      loginLoading(false);
      Utils.flushbarErrorMessage(
          'Please enter valid email and password', context);
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    Utils.toastMessage("you have successfully logged out");
  }
}
