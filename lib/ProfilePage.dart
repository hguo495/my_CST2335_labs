import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data_rapo.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DataRepository _dataRepo = DataRepository();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dataRepo.setUsername(widget.username); // Set the username in repository
    _loadUserData();
  }

  @override
  void dispose() {
    _saveUserData();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    await _dataRepo.loadData();
    setState(() {
      _firstNameController.text = _dataRepo.firstName;
      _lastNameController.text = _dataRepo.lastName;
      _phoneController.text = _dataRepo.phoneNumber;
      _emailController.text = _dataRepo.email;
    });
  }

  Future<void> _saveUserData() async {
    _dataRepo.firstName = _firstNameController.text;
    _dataRepo.lastName = _lastNameController.text;
    _dataRepo.phoneNumber = _phoneController.text;
    _dataRepo.email = _emailController.text;
    await _dataRepo.saveData();
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showErrorDialog("This action is not supported on your device.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page - ${widget.username}"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Back, ${widget.username}!",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // First Name
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Last Name
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Phone Number with Call & SMS Buttons
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _launchUrl("tel:${_phoneController.text}"),
                  child: const Icon(Icons.phone),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _launchUrl("sms:${_phoneController.text}"),
                  child: const Icon(Icons.message),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Email Address with Mail Button
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _launchUrl("mailto:${_emailController.text}"),
                  child: const Icon(Icons.mail),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Back Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _saveUserData();
                  Navigator.pop(context);
                },
                child: const Text("Back to Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}