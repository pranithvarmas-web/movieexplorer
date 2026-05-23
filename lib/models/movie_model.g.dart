// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieModelAdapter extends TypeAdapter<MovieModel> {
  @override
  final int typeId = 0;

  @override
  MovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieModel(
      id: fields[0] as int,
      title: fields[1] as String,
      original_title: fields[2] as String,
      backdrop_path: fields[3] as String?,
      original_language: fields[4] as String,
      overview: fields[5] as String,
      poster_path: fields[6] as String?,
      release_date: fields[7] as String,
      vote_average: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MovieModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.original_title)
      ..writeByte(3)
      ..write(obj.backdrop_path)
      ..writeByte(4)
      ..write(obj.original_language)
      ..writeByte(5)
      ..write(obj.overview)
      ..writeByte(6)
      ..write(obj.poster_path)
      ..writeByte(7)
      ..write(obj.release_date)
      ..writeByte(8)
      ..write(obj.vote_average);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
