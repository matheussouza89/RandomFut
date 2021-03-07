import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomfut/bloc/player_bloc.dart';
import 'package:randomfut/bloc/team_bloc.dart';
import 'package:randomfut/views/listaCadasCas.page.dart';
import 'package:randomfut/views/listaCadasCamp.dart';
import 'package:randomfut/views/login.page.dart';
import 'package:randomfut/views/modo.page.dart';
import 'package:randomfut/routes/app_routes.dart';
import 'package:randomfut/views/player_form.dart';
import 'package:randomfut/views/team_form.dart';
import 'bloc/player_bloc.dart';

void main() => runApp(
  MultiBlocProvider(
    providers: [
      BlocProvider<PlayerBloc>(
      create: (context) => PlayerBloc()),
      BlocProvider<TeamBloc>(
      create: (context) => TeamBloc()),
    ], 
    child: MyApp()
    )
  );

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
          AppRoutes.LISTACADASCAMP: (_) => ListaCadasCamp(),
          AppRoutes.MODO: (_) => ModoPage(),
          AppRoutes.PLAYERFORM: (_) => PlayerForm(),
          AppRoutes.TEAMFORM: (_) => TeamForm(),
        },
      ),
    );
  }
}
