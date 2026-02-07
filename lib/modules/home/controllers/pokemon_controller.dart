import 'package:bodytech_test/core/storage_service.dart';
import 'package:bodytech_test/data/models/pokemon_model.dart';
import 'package:get/get.dart';
import 'package:bodytech_test/data/providers/pokemon_provider.dart';

class PokemonController extends GetxController {
  final PokemonProvider _provider = PokemonProvider();
  var pokemonList = <Pokemon>[].obs;
  var isLoading = true.obs;
  var currentDetails = {}.obs;

  @override
  void onInit() {
    super.onInit();
    // Cargar cache 
    _loadLocalData();

    loadPokemons();
  }

  void _loadLocalData() {
    final offlineData = StorageService.getCachedPokemon();
    if (offlineData != null) {
      pokemonList.value = offlineData.map((item) => Pokemon.fromJson(item)).toList();
    }
  }

  Future<void> loadPokemons() async {
    try {
      isLoading(true);
      final rawData = await _provider.getPokemonList();
      
      // Guardar en Hive lo nuevo de la API
      await StorageService.savePokemonData(rawData);
      
      pokemonList.value = rawData.map((item) => Pokemon.fromJson(item)).toList();
    } catch (e) {
      _loadLocalData();
      if (pokemonList.isEmpty) {
        Get.snackbar("Error", "No hay conexión ni datos locales",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Modo Offline", "Mostrando datos guardados localmente",
            snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadSinglePokemonDetails(int id, String url) async {
    currentDetails.value = {};

    final localData = StorageService.getPokemonDetail(id);
    if (localData != null) {
      currentDetails.value = localData;
      return;
    }

    try {
      final remoteData = await _provider.getPokemonDetails(url);
      currentDetails.value = remoteData;
      await StorageService.savePokemonDetail(id, remoteData);
    } catch (e) {
      Get.snackbar("Error", "No se pudieron descargar los detalles",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}