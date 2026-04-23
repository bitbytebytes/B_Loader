extends Node


func _ready():
    _init_loader()
    log_message("Setup completed")


func _init_loader() -> void:
    var Loader = get_tree().root.get_node_or_null("Loader")
    if not Loader:
        log_error("Loader not found. Setup failed!")
        return
    if Loader.has_method("add_shelter"):
        log_message("Already setup")
        return
    _override_loader()
    _override_compiler()


func _override_compiler():
    var script: Script = load("res://mods/B_Loader/Compiler.gd")
    script.take_over_path(script.get_base_script().resource_path)


func _override_loader() -> void:
    var loader: CanvasLayer = get_tree().root.get_node_or_null("Loader")
    
    var override: Script = load("res://mods/B_Loader/Loader.gd")
    
    loader.set_script(override)
    loader.screen = get_tree().root.get_node_or_null("Loader/Screen")
    loader.overlay = get_tree().root.get_node_or_null("Loader/Overlay")
    loader.animation = get_tree().root.get_node_or_null("Loader/Animation")
    loader.label = get_tree().root.get_node_or_null("Loader/Screen/Label")
    loader.circle = get_tree().root.get_node_or_null("Loader/Screen/Circle")
    loader.messages = get_tree().root.get_node_or_null("Loader/Messages")


func log_message(message: String) -> void:
    print("[B_Loader] " + message)


func log_error(message: String) -> void:
    print("[B_Loader][ERROR] " + message)
    
    
