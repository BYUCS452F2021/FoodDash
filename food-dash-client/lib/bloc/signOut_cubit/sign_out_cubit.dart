import 'package:bloc/bloc.dart';
import 'package:food_dash/data/repository/fireauth_repository.dart';
import 'package:equatable/equatable.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit() : super(SignOutInitial());
  FireAuthRepository _fireAuthRepository = FireAuthRepository();

  Future signOut() async {
    emit(SignOutPendingState());
    await _fireAuthRepository.signOut();

    emit(SignOutSucceededState());
  }
}
