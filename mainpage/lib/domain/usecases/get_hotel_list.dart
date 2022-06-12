import 'package:dartz/dartz.dart';
import 'package:mainpage/domain/entities/hotel.dart';
import 'package:mainpage/domain/repository/hotel_repository.dart';
import 'package:core/core.dart';

class GetHotelList {
  final HotelRepository repository;

  GetHotelList(this.repository);

  Future<Either<Failure, List<Hotel>>> execute() {
    return repository.getHotelList();
  }
}
