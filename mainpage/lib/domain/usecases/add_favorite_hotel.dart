import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:mainpage/domain/entities/hotel.dart';
import 'package:mainpage/domain/repository/hotel_repository.dart';

class AddFavoriteHotel {
  final HotelRepository repository;

  AddFavoriteHotel(this.repository);

  Future<Either<Failure, String>> execute(Hotel hotel) {
    return repository.addFavoriteHotel(hotel);
  }
}
