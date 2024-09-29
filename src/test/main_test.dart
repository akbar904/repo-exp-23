
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('Main App Initialization', () {
		testWidgets('App should start with LoginScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.text('Login'), findsOneWidget);
		});

		testWidgets('App should show HomeScreen after successful login', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();
			whenListen(
				mockAuthCubit,
				Stream.fromIterable([AuthInitial(), Authenticated()]),
				initialState: AuthInitial(),
			);

			await tester.pumpWidget(
				BlocProvider<AuthCubit>(
					create: (_) => mockAuthCubit,
					child: MyApp(),
				),
			);

			await tester.pumpAndSettle();

			expect(find.text('Home'), findsOneWidget);
		});

		testWidgets('App should navigate back to LoginScreen after logout', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();
			whenListen(
				mockAuthCubit,
				Stream.fromIterable([Authenticated(), AuthInitial()]),
				initialState: AuthInitial(),
			);

			await tester.pumpWidget(
				BlocProvider<AuthCubit>(
					create: (_) => mockAuthCubit,
					child: MyApp(),
				),
			);

			await tester.pumpAndSettle();
			expect(find.text('Home'), findsOneWidget);

			mockAuthCubit.logout();
			await tester.pumpAndSettle();

			expect(find.text('Login'), findsOneWidget);
		});
	});
}
