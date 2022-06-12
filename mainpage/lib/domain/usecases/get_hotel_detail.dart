import 'package:dartz/dartz.dart';
import 'package:mainpage/domain/entities/hotel.dart';
import 'package:mainpage/domain/repository/hotel_repository.dart';
import 'package:core/core.dart';

class GetHotelDetail {
  final HotelRepository repository;

  GetHotelDetail(this.repository);

  Future<Either<Failure, Hotel>> execute(String id) {
    return repository.getHotelDetail(id);
  }
}
