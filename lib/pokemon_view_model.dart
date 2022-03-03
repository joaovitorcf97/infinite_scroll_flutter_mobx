import 'package:infinite_scroll_flutter_mobx/pokemon_model.dart';
import 'package:infinite_scroll_flutter_mobx/pokemon_service.dart';
import 'package:mobx/mobx.dart';
import 'dart:developer' as developer;

part 'pokemon_view_model.g.dart';

class PokemonViewModel = _PokemonViewModelBase with _$PokemonViewModel;

abstract class _PokemonViewModelBase with Store {
  final PokemonServiceInterface _service = PokemonService(DioService());

  bool isFetchData = false;
  int _offset = 0;
  final int _limit = 21;

  void init() {
    _service;
  }

  ObservableList<Results> pokemons = ObservableList<Results>();

  Future fetchCards() async {
    if (isFetchData) {
      return;
    }

    isFetchData = true;

    developer.log(_offset.toString());

    var paginate = PaginationModel(page: _offset, limit: _limit);
    var res = await _service.fetchPokemons(paginate);

    if (res.results != null && res.results!.isNotEmpty) {
      pokemons.addAll(res.results!);
      _offset = _offset + 21;
    }

    isFetchData = false;
  }
}
