import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jura/controllers/provider/user.provider.dart';
import 'package:jura/controllers/services/auth_service.dart';
import 'package:jura/utils/orientation_helper.dart';
import 'package:jura/views/home_page.dart';
import 'package:jura/views/initial_page.dart';
import 'package:jura/views/role_based_page.dart.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final int widthContainer = 350;
  bool _isLoading = false;
  bool? _isSuccess;

  Route createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  /*void _loginTest(String role){
    if(role == 'competitor'){
      Provider.of<UserProvider>(context, listen: false).setName('Competitor');
      Provider.of<UserProvider>(context, listen: false).setRole(role);
      Provider.of<UserProvider>(context, listen: false).setEmail('test@gmail.com');
      Provider.of<UserProvider>(context, listen: false).setCreatedAt(DateTime.now());
    }else if (role == 'juror'){
      Provider.of<UserProvider>(context, listen: false).setName('Juror');
      Provider.of<UserProvider>(context, listen: false).setRole(role);
      Provider.of<UserProvider>(context, listen: false).setEmail('test@gmail.com');
      Provider.of<UserProvider>(context, listen: false).setCreatedAt(DateTime.now());
    }else if(role == 'admin'){
      Provider.of<UserProvider>(context, listen: false).setName('Admin');
      Provider.of<UserProvider>(context, listen: false).setRole(role);
      Provider.of<UserProvider>(context, listen: false).setEmail('test@gmail.com');
      Provider.of<UserProvider>(context, listen: false).setCreatedAt(DateTime.now());
    }
  }*/

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _isSuccess = null;
    });

    try {
      final user = await authService.loginUser(
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );

      if (user == null) {
        setState(() {
          _isLoading = false;
          _isSuccess = false;
        });

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _isSuccess = null;
            });
          }
        });
        return;
      }

      // Caso sucesso
      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.of(
            context,
          ).pushReplacement(createRoute(const RoleBasedPage()));
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isSuccess = false;
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isSuccess = null; // volta pro formulário
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    OrientationHelper.unlockAllOrientations();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 37, 85),
      body:
          _isLoading
              ? Center(
                child: const CircularProgressIndicator(color: Colors.amber),
              )
              : _isSuccess != null
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isSuccess! ? Icons.check_circle : Icons.error,
                      color: _isSuccess! ? Colors.green : Colors.red,
                      size: 80,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _isSuccess!
                          ? "Login realizado com sucesso!"
                          : "Erro ao realizar login!",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              )
              : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 60),
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                createRoute(const InitialPage()),
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                      ),
                    ),
                    const CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/images/test.png'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 60),
                      width: widthContainer.toDouble(),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 197, 153, 32),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.white),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 20),
                      width: widthContainer.toDouble(),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 197, 153, 32),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        obscuringCharacter: '*',
                        controller: passwordController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: WidgetStateProperty.all(
                          Size(widthContainer.toDouble() / 3, 50),
                        ),
                        backgroundColor: WidgetStateProperty.all(
                          const Color.fromARGB(255, 197, 153, 32),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      onPressed: _login,
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    /*
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: WidgetStateProperty.all(
                            Size(widthContainer.toDouble() / 3, 50),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 197, 153, 32),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: (){
                          _loginTest('admin');
                          Navigator.of(context).pushReplacement(createRoute(const HomePage()));      
                        },
                        child: const Text(
                          'ADM',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: WidgetStateProperty.all(
                            Size(widthContainer.toDouble() / 3, 50),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 197, 153, 32),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: (){
                          _loginTest('juror');
                          Navigator.of(context).pushReplacement(createRoute(const HomePage()));      
                        },
                        child: const Text(
                          'JURADO',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: WidgetStateProperty.all(
                            Size(widthContainer.toDouble() / 3, 50),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 197, 153, 32),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: (){
                          _loginTest('competitor');
                          Navigator.of(context).pushReplacement(createRoute(const HomePage()));      
                        },
                        child: const Text(
                          'COMP',
                          style: TextStyle(color: Colors.white),
                        ),
                      )*/
                  ],
                ),
              ),
    );
  }
}
