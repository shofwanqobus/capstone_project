import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:mainpage/domain/entities/hotel.dart';
import 'package:mainpage/domain/repository/hotel_repository.dart';

class RemoveFavoriteHotel {
  final HotelRepository repository;

  RemoveFavoriteHotel(this.repository);

  Future<Either<Failure, String>> execute(Hotel hotel) {
    return repository.removeFavoriteHotel(hotel);
  }
}
