import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jura/utils/orientation_helper.dart';
import 'package:jura/views/login_page.dart';
import 'package:jura/views/signup_page.dart';


class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  int _currentIndex = 0;
  final List<Map<int, String>> _imageSliders = [
    {1: 'assets/images/img1.png'},
    {2: 'assets/images/img2.png'},
    {3: 'assets/images/img3.png'},
  ];

  @override
  void initState(){
    super.initState();
    OrientationHelper.lockPortrait();
  }

  @override
  void dispose(){
    OrientationHelper.unlockAllOrientations();
    super.dispose();
  }
    
  Route createRoute(Widget page){
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 37, 85),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                CarouselSlider(
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                    height: 400.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items:
                      _imageSliders.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ),
                              child: Center(
                                child: Image.asset(
                                  i.values.first,
                                  fit: BoxFit.cover,
                                  width: 1000,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                ),
                Positioned(
                  right: 16,
                  bottom: 175,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color.fromARGB(110, 202, 171, 238),
                      ),
                    ),
                    onPressed:
                        () => buttonCarouselController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        ),
                    child: const Text(
                      '->',
                      style: TextStyle(
                        color: Color.fromARGB(110, 255, 255, 255),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 16,
                  bottom: 175,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Color.fromARGB(110, 202, 171, 238),
                      ),
                    ),
                    onPressed:
                        () => buttonCarouselController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        ),
                    child: const Text(
                      '<-',
                      style: TextStyle(
                        color: Color.fromARGB(110, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  _imageSliders.asMap().entries.map((entry) {
                    return Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 4,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentIndex == entry.key
                                ? Colors.white
                                : Colors.grey,
                      ),
                    );
                  }).toList(),
            ),
            const Text(
              'Bem vindo ao JurApp', 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(Size(115, 40)),
                backgroundColor: WidgetStateProperty.all(
                  Color.fromARGB(255, 197, 153, 32),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(createRoute(const LoginPage()));
              },
              child: const Text('Entrar', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: WidgetStateProperty.all(Size(115, 40)),
                backgroundColor: WidgetStateProperty.all(
                  Color.fromARGB(255, 197, 153, 32),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(createRoute(const SignUpPage()));
              },
              child: const Text('Cadastrar', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
