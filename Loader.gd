extends "res://Scripts/Loader.gd"


var added_shelters: Dictionary
var added_maps: Dictionary


func LoadScene(scene : String): 
    if scene in added_shelters.keys():
        scenePath = added_shelters[scene].scene_path
        scene = added_shelters[scene].transition_text
        
        gameData.menu = false
        gameData.shelter = true
        gameData.permadeath = false
        gameData.tutorial = false
    
    elif scene in added_maps.keys():
        scenePath = added_maps[scene].scene_path
        scene = added_maps[scene].transition_text
        
        gameData.menu = false
        gameData.shelter = false
        gameData.permadeath = false
        gameData.tutorial = false
    
    super(scene)


func add_shelter(shelter: Dictionary) -> bool:
    if _validate(shelter):
        added_shelters[shelter.map_name] = shelter
        _log("Shelter added: " + shelter.map_name)
        return true
    else:
        _log("Failed to add " + shelter.map_name)
        return false


func add_map(map: Dictionary) -> bool:
    if _validate(map):
        added_maps[map.map_name] = map
        _log("Map added: " +  map.map_name)
        return true
    else:
        _log("Failed to add map " + map.mapName)
        return false


func _validate(data: Dictionary) -> bool:
    _log("Validating " + data.map_name)
    var data_valid = true
    if not data.map_name or data.map_name == "":
        _log("Map name not set")
        data_valid = false
    if data.map_name in added_shelters or data.map_name in added_maps:
        _log("Map with name " + data.map_name + " already added")
        data_valid = false
    if not FileAccess.file_exists(data.scene_path):
        _log("Failed to locate " + data.scene_path)
        data_valid = false
    if not data.entrance_spawn or data.entrance_spawn == "":
        _log("No entrance spawm set")
        data_valid = false
    if not data.exit_spawn or data.exit_spawn == "":
        _log("No exit spawm set")
        data_valid = false
    if not data.connected_to or data.connected_to == "":
        _log("No map connection set")
        data_valid = false
    for item in data.connected_content:
        if not FileAccess.file_exists(item.path):
            _log("Failed to locate " + data.scene_path)
            data_valid = false
        if not item.position is Vector3:
            _log("Invalid position for " + item.path)
            data_valid = false
        if not item.rotation is Vector3:
            _log("Invalid rotation for " + item.path)
            data_valid = false
    return data_valid
 

func _log(message: String) -> void:
    print("[B_Loader] " + message)
