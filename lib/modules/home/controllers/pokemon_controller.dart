import 'package:bodytech_test/core/storage_service.dart';
import 'package:bodytech_test/data/models/pokemon_model.dart';
import 'package:get/get.dart';
import 'package:bodytech_test/data/providers/pokemon_provider.dart';

class PokemonController extends GetxController {

  final PokemonProvider _provider = PokemonProvider();

  var pokemonList = <Pokemon>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadPokemons();
  }

  Future<void> loadPokemons() async{
    try {
      isLoading(true);
      final rawData = await _provider.getPokemonList();

      await StorageService.savePokemonData(rawData);
      pokemonList.value = rawData.map((item) => Pokemon.fromJson(item)).toList();
    } catch (e){
      final offLineData = StorageService.getCachedPokemon();
      if(offLineData != null) {
        pokemonList.value = offLineData.map((item) => Pokemon.fromJson(item)).toList();
        Get.snackbar("Modo Offline", "Mostrando datos guardados localmente",
                      snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", "No hay internet ni datos almacenados localmente");
      }
      print("Error al cargar: $e");
    } finally {
      isLoading(false);
    }
  }

  var currentDetails = {}.obs;

  Future<void> loadSinglePokemonDetails(int id, String url) async {

    currentDetails.value = {};

    final localData = StorageService.getPokemonDetail(id);
    if(localData != null) {
      currentDetails.value = localData;
      return;
    }

    try{
      final remoteData = await _provider.getPokemonDetails(url);
      currentDetails.value = remoteData;
      await StorageService.savePokemonDetail(id, remoteData);
    } catch (e) {
      Get.snackbar("Error", "No hay conexion para descargar detalles nuevos");
    }
  }
}