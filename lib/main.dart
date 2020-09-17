import 'package:flutter/material.dart';
import 'package:randomfut/pages/login.page.dart';
import 'package:provider/provider.dart';
import 'package:randomfut/provider/players.dart';
import 'package:randomfut/routes/app_routes.dart';
import 'package:randomfut/views/player_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Players(),
        ),
      ],
      child: MaterialApp(
        title: 'RandomFut',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: {
          AppRoutes.HOME: (_) => LoginPage(),
          AppRoutes.CAMPEONATO: (_) => LoginPage(),
          AppRoutes.CAMPEONATOTIPO: (_) => LoginPage(),
          AppRoutes.CASUAL: (_) => LoginPage(),
          AppRoutes.CASUALTIPO: (_) => LoginPage(),
          AppRoutes.LISTACADASCAS: (_) => LoginPage(),
          AppRoutes.MODO: (_) => LoginPage(),
          AppRoutes.PLAYERFORM: (_) => PlayerForm(),
        },
      ),
    );
  }
}
