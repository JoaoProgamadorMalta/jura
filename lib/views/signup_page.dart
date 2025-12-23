import 'package:flutter/material.dart';
import 'package:jura/controllers/services/auth_service.dart';
import 'package:jura/utils/orientation_helper.dart';
import 'package:jura/views/home_page.dart';
import 'package:jura/views/initial_page.dart';
import 'package:jura/views/role_based_page.dart.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

enum UserRole { admin, competitor, juror }

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final int widthContainer = 350;
  UserRole? _selectedRole;
  AuthService authService = AuthService();

  bool _isLoading = false;
  bool? _isSuccess; // null = nada, true = sucesso, false = erro

  @override
  void initState() {
    super.initState();
    OrientationHelper.unlockAllOrientations();
  }
  
  Route createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
      _isSuccess = null;
    });

    try {
      await authService.registerUser(
        email: emailController.text,
        role: _selectedRole!.name,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        name: nameController.text,
        context: context,
      );

      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          createRoute(const RoleBasedPage()),
        );
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isSuccess = false;
      });

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          createRoute(const SignUpPage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 37, 85),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.amber)
            : _isSuccess != null
                ? Column(
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
                            ? "Cadastro realizado com sucesso!"
                            : "Erro ao realizar cadastro!",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
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
                        Container(
                          margin: const EdgeInsets.only(top: 20),
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
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.white),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(top: 30, bottom: 30),
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
                              prefixIcon:
                                  Icon(Icons.lock, color: Colors.white),
                              labelText: 'Senha',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
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
                            controller: confirmPasswordController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.password,
                                  color: Colors.white),
                              labelText: 'Confirmar Senha',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          width: widthContainer.toDouble(),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 197, 153, 32),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black),
                          ),
                          child: TextFormField(
                            controller: nameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.white),
                              labelText: 'Nome',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        RadioListTile<UserRole>(
                          activeColor:
                              const Color.fromARGB(255, 197, 153, 32),
                          title: const Text('Administrador',
                              style: TextStyle(color: Colors.white)),
                          value: UserRole.admin,
                          groupValue: _selectedRole,
                          onChanged: (UserRole? value) {
                            setState(() {
                              _selectedRole = value;
                            });
                          },
                        ),
                        RadioListTile<UserRole>(
                          activeColor:
                              const Color.fromARGB(255, 197, 153, 32),
                          title: const Text('Competidor',
                              style: TextStyle(color: Colors.white)),
                          value: UserRole.competitor,
                          groupValue: _selectedRole,
                          onChanged: (UserRole? value) {
                            setState(() {
                              _selectedRole = value;
                            });
                          },
                        ),
                        RadioListTile<UserRole>(
                          activeColor:
                              const Color.fromARGB(255, 197, 153, 32),
                          title: const Text('Jurado',
                              style: TextStyle(color: Colors.white)),
                          value: UserRole.juror,
                          groupValue: _selectedRole,
                          onChanged: (UserRole? value) {
                            setState(() {
                              _selectedRole = value;
                            });
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize: WidgetStateProperty.all(
                                Size(widthContainer.toDouble() / 3, 50)),
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
                          onPressed: _register,
                          child: const Text('Cadastrar',
                              style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
