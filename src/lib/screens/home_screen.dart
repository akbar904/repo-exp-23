
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/widgets/logout_button.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Home'),
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						Text('Welcome to the Home Screen!'),
						SizedBox(height: 20),
						LogoutButton()
					],
				),
			),
		);
	}
}
