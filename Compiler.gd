extends "res://Scripts/Compiler.gd"


#var B_Loader: Node


#func _ready() -> void:
    #B_Loader = get_tree().root.get_node_or_null("B_Loader")
    #super()


func Spawn():
    var map = get_tree().current_scene.get_node("/root/Map")
    
    if map.mapName not in Loader.added_shelters.keys() and map.mapName not in Loader.added_maps.keys() and \
        _isnt_connected_to_added_shelter_or_map(map.mapName):
        super()
        return
        
    B_Loader.log_message("loading " + map.mapName)
    var spawnTarget: String
    
    if map.mapName in Loader.added_shelters.keys():
        Loader.LoadWorld()
        Loader.LoadCharacter()
        Loader.LoadShelter(map.mapName)
        Simulation.simulate = true
        spawnTarget = Loader.added_shelters[map.mapName].exit_spawn
        
    elif map.mapName in Loader.added_maps.keys():
        Loader.LoadWorld()
        Loader.LoadCharacter()
        Simulation.simulate = true
        spawnTarget = Loader.added_shelters[map.mapName].exit_spawn
        
    else:
        Loader.LoadWorld()
        var map_content = get_tree().current_scene.get_node("/root/Map/Content")
        
        for item_data in _get_connected_content(map.mapName):
            var packed_item = load(item_data.path)
            if not packed_item:
                B_Loader.log_error("falied to load: " + item_data.path)
                continue
            var item = packed_item.instantiate()
            item.position = item_data.position
            item.rotation_degrees = item_data.rotation
            map_content.add_child(item)
        
        Loader.LoadCharacter()
        Simulation.simulate = true
        spawnTarget = _get_spawn_target(map.mapName, gameData.previousMap)
        
    var transitions = get_tree().get_nodes_in_group("Transition") 
    if spawnTarget != "":
        for transition in transitions:
            if transition.owner.name == spawnTarget:

                var spawnPoint: Node3D = transition.owner.spawn
                
                if spawnPoint:
                    controller.global_transform.basis = spawnPoint.global_transform.basis
                    controller.global_transform.basis = controller.global_transform.basis.rotated(Vector3.UP, deg_to_rad(180))
                    controller.global_position = spawnPoint.global_position


    gameData.isTransitioning = false
    gameData.isSleeping = false
    gameData.isOccupied = false
    gameData.freeze = false


func _isnt_connected_to_added_shelter_or_map(mapName: String) -> bool:
    for shelter in Loader.added_shelters:
        if Loader.added_shelters[shelter].connected_to == mapName:
            return false
    for map in Loader.added_maps:
        if Loader.added_maps[map].connected_to == mapName:
            return false
    return true


func _get_connected_content(mapName) -> Array:
    var connected_map
    for shelter in Loader.added_shelters:
        if Loader.added_shelters[shelter].connected_to == mapName:
            connected_map = Loader.added_shelters[shelter]
            break
    for map in Loader.added_maps:
        if Loader.added_maps[map].connected_to == mapName:
            connected_map = Loader.added_maps[map]
    if connected_map:
        return connected_map.connected_content
    else:
        return []


func _get_spawn_target(map, previousMap) -> String:
    #if prev is added shelter or map get the spawn
    if previousMap in Loader.added_shelters.keys():
        return Loader.added_shelters[previousMap].entrance_spawn
    if previousMap in Loader.added_maps.keys():
        return Loader.added_maps[previousMap].entrance_spawn
    #else find the correct spawn
    return map_spawns[map][previousMap]


const map_spawns = {
  "Village":
        {
            "Cabin": "Door_Cabin_Enter",
            "Attic": "Door_Attic_Enter",
            "School": "Transition_School",
            "Highway": "Transition_Highway",
        },
    "School":
        {
            "Village": "Transition_Village",
            "Highway": "Transition_Highway",
            "Outpost": "Transition_Outpost",
            "Classroom": "Door_Classroom_Enter",
        },
    "Highway":
        {
            "Village": "Transition_Village",
            "School": "Transition_School",
        },
    "Outpost":
        {
            "School": "Transition_School",
            "Minefield": "Transition_Minefield",
            "Tent": "Transition_Tent_Enter",
            "Bunker": "Door_Bunker_Enter",
        },
    "Minefield":
        {
            "Outpost": "Transition_Outpost",
            "Apartments": "Transition_Apartments",
        },
    "Apartments":
        {
            "Minefield": "Transition_Minefield",
            "Terminal": "Transition_Terminal",
        },
    "Terminal":
        {
            "Apartments": "Transition_Apartments"
        }
}
    
    
