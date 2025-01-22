import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'ProfilePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Secure Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _loginNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  String imageSource = 'images/question-mark.png';

  @override
  void initState() {
    super.initState();
    _loadStoredCredentials();
  }

  Future<void> _loadStoredCredentials() async {
    String? savedUsername = await _secureStorage.read(key: 'username');
    String? savedPassword = await _secureStorage.read(key: 'password');

    if (savedUsername != null && savedPassword != null) {
      _loginNameController.text = savedUsername;
      _passwordController.text = savedPassword;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Previous login loaded'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _loginNameController.clear();
                _passwordController.clear();
              });
            },
          ),
        ),
      );
    }
  }

  Future<void> _handleLogin() async {
    String username = _loginNameController.text;
    String password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      // Save credentials automatically if needed
      await _secureStorage.write(key: 'username', value: username);
      await _secureStorage.write(key: 'password', value: password);

      // Show welcome message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome Back!")),
      );

      // Navigate to ProfilePage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(username: username,),
        ),
      );
    } else {
      // Show error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a username and password.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _loginNameController,
              decoration: const InputDecoration(
                hintText: "Please enter your username",
                labelText: "Login",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Please enter your password",
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              child: const Text("Login"),
            ),
            Image.asset(
              imageSource,
              height: 200,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}