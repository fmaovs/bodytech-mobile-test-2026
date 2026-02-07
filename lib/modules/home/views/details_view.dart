import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pokemon_controller.dart';
import '../../../data/models/pokemon_model.dart';

class DetailsView extends StatelessWidget {
  final Pokemon pokemon;
  final PokemonController controller = Get.find<PokemonController>();

  DetailsView({super.key, required this.pokemon}) {
    final id = int.parse(pokemon.url.split('/').reversed.elementAt(1));
    controller.loadSinglePokemonDetails(id, pokemon.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
        backgroundColor: const Color(0xFF2B2D2E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF2B2D2E),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
              ),
              child: Hero(tag: pokemon.imageUrl, child: Image.network(pokemon.imageUrl, fit: BoxFit.contain)),
            ),
            Obx(() {
              if(controller.currentDetails.isEmpty) return const Padding(padding: EdgeInsets.all(50), child: CircularProgressIndicator(color: Color(0xFFEB6608)));

              final details = controller.currentDetails;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _metric("PESO", "${details['weight']/10} kg"),
                        _metric("ALTURA", "${details['height']/10} m"),
                      ],
                    ),
                    const Divider(height: 40),
                    const Align(alignment: Alignment.centerLeft, child: Text("ESTADÍSTICAS BASE", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16))),
                    const SizedBox(height: 15),
                    ...(details['stats'] as List).map((s) => _statBar(s['stat']['name'], s['base_stat'])).toList(),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _metric(String label, String value) {
    return Column(children: [
      Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Text(label, style: const TextStyle(color: Color(0xFFEB6608), fontSize: 12, fontWeight: FontWeight.bold)),
    ]);
  }

  Widget _statBar(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: value / 150,
            backgroundColor: const Color(0xFFF5F4F4),
            color: const Color(0xFFEB6608),
            minHeight: 8,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }
}