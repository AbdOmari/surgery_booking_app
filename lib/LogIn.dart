import 'package:final_project_ypu/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String id = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _obscureText = true;
  bool _isLoading = false;

  // Allowed credentials (username:password pairs)
  final Map<String, String> allowedCredentials = {
    'Abdulrhman_Alomari': 'AbdulrhmanAlomari123',
    'Adel_Hafez': 'AdelHafez123',
    'Ahmed_Alaous': 'AhmedAlaous123',
    'Shaenaz_Sh': 'ShaenazSh123',
    'Alaa_Alomari': 'AlaaAlomari123',
    'Moaz_Alomari': 'MoazAlomari123',
    'Omar_Alselk': 'OmarAlselk123',
    'Louai_Alhaffar': 'LouaiAlhaffar123',
  };

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_checkFields);
    _passwordController.addListener(_checkFields);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkFields() {
    setState(() {
      _isButtonEnabled =
          _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void _handleLogin(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text;
    final password = _passwordController.text;

    // Check if username exists and password matches
    if (!allowedCredentials.containsKey(username) ||
        allowedCredentials[username] != password) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog();
      return;
    }

    // Store credentials in Hive
    final box = Hive.box('userBox');
    box.put('username', username);
    box.put('password', password);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Invalid Credentials"),
            content: Text("The username or password is incorrect."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(24),
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 40.h),
                      _header(context),
                      SizedBox(height: 40.h),
                      _inputField(context),
                      _isLoading
                          ? Lottie.asset(
                            'assets/animations/Animation - 1738136512865.json',
                            height: 100.h,
                          )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Text(
            "Welcome Back",
            style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          "Enter your credential to login",
          style: TextStyle(fontSize: 16.sp.sp),
        ),
      ],
    );
  }

  Widget _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: const Color.fromARGB(255, 200, 201, 251),
              filled: true,
              prefixIcon: const Icon(Icons.person),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z_\s]+$')),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username.';
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: const Color.fromARGB(255, 200, 201, 251),
            filled: true,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password.';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters long.';
            }
            return null;
          },
        ),
        SizedBox(height: 30.h),
        ElevatedButton(
          onPressed:
              _isButtonEnabled && !_isLoading
                  ? () => _handleLogin(context)
                  : null,
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor:
                _isButtonEnabled
                    ? const Color.fromARGB(255, 109, 104, 249)
                    : Colors.grey,
          ),
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
