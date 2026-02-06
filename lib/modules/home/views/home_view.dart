import 'package:bodytech_test/data/models/pokemon_model.dart';
import 'package:bodytech_test/modules/home/controllers/pokemon_controller.dart';
import 'package:bodytech_test/modules/home/views/details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget{
  final PokemonController controller = Get.put(PokemonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4F4),
      appBar: AppBar(
          title: const Text("BodyTech Pokedex"),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () => Get.offAllNamed('/login')),
        ],
      ),
      body: Obx(() {
        if(controller.isLoading.value){
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: controller.pokemonList.length,
          itemBuilder: (context, index){
            final pokemon = controller.pokemonList[index];
            return _buildPokemonCard(pokemon);
          },
        );
      }),
    );
  }

  Widget _buildPokemonCard(Pokemon pokemon){
    final parts = pokemon.url.split('/');
    final String id = parts[parts.length - 2];

    return GestureDetector(
      onTap: (){
        Get.to(() => DetailsView(pokemon: pokemon));
      },
      child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: const Border(
          top: BorderSide(color: Color(0XFFEB6608), width: 4),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("#${id.toString().padLeft(3, '0')}",
          style: const TextStyle(color: Colors.grey, fontSize: 12)),

          Expanded(
              child: Image.network(pokemon.imageUrl),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              pokemon.name.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF2B2D2E),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFEB6608),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: const Center(
              child: Text("DETALLES",
                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    ),
    );
  }
}