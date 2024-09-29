
import 'dart:convert';

class User {
	final String email;
	final String token;

	User({required this.email, required this.token});

	Map<String, dynamic> toJson() {
		return {
			'email': email,
			'token': token,
		};
	}

	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			email: json['email'],
			token: json['token'],
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(this, other)) return true;

		return other is User &&
			other.email == email &&
			other.token == token;
	}

	@override
	int get hashCode => email.hashCode ^ token.hashCode;

	@override
	String toString() {
		return 'User(email: $email, token: $token)';
	}
}
