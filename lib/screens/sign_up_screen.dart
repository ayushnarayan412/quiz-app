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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 43, 43),
        elevation: 0,
        title: Text(
          login ? 'Signin' : 'Create your account',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/quiz_logo.png'),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // full name in login page for new user
                login
                    ? Container()
                    : TextFormField(
                        key: const ValueKey('fullname'),
                        style: textStyle(),
                        decoration: InputDecoration(
                            hintText: 'Enter full name',
                            hintStyle: textStyle(),
                            prefixIcon: const Icon(
                              Icons.person_outlined,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.cyan, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.cyan, width: 1))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter full name';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            fullname = value!;
                          });
                        },
                      ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: const ValueKey('email'),
                  style: textStyle(),
                  decoration: InputDecoration(
                      hintText: 'Enter Email',
                      hintStyle: textStyle(),
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.cyan, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.cyan, width: 1))),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'please enter valid email';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      email = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                //password
                TextFormField(
                  style: textStyle(),
                  key: const ValueKey('password'),
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                      hintText: 'Enter a password',
                      hintStyle: textStyle(),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () => setState(() {
                                hidePassword = !hidePassword;
                              }),
                          icon: hidePassword
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.white,
                                )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.cyanAccent, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.cyanAccent, width: 1))),
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'please enter password of length 6';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          login
                              ? AuthServices.signinUser(
                                  email, password, context)
                              : AuthServices.signupUser(
                                  email, password, fullname, context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor:
                              const Color.fromARGB(255, 177, 215, 234)),
                      child: Text(
                        login ? ' Signin' : 'Signup',
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        login = !login;
                      });
                    },
                    child: Text(
                      login
                          ? "Don't have an account ? Signin"
                          : 'Already have an acoount ? Login',
                      style: textStyle(),
                    ))
              ],
            ),
          )),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(color: Colors.white);
  }
}
