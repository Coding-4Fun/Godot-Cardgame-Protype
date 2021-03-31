extends Control

func _ready() -> void:
	$VBoxContainer/CenterContainer/GridContainer/NameTextbox.text = Saved.config_data["Player_name"]


func _on_HostButton_pressed() -> void:
	Network.create_server()


func _on_JoinButton_pressed() -> void:
	Network.connect_to_server()


func _on_NameTextbox_text_entered(new_text: String) -> void:
	pass # Replace with function body.


func _on_IPTextbox_text_entered(new_text: String) -> void:
	pass # Replace with function body.


func _on_PortTextbox_text_entered(new_text: String) -> void:
	pass # Replace with function body.

