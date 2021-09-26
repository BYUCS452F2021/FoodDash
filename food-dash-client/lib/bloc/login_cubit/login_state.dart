part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginPendingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSucceededState extends LoginState {
  final User user;

  LoginSucceededState({@required this.user});
  @override
  List<Object> get props => [user];
}

class LoginFailedState extends LoginState {
  final String errorMessage;

  LoginFailedState({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
