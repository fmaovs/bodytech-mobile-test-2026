import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/pokemon_controller.dart';
import 'details_view.dart';
import '../../../data/models/pokemon_model.dart';

class HomeView extends StatelessWidget {
  final PokemonController controller = Get.put(PokemonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4F4),
      appBar: AppBar(
        title: const Text("BODYTECH POKÉDEX", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        backgroundColor: const Color(0xFF2B2D2E),
        centerTitle: false,
        actions: [
          IconButton(
              icon: const Icon(Icons.logout, color: Color(0xFFEB6608)),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAllNamed('/login');
              }
          ),
        ],
      ),
      body: Obx(() {
        if(controller.isLoading.value) return const Center(child: CircularProgressIndicator(color: Color(0xFFEB6608)));

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: controller.pokemonList.length,
          itemBuilder: (context, index) => _buildCard(controller.pokemonList[index]),
        );
      }),
    );
  }

  Widget _buildCard(Pokemon pokemon) {
    return GestureDetector(
      onTap: () => Get.to(() => DetailsView(pokemon: pokemon)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFFEB6608),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                ),
                child: Text("#${pokemon.url.split('/').reversed.elementAt(1)}",
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(child: Hero(tag: pokemon.imageUrl, child: Image.network(pokemon.imageUrl))),
            Text(pokemon.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 8),
            const Text("VER FICHA", style: TextStyle(color: Color(0xFFEB6608), fontSize: 10, fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}