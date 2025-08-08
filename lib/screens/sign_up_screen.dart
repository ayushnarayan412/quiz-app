import 'package:flutter/material.dart';
import 'package:new_project/auth/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String fullname = '';
  String password = '';
  bool login = false;
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor:  const Color(0xFF1B262C),

        elevation: 0,
        title: Text(
          login ? 'Sign In' : 'Sign Up',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(14),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Full Name
                  if (!login)
                    buildInputContainer(
                      child: TextFormField(
                        key: const ValueKey('fullname'),
                        style: textStyle(),
                        decoration: buildInputDecoration(
                          hint: 'Enter full name',
                          icon: Icons.person_outlined,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter full name';
                          }
                          return null;
                        },
                        onSaved: (value) => fullname = value!,
                      ),
                    ),
                  const SizedBox(height: 10),
                  // Email
                  buildInputContainer(
                    child: TextFormField(
                      key: const ValueKey('email'),
                      style: textStyle(),
                      decoration: buildInputDecoration(
                        hint: 'Enter Email',
                        icon: Icons.email_outlined,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) => email = value!,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Password
                  buildInputContainer(
                    child: TextFormField(
                      key: const ValueKey('password'),
                      obscureText: hidePassword,
                      style: textStyle(),
                      decoration: buildInputDecoration(
                        hint: 'Enter a password',
                        icon: Icons.lock_outline,
                        suffix: IconButton(
                          onPressed: () => setState(() {
                            hidePassword = !hidePassword;
                          }),
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      onSaved: (value) => password = value!,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Signup Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          login
                              ? AuthServices.signinUser(email, password, context)
                              : AuthServices.signupUser(
                                  email, password, fullname, context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 177, 215, 234),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 6,
                      ),
                      child: Text(
                        login ? 'Signin' : 'Signup',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Switch to Login / SignUp
                  TextButton(
                    onPressed: () {
                      setState(() {
                        login = !login;
                      });
                    },
                    child: Text(
                      login
                          ? "Don't have an account? Signup"
                          : 'Already have an account? Login',
                      style: textStyle(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(color: Colors.white);
  }

  InputDecoration buildInputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.cyanAccent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.cyanAccent, width: 2),
      ),
    );
  }

  Widget buildInputContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 6,
            offset: Offset(2, 4),
          )
        ],
      ),
      child: child,
    );
  }
}
