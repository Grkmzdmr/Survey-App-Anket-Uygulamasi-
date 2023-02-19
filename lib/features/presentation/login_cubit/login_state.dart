part of 'login_cubit.dart';

@immutable
abstract class LoginState {
  
}

class LoginInitial extends LoginState {




}

class LoginLoading extends LoginState {

}

class LoginError extends LoginState {

}


class LoginFinished extends LoginState{
   final LoginResponseData loginResponseData;
  
  LoginFinished({required this.loginResponseData});
}
