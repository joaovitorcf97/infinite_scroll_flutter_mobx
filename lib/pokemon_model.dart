import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PokemonsModel {
  int? count;
  String? next;
  List<Results>? results;

  PokemonsModel({this.count, this.next, this.results});

  PokemonsModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = count;
    data['next'] = next;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() =>
      'PokemonsModel(count: $count, next: $next, results: $results)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonsModel &&
        other.count == count &&
        other.next == next &&
        listEquals(other.results, results);
  }

  @override
  int get hashCode => count.hashCode ^ next.hashCode ^ results.hashCode;

  PokemonsModel copyWith({
    int? count,
    String? next,
    List<Results>? results,
  }) {
    return PokemonsModel(
      count: count ?? this.count,
      next: next ?? this.next,
      results: results ?? this.results,
    );
  }
}

class Results {
  String? name;
  String? url;

  Results({this.name, this.url});

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['url'] = url;
    return data;
  }

  @override
  String toString() => 'Results(name: $name, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Results && other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;

  Results copyWith({
    String? name,
    String? url,
  }) {
    return Results(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }
}

class PaginationModel {
  final int page;
  final int limit;

  PaginationModel({
    required this.page,
    required this.limit,
  });
}
