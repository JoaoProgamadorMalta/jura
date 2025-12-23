import 'package:flutter/material.dart';
import 'package:jura/controllers/provider/user.provider.dart';
import 'package:jura/views/widgets/button_standart.dart';
import 'package:provider/provider.dart';

class HomePageCompetitor extends StatefulWidget {
  const HomePageCompetitor({super.key});

  @override
  State<HomePageCompetitor> createState() => _HomePageCompetitorState();
}

class _HomePageCompetitorState extends State<HomePageCompetitor> {
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
            Spacer(),
            ButtonStandart(
              text: 'hubyigvbygbv',
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