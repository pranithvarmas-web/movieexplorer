import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_assign/presentation/home/blocs/home_bloc.dart';
import 'package:movie_db_assign/presentation/trending/pages/now_playing_details.dart';
import 'package:movie_db_assign/repository/repo_api.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
        backgroundColor: Colors.black12,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(RepoApi())..add(LoadMoviesEvent()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
            } else if (state is HomeLoaded) {
              return Column(
                children: [
                  TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search Movies...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[800],
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                    ),
                    autofocus: true,
                    onChanged: (query) {
                      context.read<HomeBloc>().add(SearchLoadMoviesEvent(query));
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.results.length,
                      itemBuilder: (context, index) {
                        final movie = state.results[index];
                        return ListTile(
                          title: Text(movie.title, style: const TextStyle(color: Colors.white)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsPage(movie: movie),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}


