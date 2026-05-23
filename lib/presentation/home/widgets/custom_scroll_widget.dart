import 'package:flutter/material.dart';
import 'package:movie_db_assign/presentation/home/widgets/popular_title_gesture.dart';
import 'package:movie_db_assign/presentation/home/widgets/toprated_title_gesture.dart';
import 'package:movie_db_assign/presentation/home/widgets/trending_title_gesture.dart';
import 'package:movie_db_assign/presentation/home/widgets/upcoming_title_gesture.dart';
import 'package:movie_db_assign/presentation/popular/widgets/popular_slider.dart';
import 'package:movie_db_assign/presentation/top_rated/widgets/toprated_slider.dart';
import 'package:movie_db_assign/presentation/trending/widgets/trending_slider.dart';
import 'package:movie_db_assign/presentation/upcoming/widgets/upcoming_slider.dart';

class CustomScrollViewWidget extends StatelessWidget {
  const CustomScrollViewWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TrendingTitleGesture(),
            SizedBox(height: 10),
            TrendingSlider(),
            SizedBox(height: 12),
            PopularTitleGesture(),
            PopularSlider(),
            SizedBox(height: 12),
            TopratedTitleGesture(),
            TopRatedSlider(),
            SizedBox(height: 12),
            UpcomingTitleGesture(),
            UpcomingSlider(),
          ],
        ),
      ),
    );
  }
}

