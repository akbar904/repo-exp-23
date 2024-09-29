
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/auth_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocProvider(
			create: (context) => AuthCubit(),
			child: MaterialApp(
				title: 'Simple App',
				home: AuthFlow(),
			),
		);
	}
}

class AuthFlow extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocBuilder<AuthCubit, AuthState>(
			builder: (context, state) {
				if (state is AuthInitial) {
					return LoginScreen();
				} else if (state is Authenticated) {
					return HomeScreen();
				} else {
					return Container();
				}
			},
		);
	}
}
