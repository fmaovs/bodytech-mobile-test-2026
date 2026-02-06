class Pokemon {
  final String name;
  final String url;
  final String imageUrl;

  Pokemon({
    required this.name,
    required this.url,
    required this.imageUrl
  });

  factory Pokemon.fromJson(Map<String, dynamic> json){
    final String pokeUrl = json['url'];

    final parts = pokeUrl.split('/');
    final id = parts[parts.length - 2];

    return Pokemon(name: json['name'], url: pokeUrl, imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }
}