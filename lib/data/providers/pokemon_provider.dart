import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonProvider {
  Future<List<dynamic>> getPokemonList() async{
    try{
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50'));
      if(response.statusCode == 200){
        final Map<String, dynamic> data = json.decode(response.body);
        return data['results'];
      } else {
        throw Exception('Error al conectar con el servidor');
      }

    } catch (e){
      throw Exception("Fallo en la red: $e");
    }
  }

  Future<Map<String, dynamic>> getPokemonDetails(String url) async {
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        return json.decode(response.body);
      } else {
        throw Exception('Error al cargar detalles');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}