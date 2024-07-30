import 'package:apiproject/viewmodels/user_view_model.dart';
import 'package:apiproject/views/users/users_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserViewModel(),
      child: MaterialApp(
        title: 'Flutter MVVM CRUD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UserListView(),
      ),
    );
  }
}
