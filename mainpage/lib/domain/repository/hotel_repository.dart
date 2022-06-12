import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:mainpage/domain/entities/hotel.dart';

abstract class HotelRepository {
  Future<Either<Failure, List<Hotel>>> getHotelList();
  Future<Either<Failure, Hotel>> getHotelDetail(String id);
  Future<Either<Failure, String>> addFavoriteHotel(Hotel hotel);
  Future<Either<Failure, String>> removeFavoriteHotel(Hotel hotel);
  Future<bool> isAddedToFavorite(String id);
  Future<Either<Failure, List<Hotel>>> getFavoriteHotel();
}
