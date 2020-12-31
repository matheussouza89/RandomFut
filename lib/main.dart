import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomfut/bloc/player_bloc.dart';
import 'package:randomfut/pages/listaCadasCas.page.dart';
import 'package:randomfut/pages/login.page.dart';
import 'package:randomfut/pages/modo.page.dart';
import 'package:randomfut/routes/app_routes.dart';
import 'package:randomfut/views/player_form.dart';
import 'bloc/player_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerBloc>(
      create: (context) => PlayerBloc(),
      child: MaterialApp(
        title: 'RandomFut',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: {
          AppRoutes.HOME: (_) => LoginPage(),
          AppRoutes.LISTACADASCAS: (_) => ListaCadasCas(),
          AppRoutes.MODO: (_) => ModoPage(),
          AppRoutes.PLAYERFORM: (_) => PlayerForm(),
        },
      ),
    );
  }
}
