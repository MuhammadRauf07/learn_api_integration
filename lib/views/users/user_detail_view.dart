import 'package:apiproject/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailView extends StatelessWidget {
  final int userId;

  UserDetailView({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Consumer<UserViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          final user = viewModel.selectedUser;
          if (user == null) {
            return Center(child: Text('User not found'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
                Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add user update logic
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    viewModel.deleteUser(user.id);
                    Navigator.pop(context);
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
