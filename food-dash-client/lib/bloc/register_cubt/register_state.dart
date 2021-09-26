part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterPendingState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSucceededState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterFailedState extends RegisterState {
  final String errorMessage;

  RegisterFailedState({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
