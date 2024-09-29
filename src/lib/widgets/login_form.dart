
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';

class LoginForm extends StatefulWidget {
	@override
	_LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
	final TextEditingController _emailController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return BlocListener<AuthCubit, AuthState>(
			listener: (context, state) {
				if (state is AuthStateError) {
					ScaffoldMessenger.of(context).showSnackBar(
						SnackBar(
							content: Text(state.message),
						),
					);
				}
			},
			child: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					children: [
						TextField(
							controller: _emailController,
							decoration: InputDecoration(
								labelText: 'Email',
							),
						),
						TextField(
							controller: _passwordController,
							decoration: InputDecoration(
								labelText: 'Password',
							),
							obscureText: true,
						),
						SizedBox(height: 16.0),
						ElevatedButton(
							onPressed: () {
								context.read<AuthCubit>().login(
									_emailController.text,
									_passwordController.text,
								);
							},
							child: Text('Login'),
						),
					],
				),
			),
		);
	}
}
