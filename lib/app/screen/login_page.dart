import 'package:flutter/material.dart';
import 'package:login_register/app/controllers/login_controller.dart';
import 'package:login_register/app/controllers/Database.dart';
import 'package:login_register/app/controllers/validation.dart';
import 'package:login_register/app/screen/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:login_register/app/controllers/validation.dart'

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formState = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> Login() async {
    // final perfs = await SharedPreferences.getInstance();
    // String? savedUsername = perfs.getString('username');
    // String? savedPassword = perfs.getString('password');

    String email = emailController.text;
    String password = passwordController.text;
    print(database);
    for (var data in database) {
      if (data.email == email && data.password == password) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(model: data)));
      }
    }

    // if (username == savedUsername && password == savedPassword) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text('Register Berhasil')));
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Username atau Password Salah')));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue.shade500, Colors.indigo.shade900])),
          child: Form(
            key: _formState, //Agar terhubung ke GlobalKey
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Selamat Datang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                // Align(
                //   alignment: Alignment.center,
                //   child: Icon(Icons.person, size: 100, color: Colors.blue),
                // ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 100),

                        //Email
                        TextFormField(
                          controller: emailController, // Penghubung Controller
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email Tidak Boleh Kosong!';
                            } else if (!isEmailValid(value)) {
                              return 'Email Tidak Valid!';
                            }
                            return null; //Jika berhasil
                          },
                        ),
                        //Password Form
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password Tidak Boleh Kosong!';
                            } else if (value.length < 8) {
                              return 'Password Wajib 8 Karakter!';
                            }
                            return null;
                          },
                        ),

                        // Login Button
                        SizedBox(height: 20),
                        Container(
                          width: 450,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.blue.shade500,
                                Colors.indigo.shade900
                              ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            onPressed: () {
                              print(_formState.currentState!.validate());
                              if (_formState.currentState!.validate()) {
                                Login();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Mohon Periksa Inputan Anda!')));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                foregroundColor: Colors.white),
                            child: Text(
                              'Login',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        //Register Form (Masuk Ke Page 2 untuk Daftar/Register)
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Register');
                            },
                            child: Text('Belum Punya Akun?'))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
