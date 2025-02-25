import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataRepository {
  static const _storage = FlutterSecureStorage();
  late String _username; // Store the current username

  // Variables to store user data
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String email = '';

  // Set the username for this session
  void setUsername(String username) {
    _username = username;
  }

  // Generate keys for storing data per user
  String get _firstNameKey => 'profile_${_username}_firstName';
  String get _lastNameKey => 'profile_${_username}_lastName';
  String get _phoneKey => 'profile_${_username}_phone';
  String get _emailKey => 'profile_${_username}_email';

  // Load data for the specific user
  Future<void> loadData() async {
    firstName = await _storage.read(key: _firstNameKey) ?? '';
    lastName = await _storage.read(key: _lastNameKey) ?? '';
    phoneNumber = await _storage.read(key: _phoneKey) ?? '';
    email = await _storage.read(key: _emailKey) ?? '';
  }

  // Save data for the specific user
  Future<void> saveData() async {
    await _storage.write(key: _firstNameKey, value: firstName);
    await _storage.write(key: _lastNameKey, value: lastName);
    await _storage.write(key: _phoneKey, value: phoneNumber);
    await _storage.write(key: _emailKey, value: email);
  }
}
