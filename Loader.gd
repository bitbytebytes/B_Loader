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
    added_shelters[shelter.map_name] = shelter
    print("[B_Loader] shelter added: " + shelter.map_name)
    return true


func add_map(map: Dictionary) -> bool:
    added_maps[map.map_name] = map
    print("[B_Loader] map added: " +  map.map_name)
    return true
