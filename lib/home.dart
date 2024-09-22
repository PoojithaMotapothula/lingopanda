import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Fetch comments when the screen is initialized
    Provider.of<CommentsProvider>(context, listen: false).fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 229, 229),
      appBar: AppBar(
        backgroundColor: Color(0xFF0C54BE),
        title: const Text(
          'Comments',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false, // Corrected line
      ),
      body: Consumer<CommentsProvider>(
        builder: (context, commentsProvider, child) {
          return commentsProvider.comments.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: commentsProvider.comments.length,
                  itemBuilder: (context, index) {
                    final comment = commentsProvider.comments[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Text(
                                comment.name[0],
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                            ),
                            const SizedBox(
                                width: 16), // Spacing between avatar and text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name: ${comment.name}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      color: Colors
                                          .blue, // Change to your preferred color
                                    ),
                                  ),
                                  Text(
                                    'Email: ${comment.email}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      color: Colors
                                          .green, // Change to your preferred color
                                    ),
                                  ), // Email with title
                                  const SizedBox(height: 4), // Spacing
                                  Text(
                                    comment.body,
                                    style: TextStyle(fontFamily: 'Poppins'),
                                  ), // Comment text
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
