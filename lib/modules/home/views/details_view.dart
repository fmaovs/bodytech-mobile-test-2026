import 'package:bodytech_test/data/models/pokemon_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget{
  final Pokemon pokemon;

  const DetailsView({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(pokemon.name),
        backgroundColor: const Color(0xFFEB6608),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
                decoration: const BoxDecoration(
                 color: Color(0xFFEB6608),
                 borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(40),
                   bottomRight: Radius.circular(40),
                 ),
                ),
              child: Hero(
                  tag: pokemon.imageUrl,
                  child: Image.network(pokemon.imageUrl, height: 250),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              pokemon.name.toUpperCase(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            _buildStatCard("Enlace de Datos", pokemon.url),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        child: ListTile(
          title: Text(label),
          subtitle: Text(value, style: const TextStyle(fontSize: 12)),
          leading: const Icon(Icons.info_outline, color: Color(0xFFEB6608)),
        ),
      ),
    );
  }
}