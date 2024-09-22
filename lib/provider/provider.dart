import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class CommentsProvider with ChangeNotifier {
  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  Future<void> fetchComments() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _comments = data.map((json) => Comment.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}

// class Comment {
//   final String name;
//   final String email;
//   final String body;

//   Comment({required this.name, required this.email, required this.body});

//   factory Comment.fromJson(Map<String, dynamic> json) {
//     return Comment(
//       name: json['name'],
//       email: json['email'],
//       body: json['body'],
//     );
//   }
// }

class Comment {
  final String name;
  final String email;
  final String body;

  Comment({required this.name, required this.email, required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      name: json['name'] ?? '', // Default to empty string if null
      email: json['email'] ?? '', // Default to empty string if null
      body: json['body'] ?? '', // Default to empty string if null
    );
  }
}
