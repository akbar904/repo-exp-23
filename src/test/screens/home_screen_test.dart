
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.simple_app/screens/home_screen.dart';
import 'package:com.example.simple_app/widgets/logout_button.dart';

// Mock the AuthCubit
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('should display a LogoutButton', (WidgetTester tester) async {
			// Arrange
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => MockAuthCubit(),
						child: HomeScreen(),
					),
				),
			);

			// Act
			await tester.pumpAndSettle();

			// Assert
			expect(find.byType(LogoutButton), findsOneWidget);
		});
	});
}
