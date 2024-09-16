import 'package:flutter/material.dart';
import 'package:liquor_store/VodkasCard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import 'colors.dart';
import 'drink.dart';
import 'TequilasCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  PageController pageController = PageController(viewportFraction: .8);

  double pageOffset = 0;
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
    pageController = PageController(viewportFraction: .8);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page ?? 0.0;
        ;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            buildToolbar(),
            buildLogo(size),
            buildPager(size),
            buildPageIndecator(),
          ],
        ),
      ),
    );
  }

  Widget buildToolbar() {
    final GlobalKey<SliderDrawerState> _key =
        GlobalKey<SliderDrawerState>(); // Definir la llave del SliderDrawer
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          // Botón Google Maps
          AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Transform.translate(
                offset: Offset(-200 * (1 - animation.value as double), 0),
                child: InkWell(
                  onTap: () {
                    // Reemplaza por la latitud y longitud deseada
                    const String googleMapsUrl =
                        'https://maps.app.goo.gl/bdWtXVdaXsXtsAhU7';

                    // Verifica si se puede abrir el URL
                    _launchURL(googleMapsUrl);
                  },
                  child: Image.asset(
                    'assets/map.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              );
            },
          ),
          Spacer(),
          // Aquí añades el SliderDrawer en el lado derecho
          InkWell(
            onTap: () {
              _key.currentState
                  ?.toggle(); // Abre o cierra el drawer al presionar el icono
            },
            child: Container(
              width: 40, // Ajustar el tamaño del contenedor
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300, // Color de fondo
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.menu), // Ícono del Drawer
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Positioned(
      top: 10,
      right: size.width / 2.1 - 25,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, snapshot) {
            return Transform(
              transform: Matrix4.identity()
                ..translate(0.0, size.height / 2 * (1 - animation.value))
                ..scale(1 + (1 - animation.value)),
              origin: Offset(25, 25),
              child: InkWell(
                onTap: () => controller.isCompleted
                    ? controller.reverse()
                    : controller.forward(),
                child: Image.asset(
                  'assets/logo.jpg',
                  width: 60,
                  height: 60,
                ),
              ),
            );
          }),
    );
  }

  Widget buildPager(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      height: size.height - 50,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, snapshot) {
          return Transform.translate(
            offset: Offset(400 * (1 - animation.value as double), 0),
            child: PageView.builder(
              controller: pageController,
              itemCount: getDrinks().length +
                  getDrinks2().length, // Suma los dos sets de tarjetas
              itemBuilder: (context, index) {
                final animationValue = animation.value as double;

                // Si el índice está dentro del rango de `getDrinks()`, muestra la primera lista
                if (index < getDrinks().length) {
                  final drink = getDrinks()[index];
                  return Tequilascard(drink, pageOffset, index, animationValue);
                } else {
                  // Cuando el índice sea mayor o igual a la longitud de `getDrinks()`, comienza a mostrar `buildPager2`
                  final drink2 = getDrinks2()[index -
                      getDrinks()
                          .length]; // Ajusta el índice para `getDrinks2()`
                  return Vodkascard(drink2, pageOffset, index, animationValue);
                }
              },
            ),
          );
        },
      ),
    );
  }

  List<Drink> getDrinks() {
    List<Drink> list = [];
    list.add(Drink(
        'Don Julio',
        ' 70',
        'assets/fondo1.jpg',
        'assets/DonJulio70.png',
        'Don Julio 70 combina la complejidad de un añejo con la claridad y frescura de un blanco.\n\n-Tequila\n Cristalino.\n-Aroma floral.\n-Increíblemente\n suave.',
        tGrey,
        tBlack));
    list.add(Drink(
        'Tequila',
        ' 818',
        'assets/fondo2.jpg',
        'assets/818.png',
        'El tequila 818 es una marca creada por Kendall Jenner y se produce en\nJalisco, México.\n\n-Agave Azul Weber\n-Tequila Reposado\n-Sabor a agave\n con notas de\n caramelo y\n vainilla.',
        tOrange,
        tYellow));
    list.add(Drink(
        'Casa',
        ' Noble',
        'assets/fondo3.jpg',
        'assets/CasaNoble.png',
        'Es una expresión elegante y compleja, conocida por su proceso de envejecimiento y su perfil de sabor distintivo.\n\n-Aromas ricos y\n complejos a frutas\n secas y especias.\n-Color ámbar\n profundo.',
        tPurple,
        tBlack));
    return list;
  }

  List<Drink> getDrinks2() {
    List<Drink> list = [];
    list.add(Drink(
        'Absolut',
        ' Vodka',
        'assets/fondo4.jpg',
        'assets/Abdolut2.png',
        'Marca de vodka premium originaria de Suecia, producida cerca de Åhus.\n\n-Sabor suave con un\n toque de frutas\n secas.\n-Hecho con trigo\n de invierno.',
        tBlue,
        tGrey));
    list.add(Drink(
        'Crystal',
        ' Head',
        'assets/fondo5.jpg',
        'assets/CrystalHead.png',
        'Marca premium de vodka conocida por su distintiva botella en forma de calavera.\n\n-Destilado cuatro\n veces a partir de\n maíz canadiense.',
        tBlue,
        tGrey));
    list.add(Drink(
        'Smirnoff',
        '',
        'assets/fondo6.jpg',
        'assets/Smirnoff.png',
        'Una de las marcas de vodka más reconocidas y vendidas en\n el mundo.\n\n-Sabor limpio y\n equilibrado.\n-Sabor a ligeros\n toques de\n grano.',
        tBrown,
        tBrownLight));
    return list;
  }

//Circulos que indican en que pagina estas
  Widget buildPageIndecator() {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, snapshot) {
          return Positioned(
            bottom: 10,
            left: 180,
            child: Opacity(
              opacity: controller.value,
              child: Row(
                // Combina las dos listas de bebidas para mostrar la cantidad total de páginas (6 en este caso)
                children: List.generate(
                    getDrinks().length + getDrinks2().length,
                    (index) => buildContainer(
                        index)), // Genera un círculo por cada tarjeta en ambas listas
              ),
            ),
          );
        });
  }

//Circulos que indican en que pagina no estas
  Widget buildContainer(int index) {
    double animate = pageOffset - index;
    double size = 10;
    animate = animate.abs();
    Color color = Colors.grey;
    if (animate <= 1 && animate >= 0) {
      size = 10 + 10 * (1 - animate);
      color = (ColorTween(begin: Colors.grey, end: tGreen)
              .transform(1 - animate)) ??
          Colors.grey;
    }

    return Container(
      margin: EdgeInsets.all(4),
      height: size,
      width: size,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
    );
  }
}

void _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString); // Convertir la URL a Uri
  if (await canLaunchUrl(url)) {
    await launchUrl(url,
        mode: LaunchMode.externalApplication); // Abre en el navegador
  } else {
    throw 'Could not launch $urlString';
  }
}
