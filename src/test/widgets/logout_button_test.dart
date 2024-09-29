
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:com.example.simple_app/widgets/logout_button.dart';

class MockAuthCubit extends MockCubit<void> implements AuthCubit {}

void main() {
	group('LogoutButton Widget Tests', () {
		testWidgets('renders LogoutButton with correct text', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: LogoutButton(),
					),
				),
			);

			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('calls logout on AuthCubit when pressed', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();

			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: BlocProvider<AuthCubit>(
							create: (_) => mockAuthCubit,
							child: LogoutButton(),
						),
					),
				),
			);

			await tester.tap(find.byType(LogoutButton));
			verify(() => mockAuthCubit.logout()).called(1);
		});
	});
}
