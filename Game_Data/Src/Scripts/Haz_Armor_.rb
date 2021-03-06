class Game_Party
  attr_reader   :armors
  attr_reader   :weapons
end
=begin
0: shield
1: helmet
2: body armor
3: accessory
=end
def player_has_armor?(kind=2) #defaults to check for body armor
=begin
  case kind
  when 0
    return true unless $game_party.actors[0].armor1_id == 0
    return false if $data_actors[$game_party.actors[0].id].armor1_fix == true
  when 1
    return true unless $game_party.actors[0].armor2_id == 0
    return false if $data_actors[$game_party.actors[0].id].armor2_fix == true
  when 2
    return true unless $game_party.actors[0].armor3_id == 0
    return false if $data_actors[$game_party.actors[0].id].armor3_fix == true
  when 3
    return true unless $game_party.actors[0].armor4_id == 0
    return false if $data_actors[$game_party.actors[0].id].armor4_fix == true
  end
=end
  party_actor_id = 0
  kind_id = kind.to_i + 1
  armor_id_attr_name = sprintf('armor%d_id', kind_id)
  armor_fix_attr_name = sprintf('armor%d_fix', kind_id)
  return true unless $game_party.actors[party_actor_id].send(armor_id_attr_name) == 0
  return false if $game_party.actors[party_actor_id].equip_fix?(kind_id) == true
  
  for armor_hash in $game_party.armors
    armor = $data_armors[armor_hash[0]]
    amount = armor_hash[1]
    if amount != 0 and armor.kind == kind and $game_party.actors[party_actor_id].equippable?(armor)
      return true #armor in inventory
    end
  end
  return false #armor not equipped or in inventory
end