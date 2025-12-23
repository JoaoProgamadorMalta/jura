import 'package:flutter/material.dart';
import 'package:jura/controllers/provider/user.provider.dart';
import 'package:jura/views/initial_page.dart';
import 'package:jura/views/widgets/button_standart.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final int widthContainer = 350;

  Route createRoute(){
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => const InitialPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String name = Provider.of<UserProvider>(context).name ?? 'Usuário';
    String? role = Provider.of<UserProvider>(context).role;

  return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 37, 85),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Text( 'Bem vindo, $name', style: TextStyle(color: Colors.white, fontSize: 20),),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width * 0.6,
              margin: EdgeInsets.only(top: 60),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 197, 153, 32),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.white, size: 30,)),
                  InkWell(
                    onTap: (){},
                    child: Text('Novo Concurso', style: TextStyle(color: Colors.white)),
                  )
                ],
              )
            ),
            Spacer(),
            ButtonStandart(
              text: 'Novo Concurso',
              onPressed: (){},
              height: 80, 
              width: MediaQuery.of(context).size.width * 0.6 ,
              iconButton: true,
              icon: Icon(Icons.add, color: Colors.white, size: 30,),
              ),
            Spacer()
          ],
        ),
      ),
    );
  }
}