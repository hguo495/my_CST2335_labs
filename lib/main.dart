import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'BROWSE CATEGORIES'),
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
  double _counter = 0.0;
  double myFontSize = 30.0;
  bool isChecked = false;
  int numCounter = 0;
  String imageSource = "images/question.png";

  final TextEditingController _num1 = TextEditingController();
  final TextEditingController _num2 = TextEditingController();
  final TextEditingController _loginNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void setNewValue(double value) {
    setState(() {
      _counter = value;
      myFontSize = value;
    });
  }

  void _handleLogin() {
    String password = _passwordController.text;
    setState(() {
      imageSource = password == "QWERTY123" ? "images/lightbulb.png" : "images/stop.png";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Not sure about exactly which recipe you are looking for? "
                    "Do a research, or dive into our popular categories.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25.0, color: Colors.black),
              ),
            ),
            _buildCategorySection("By Meat", [
              _buildCategoryItem("Beef", "images/Beef.jpg"),
              _buildCategoryItem("Chicken", "images/Chicken.jpg"),
              _buildCategoryItem("Pork", "images/Pork.jpg"),
              _buildCategoryItem("Seafood", "images/Seafood.jpg"),
            ]),
            _buildCategorySection("By Course", [
              _buildCategoryItem("Main Dishes", "images/Main_dishes.jpg"),
              _buildCategoryItem("Salad Recipe", "images/Salad.jpg"),
              _buildCategoryItem("Side Dishes", "images/Side_Dishes.jpg"),
              _buildCategoryItem("Crockpot", "images/Crockpot.jpg"),
            ]),
            _buildCategorySection("By Dessert", [
              _buildCategoryItem("Ice Cream", "images/Ice_cream.jpg"),
              _buildCategoryItem("Brownies", "images/Brownies.jpg"),
              _buildCategoryItem("Pies", "images/Pie.jpg"),
              _buildCategoryItem("Cookies", "images/Cookie.jpg"),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, List<Widget> items) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25.0, color: Colors.black),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items,
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String label, String imagePath) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 40,
        ),
        const SizedBox(height: 5),
        Text(
          label.toUpperCase(),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
