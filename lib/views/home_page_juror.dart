import 'package:flutter/material.dart';
import 'package:jura/controllers/provider/user.provider.dart';
import 'package:provider/provider.dart';

class HomePageJuror extends StatefulWidget {
  const HomePageJuror({super.key});

  @override
  State<HomePageJuror> createState() => _HomePageJurorState();
}

class _HomePageJurorState extends State<HomePageJuror> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 37, 85),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Text( 'Bem vindo, ${user.name}', style: TextStyle(color: Colors.white, fontSize: 20),),
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
                  IconButton(onPressed: (){}, icon: Icon(Icons.history, color: Colors.white, size: 30,)),
                  InkWell(
                    onTap: (){},
                    child: Text('Histórico', style: TextStyle(color: Colors.white)),
                  )
                ],
              )
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}