
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/models/user.dart';

void main() {
	group('User Model', () {
		test('User serialization to JSON', () {
			final user = User(email: 'test@example.com', token: 'abcd1234');
			final json = user.toJson();
			expect(json, {'email': 'test@example.com', 'token': 'abcd1234'});
		});

		test('User deserialization from JSON', () {
			final json = {'email': 'test@example.com', 'token': 'abcd1234'};
			final user = User.fromJson(json);
			expect(user.email, 'test@example.com');
			expect(user.token, 'abcd1234');
		});

		test('User equality comparison', () {
			final user1 = User(email: 'test@example.com', token: 'abcd1234');
			final user2 = User(email: 'test@example.com', token: 'abcd1234');
			final user3 = User(email: 'test2@example.com', token: 'abcd1234');

			expect(user1, equals(user2));
			expect(user1, isNot(equals(user3)));
		});

		test('User toString method', () {
			final user = User(email: 'test@example.com', token: 'abcd1234');
			expect(user.toString(), 'User(email: test@example.com, token: abcd1234)');
		});
	});
}
