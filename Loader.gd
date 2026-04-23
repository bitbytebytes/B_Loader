extends "res://Scripts/Loader.gd"


var added_shelters: Dictionary
var added_maps: Dictionary

#var B_Loader: Node


#func _ready() -> void:
    #B_Loader = get_tree().root.get_node_or_null("B_Loader")
    #super()


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
    B_Loader.log_message("shelter added: " + shelter.map_name)
    return true


func add_map(map: Dictionary) -> bool:
    added_maps[map.map_name] = map
    B_Loader.log_message("map added: " +  map.map_name)
    return true
