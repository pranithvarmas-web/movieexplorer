import 'package:flutter/material.dart';
import 'package:movie_db_assign/presentation/home/pages/search_screen.dart';
import 'package:movie_db_assign/presentation/home/widgets/custom_multiblocprovider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF000428),
                Color(0xFF004e92),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/movie.png",
              fit: BoxFit.cover,
              height: 50,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(width: 16),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: const CustomMultiBlocProvider(),
    );
  }
}


