import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_assign/constants/constants.dart';
import 'package:movie_db_assign/models/movie_model.dart';
import 'package:movie_db_assign/presentation/trending/bloc/trending_bloc.dart';
import 'package:movie_db_assign/presentation/trending/pages/now_playing_details.dart';
import 'package:movie_db_assign/presentation/trending/widgets/trending_movies_details_gesture.dart';

class TrendingSizedBox extends StatefulWidget {
  final List<MovieModel> movies;

  const TrendingSizedBox({super.key, required this.movies});

  @override
  State<TrendingSizedBox> createState() => _TrendingSizedBoxState();
}

class _TrendingSizedBoxState extends State<TrendingSizedBox> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.55);
    _pageController.addListener(_pageScrollListener);
  }

  void _pageScrollListener() {
    if (_pageController.hasClients && _pageController.position.hasPixels) {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrendingBloc, TrendingState>(
      listener: (context, state) {
        if (state is TrendingMovieSelected) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsPage(movie: state.selectedMovie),
            ),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              final imageUrl = '${Constants.imagePath}${movie.backdrop_path}';

              return LayoutBuilder(
                builder: (context, constraints) {
                  final double scale = _calculateScale(index);
                  final double opacity = _calculateOpacity(index);

                  return TrendingMoviesDetailsGesture(
                    itemWidth: constraints.maxWidth * 0.55,
                    scale: scale,
                    opacity: opacity,
                    imageUrl: imageUrl,
                    movieModel: movie,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  double _calculateScale(int index) {
    if (!_pageController.hasClients || !_pageController.position.hasPixels || !_pageController.position.hasContentDimensions) {
      return 1.0;
    }
    const double scaleFactor = 0.3;
    return (1 - ((_pageController.page ?? 0) - index).abs() * scaleFactor).clamp(0.8, 1.0);
  }

  double _calculateOpacity(int index) {
    if (!_pageController.hasClients || !_pageController.position.hasPixels || !_pageController.position.hasContentDimensions) {
      return 1.0;
    }
    const double opacityFactor = 0.5;
    return (1 - ((_pageController.page ?? 0) - index).abs() * opacityFactor).clamp(0.3, 1.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}


