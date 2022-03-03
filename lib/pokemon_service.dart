import 'package:dio/dio.dart';
import 'package:infinite_scroll_flutter_mobx/pokemon_model.dart';

abstract class IDioService {
  Dio getDio();
}

class DioService implements IDioService {
  @override
  Dio getDio() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://pokeapi.co/api/v2/',
      ),
    );
  }
}

abstract class PokemonServiceInterface {
  Future<PokemonsModel> fetchPokemons(PaginationModel paginate);
}

class PokemonService extends PokemonServiceInterface {
  final DioService _dioService;

  PokemonService(this._dioService);

  @override
  Future<PokemonsModel> fetchPokemons(PaginationModel paginate) async {
    var queryParameters = {"offset": paginate.page, "limit": paginate.limit};

    var response = await _dioService.getDio().get(
          'pokemon',
          queryParameters: queryParameters,
        );

    return PokemonsModel.fromJson(response.data);
  }
}
