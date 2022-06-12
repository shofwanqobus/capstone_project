import 'package:mainpage/domain/repository/hotel_repository.dart';

class GetHotelStatus {
  final HotelRepository repository;

  GetHotelStatus(this.repository);

  Future<bool> execute(String id) async {
    return repository.isAddedToFavorite(id);
  }
}
