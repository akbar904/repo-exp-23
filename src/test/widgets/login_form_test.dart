
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/widgets/login_form.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginForm Widget', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('renders email and password TextFields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => authCubit,
							child: LoginForm(),
						),
					),
				),
			);

			expect(find.byType(TextField), findsNWidgets(2));
			expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
			expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
		});

		testWidgets('renders login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => authCubit,
							child: LoginForm(),
						),
					),
				),
			);

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
		});

		testWidgets('calls login on AuthCubit when login button is pressed', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => authCubit,
							child: LoginForm(),
						),
					),
				),
			);

			await tester.enterText(find.widgetWithText(TextField, 'Email'), 'test@example.com');
			await tester.enterText(find.widgetWithText(TextField, 'Password'), 'password');
			await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
			await tester.pump();

			verify(() => authCubit.login('test@example.com', 'password')).called(1);
		});

		testWidgets('shows error text when state is AuthState.error', (WidgetTester tester) async {
			whenListen(
				authCubit,
				Stream<AuthState>.fromIterable([AuthState.error('Invalid credentials')]),
				initialState: AuthState.initial(),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => authCubit,
							child: LoginForm(),
						),
					),
				),
			);

			await tester.pump();

			expect(find.text('Invalid credentials'), findsOneWidget);
		});
	});
}
