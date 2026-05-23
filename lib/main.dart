import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_db_assign/constants/constants.dart';
import 'package:movie_db_assign/presentation/home/pages/home_screen.dart';

import 'models/movie_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieModelAdapter());
  await Hive.openBox<MovieModel>('moviesTrending');
  await Hive.openBox<MovieModel>('moviesPopular');
  await Hive.openBox<MovieModel>('moviesTopRated');
  await Hive.openBox<MovieModel>('moviesUpComing');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies Explorer',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor:Constants.scaffoldBgColor,
      ),
      home: const HomeScreen(),
    );
  }
}