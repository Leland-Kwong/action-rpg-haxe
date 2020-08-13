typedef LootDefType = String;

typedef LootDefCat = String;

typedef LootDef = {
  name: String,
  type: LootDefType,
  energyCost: Float,
  cooldown: Float,
  actionSpeed: Float,
  category: LootDefCat,
  minDamage: Int,
  maxDamage: Int,
  spriteKey: String,
};

// loot that was generated via rng
typedef LootInstance = {
  id: String,
  type: LootDefType
};

class Loot {
  public static final lootDefinitions: Array<LootDef> = [
    {
      name: 'Basic Blaster',
      type: 'basicBlaster',
      category: 'ability',
      energyCost: 2,
      cooldown: 0,
      actionSpeed: 1/10,
      minDamage: 1,
      maxDamage: 1,
      spriteKey: 'ui/loot__ability_basic_blaster',
    },
    {
      name: 'Spider Bots',
      type: 'spiderBots',
      category: 'ability',
      energyCost: 2,
      cooldown: 0,
      actionSpeed: 2 / 10,
      minDamage: 1,
      maxDamage: 1,
      spriteKey: 'ui/loot__ability_spider_bots'
    },
    // TODO: Make beam have both an initial energy cost at
    // initial use and then a lower channeling cost. This
    // way you can still burst with the ability while
    // still gaining the benefits of a channeling when
    // desired.
    {
      name: 'Laser Beam',
      type: 'channelBeam',
      category: 'ability',
      cooldown: 0,
      actionSpeed: 1/200,
      energyCost: .25,
      minDamage: 1,
      maxDamage: 3,
      spriteKey: 'ui/loot__ability_channel_beam'
    },
    {
      name: 'Energy Bomb',
      type: 'energyBomb',
      category: 'ability',
      cooldown: 0.3,
      actionSpeed: 0.15,
      energyCost: 4,
      minDamage: 3,
      maxDamage: 5,
      spriteKey: 'ui/loot__ability_energy_bomb'
    },
    {
      name: 'Burst Charge',
      type: 'burstCharge',
      category: 'ability',
      cooldown: 0.3,
      actionSpeed: 0.15,
      energyCost: 3,
      minDamage: 3,
      maxDamage: 5,
      spriteKey: 'ui/loot__ability_burst_charge'
    },
    // TODO: Add support for charges
    // where the ability builds charges as you
    // kill enemies.
    {
      name: 'Basic Heal',
      type: 'heal1',
      category: 'ability',
      cooldown: 0.3,
      actionSpeed: 0,
      energyCost: 0,
      minDamage: 0,
      maxDamage: 0,
      spriteKey: 'ui/loot__ability_heal_1'
    },
    {
      name: 'Basic Energy Restore',
      type: 'energy1',
      category: 'ability',
      cooldown: 0.3,
      actionSpeed: 0,
      energyCost: 0,
      minDamage: 0,
      maxDamage: 0,
      spriteKey: 'ui/loot__ability_energy_1'
    },
    {
      name: 'Green Arrow Socketable',
      type: 'greenArrowSocketable',
      category: 'socketable',
      cooldown: 0,
      actionSpeed: 0,
      energyCost: 0,
      minDamage: 0,
      maxDamage: 0,
      spriteKey: 'ui/loot__socketable_green_arrow_up'
    },
    {
      name: 'Null Item',
      type: 'nullItem',
      category: 'nullCategory',
      cooldown: 0,
      actionSpeed: 0,
      energyCost: 0,
      minDamage: 0,
      maxDamage: 0,
      spriteKey: 'ui/placeholder'
    },
  ];

  static final defs: Map<LootDefType, LootDef> = [
    for (def in lootDefinitions) def.type => def
  ];

  public static function getDef(type): LootDef {
    return defs.get(type);
  }

  public static function createInstance(
      typesToRoll: Array<LootDefType>,
      ?explicitId: String): LootInstance {

    final rolledType = Utils.rollValues(typesToRoll);
    final id = explicitId != null ? 
      explicitId : Utils.uid();

    return {
      id: id,
      type: rolledType
    };
  }
}
