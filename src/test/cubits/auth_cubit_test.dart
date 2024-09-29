
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';

class MockUser extends Mock implements User {}

void main() {
	group('AuthCubit', () {
		late AuthCubit authCubit;
		late MockUser mockUser;

		setUp(() {
			mockUser = MockUser();
			authCubit = AuthCubit();
		});

		tearDown(() {
			authCubit.close();
		});

		test('initial state is AuthInitial', () {
			expect(authCubit.state, equals(AuthInitial()));
		});

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, Authenticated] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [AuthLoading(), Authenticated(mockUser)],
			verify: (_) {
				verify(() => mockUser.email).called(1);
			},
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthError] when login fails',
			build: () => authCubit,
			act: (cubit) => cubit.login('wrong@example.com', 'password'),
			expect: () => [AuthLoading(), AuthError('Login failed')],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [Unauthenticated] when logout is called',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [Unauthenticated()],
		);
	});
}
