class PokemonListData {
  int? count;
  String? next;
  String? previous;
  List<PokemonListResult>? results;

  PokemonListData({this.count, this.next, this.previous, this.results});

  PokemonListData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <PokemonListResult>[];
      json['results'].forEach((v) {
        results!.add(PokemonListResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  PokemonListData copyWith({
    int? count,
    String? next,
    String? previous,
    List<PokemonListResult>? results,
  }) {
    return PokemonListData(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}

class PokemonListResult {
  String? name;
  String? url;

  PokemonListResult({this.name, this.url});

  PokemonListResult.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class Pokemon {
  List<Abilities>? abilities;
  int? height;
  int? id;
  List<Moves>? moves;
  String? name;
  Sprites? sprites;
  List<Stats>? stats;
  int? weight;
  int? baseExperience;
  bool? isDefault;
  String? locationAreaEncounters;
  String? description;
  Specie? species;
  DetailedSpecies? detailedSpecies;

  Pokemon({
    this.abilities,
    this.height,
    this.id,
    this.moves,
    this.name,
    this.sprites,
    this.stats,
    this.weight,
    this.baseExperience,
    this.isDefault,
    this.locationAreaEncounters,
    this.species,
    this.detailedSpecies,
  });

  Pokemon.fromJson(Map<String, dynamic> json) {
    if (json['abilities'] != null) {
      abilities = <Abilities>[];
      json['abilities'].forEach((v) {
        abilities!.add(Abilities.fromJson(v));
      });
    }
    height = json['height'];
    id = json['id'];
    if (json['moves'] != null) {
      moves = <Moves>[];
      json['moves'].forEach((v) {
        moves!.add(Moves.fromJson(v));
      });
    }
    name = json['name'] as String?;

    species = json['species'] != null && json['species'] is Map<String, dynamic>
        ? Specie.fromJson(json['species'])
        : null;
    detailedSpecies = null;

    sprites =
        json['sprites'] != null ? Sprites.fromJson(json['sprites']) : null;
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(Stats.fromJson(v));
      });
    }
    weight = json['weight'];
    baseExperience = json['base_experience'];
    isDefault = json['is_default'];
    locationAreaEncounters = json['location_area_encounters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (abilities != null) {
      data['abilities'] = abilities!.map((v) => v.toJson()).toList();
    }
    data['height'] = height;
    data['id'] = id;
    if (moves != null) {
      data['moves'] = moves!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    if (species != null) {
      data['species'] = species!.toJson();
    }
    if (detailedSpecies != null) {
      data['detailed_species'] = detailedSpecies!.toJson();
    }
    if (sprites != null) {
      data['sprites'] = sprites!.toJson();
    }
    if (stats != null) {
      data['stats'] = stats!.map((v) => v.toJson()).toList();
    }
    data['weight'] = weight;
    data['base_experience'] = baseExperience;
    data['is_default'] = isDefault;
    data['location_area_encounters'] = locationAreaEncounters;
    return data;
  }
}

class Abilities {
  Ability? ability;
  bool? isHidden;
  int? slot;

  Abilities({this.ability, this.isHidden, this.slot});

  Abilities.fromJson(Map<String, dynamic> json) {
    ability =
        json['ability'] != null ? Ability.fromJson(json['ability']) : null;
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ability != null) {
      data['ability'] = ability!.toJson();
    }
    data['is_hidden'] = isHidden;
    data['slot'] = slot;
    return data;
  }
}

class Ability {
  String? name;
  String? url;

  Ability({this.name, this.url});

  Ability.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class Sprites {
  String? backDefault;
  String? backFemale;
  String? backShiny;
  String? backShinyFemale;
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;

  Sprites({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  Sprites.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];
    backFemale = json['back_female'];
    backShiny = json['back_shiny'];
    backShinyFemale = json['back_shiny_female'];
    frontDefault = json['front_default'];
    frontFemale = json['front_female'];
    frontShiny = json['front_shiny'];
    frontShinyFemale = json['front_shiny_female'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['back_default'] = backDefault;
    data['back_female'] = backFemale;
    data['back_shiny'] = backShiny;
    data['back_shiny_female'] = backShinyFemale;
    data['front_default'] = frontDefault;
    data['front_female'] = frontFemale;
    data['front_shiny'] = frontShiny;
    data['front_shiny_female'] = frontShinyFemale;
    return data;
  }
}

class Stats {
  int? baseStat;
  int? effort;
  Ability? stat;

  Stats({this.baseStat, this.effort, this.stat});

  Stats.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = json['stat'] != null ? Ability.fromJson(json['stat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base_stat'] = baseStat;
    data['effort'] = effort;
    if (stat != null) {
      data['stat'] = stat!.toJson();
    }
    return data;
  }
}

class Move {
  String? name;
  String? url;

  Move({this.name, this.url});

  Move.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}

class Moves {
  Ability? move;

  Moves({this.move});

  Moves.fromJson(Map<String, dynamic> json) {
    move = json['move'] != null ? Ability.fromJson(json['move']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (move != null) {
      data['move'] = move!.toJson();
    }
    return data;
  }
}

class DetailedMoves {
  int? accuracy;
  String? effect;
  int? power;
  int? pp;
  String? target;
  String? name;
  int? id;

  DetailedMoves({
    this.accuracy,
    this.effect,
    this.name,
    this.id,
    this.power,
    this.pp,
    this.target,
  });

  DetailedMoves.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'];
    effect = json['effect_entries'] != null &&
            json['effect_entries'].isNotEmpty &&
            json['effect_entries'][0]['effect'] != null
        ? json['effect_entries'][0]['effect']
        : null;
    power = json['power'];
    pp = json['pp'];
    target = json['target'] != null ? json['target']['name'] : null;
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'accuracy': accuracy,
      'effect': effect,
      'power': power,
      'pp': pp,
      'target': target,
      'name': name,
      'id': id,
    };
  }
}

class Specie {
  String? name;
  String? url;

  Specie({this.name, this.url});

  Specie.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class DetailedSpecies {
  String? colour;
  List<String>? eggGroups;
  String? description;
  String? generation;
  String? growthRate;
  String? habitat;
  String? shape;

  DetailedSpecies(
      {this.colour,
      this.eggGroups,
      this.description,
      this.generation,
      this.growthRate,
      this.habitat,
      this.shape});

  DetailedSpecies.fromJson(Map<String, dynamic> json) {
    colour = json['color'] != null ? json['color']['name'] : null;
    description = json['flavor_text_entries'] != null &&
            json['flavor_text_entries'].isNotEmpty &&
            json['flavor_text_entries'][0]['flavor_text'] != null
        ? json['flavor_text_entries'][0]['flavor_text']
        : null;
    eggGroups = json['egg_groups'] != null
        ? List<String>.from(json['egg_groups'].map((e) => e['name']))
        : null;
    description = json['flavor_text_entries']?.isNotEmpty ?? false
        ? json['flavor_text_entries'][0]['flavor_text']
        : null;
    generation = json['generation'] != null ? json['generation']['name'] : null;
    growthRate =
        json['growth_rate'] != null ? json['growth_rate']['name'] : null;
    habitat = json['habitat'] != null ? json['habitat']['name'] : null;
    shape = json['shape'] != null ? json['shape']['name'] : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'colour': colour,
      'eggGroup': eggGroups,
      'description': description,
      'generation': generation,
      'growthRate': growthRate,
      'habitat': habitat,
      'shape': shape,
    };
  }
}
