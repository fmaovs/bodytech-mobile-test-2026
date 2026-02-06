import 'package:bodytech_test/data/models/pokemon_model.dart';
import 'package:bodytech_test/modules/home/controllers/pokemon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsView extends StatelessWidget{
  final Pokemon pokemon;

  final PokemonController  controller = Get.find<PokemonController>();

  DetailsView({super.key, required this.pokemon}){
    final parts = pokemon.url.split('/');
    final int id = int.parse(parts[parts.length - 2]);

    controller.loadSinglePokemonDetails(id, pokemon.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4F4),
      appBar: AppBar(
          title: Text(pokemon.name.toUpperCase(), 
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: const Color(0xFFEB6608),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),

            const SizedBox(height: 20,),

            Obx(() {
              if(controller.currentDetails.isEmpty){
                return const Center(child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(color: Color(0xFFEB6608)),
                ));
              }
              final details = controller.currentDetails;

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoMetric("Altura", "${details['height'] / 10} m"),
                      _buildInfoMetric("Peso", "${details['weight'] / 10} kg"),
                    ],
                  ),
                  const SizedBox(height: 20,),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Estadísticas de poder", 
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2B2D2E))),
                    ),
                  ),
                  ... (details['stats'] as List).map((s) => _buildStatBar(
                    s['stat']['name'].toString().toUpperCase(), 
                    s['base_stat']
                    )).toList(),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color( 0xFFEB6608),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Hero(
        tag: pokemon.imageUrl,
        child: Image.network(pokemon.imageUrl, height: 280, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildInfoMetric(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2B2D2E))),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildStatBar(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              Text("$value", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFEB6608))),
            ],
          ),
          const SizedBox(height: 5),
          LinearProgressIndicator(
            value: value / 150, 
            backgroundColor: Colors.grey[300],
            color: const Color(0xFFEB6608),
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}