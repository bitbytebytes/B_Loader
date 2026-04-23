## B Loader

A mod for [Road to Vostok](https://roadtovostok.com/)

Works with the latest versions of the [VostokMods Mod Loader](https://modworkshop.net/mod/49779) and the [Metro Mod Loader](https://modworkshop.net/mod/55623)

Allows for easily adding shelters and maps to the base game via a single function call with a simple signature:

```
func _ready():
    Loader.add_shelter({
        "map_name": "Apartment",
        "scene_path": "res://mods/ApartmentShelter/Scenes/Apartment.tscn",
        "transition_text": "Apartment",
        "exit_spawn": "Door_Apartment_Exit",
        "entrance_spawn": "Door_Apartment_Enter",
        "connected_to": "Apartments",
        "connected_content":  [
            {
                "path": "res://mods/ApartmentShelter/Items/Keys/Key_Apartment.tscn",
                "position": Vector3(-117.996, 0.002, -28.895),
                "rotation": Vector3(90, -31, 5)
            },
            {
                "path": "res://Assets/Corpse/Corpse_Bandit_Wall_B.tscn",
                "position": Vector3(-117.658, 0.009, -28.467),
                "rotation": Vector3(0, 180, 0)
            },
            {
                "path": "res://mods/ApartmentShelter/Modular/Doors/Transitions/Door_Apartment_Enter.tscn",
                "position": Vector3(-142.5, 13, -73.995),
                "rotation": Vector3(0, 0, 0)
            },
        ]
    })
```
