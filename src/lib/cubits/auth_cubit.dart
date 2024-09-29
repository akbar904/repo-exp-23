
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) async {
		try {
			emit(AuthLoading());
			// Simulate a network call
			await Future.delayed(Duration(seconds: 1));

			if (email == 'test@example.com' && password == 'password') {
				final user = User(email: email, token: 'dummy_token');
				emit(Authenticated(user));
			} else {
				emit(AuthError('Login failed'));
			}
		} catch (e) {
			emit(AuthError('Login failed'));
		}
	}

	void logout() {
		emit(Unauthenticated());
	}
}
