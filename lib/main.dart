import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:infinite_scroll_flutter_mobx/pokemon_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokemonViewModel controller = PokemonViewModel();

  @override
  void initState() {
    controller.init();
    controller.fetchCards();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (_) {
            if (controller.pokemons.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: controller.pokemons.length + 1,
              itemBuilder: (_, index) {
                if (index == controller.pokemons.length) {
                  controller.fetchCards();

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListTile(
                  title: Text(controller.pokemons[index].name!),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
