import 'package:apiproject/model/user_model.dart';
import 'package:apiproject/services/api_exception.dart';
import 'package:apiproject/services/api_services.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {

  final ApiService _apiService = ApiService();
  List<UserModel> _users = [];
  UserModel? _selectedUser;
  bool _isLoading = false;

  /// Getters for the list of users, selected user, and loading state
  List<UserModel> get users => _users;
  UserModel? get selectedUser => _selectedUser;
  bool get isLoading => _isLoading;





  /// Fetch the list of users from the API
  Future<void> fetchUsers() async {
    _isLoading = true; /// Set loading state to true
    notifyListeners(); /// Notify listeners to update the UI
    final response = await _apiService.get('https:///api.example.com/users');
    if (response is List) {
      /// Parse the response into a list of UserModel
      _users = response.map<UserModel>((user) => UserModel.fromJson(user as Map<String, dynamic>)).toList();
    } else {
      /// Throw an exception if the response is not a list
      throw InvalidResponseException('Expected a list but got a different response.');
    }
    _isLoading = false; /// Set loading state to false
    notifyListeners(); /// Notify listeners to update the UI
  }








  /// Fetch a single user by ID from the API
  Future<void> fetchUser(int id) async {
    _isLoading = true; /// Set loading state to true
    notifyListeners(); /// Notify listeners to update the UI
    final response = await _apiService.get('https:///api.example.com/users/$id');
    if (response is Map) {
      /// Parse the response into a UserModel
      _selectedUser = UserModel.fromJson(response as Map<String, dynamic>);
    } else {
      /// Throw an exception if the response is not an object
      throw InvalidResponseException('Expected an object but got a different response.');
    }
    _isLoading = false; /// Set loading state to false
    notifyListeners(); /// Notify listeners to update the UI
  }






  /// Create a new user using the API
  Future<void> createUser(UserModel user) async {
    _isLoading = true; /// Set loading state to true
    notifyListeners(); /// Notify listeners to update the UI
    await _apiService.post('https:///api.example.com/users', user.toJson());
    await fetchUsers(); /// Refresh the user list after creation
    _isLoading = false; /// Set loading state to false
    notifyListeners(); /// Notify listeners to update the UI
  }






  /// Update an existing user using the API
  Future<void> updateUser(UserModel user) async {
    _isLoading = true; /// Set loading state to true
    notifyListeners(); /// Notify listeners to update the UI
    await _apiService.put('https:///api.example.com/users/${user.id}', user.toJson());
    await fetchUsers(); /// Refresh the user list after update
    _isLoading = false; /// Set loading state to false
    notifyListeners(); /// Notify listeners to update the UI
  }





  /// Delete a user by ID using the API
  Future<void> deleteUser(int id) async {
    _isLoading = true; /// Set loading state to true
    notifyListeners(); /// Notify listeners to update the UI
    await _apiService.delete('https:///api.example.com/users/$id');
    await fetchUsers(); /// Refresh the user list after deletion
    _isLoading = false; /// Set loading state to false
    notifyListeners(); /// Notify listeners to update the UI
  }





}
