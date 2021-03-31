extends Control

onready var UI_NameBox:LineEdit = $VBoxContainer/CenterContainer/GridContainer/NameTextbox
onready var UI_HostIPBox:LineEdit = $VBoxContainer/CenterContainer/GridContainer/IPTextBox
onready var UI_HostPortBox:LineEdit = $VBoxContainer/CenterContainer/GridContainer/PortTextbox
onready var UI_MayPlayerBox:LineEdit = $VBoxContainer/CenterContainer/GridContainer/MaxPlayersTextbox


signal playername_changed (string)
signal hostip_changed(string)
signal hostport_changed(string)
signal maxplayers_changed(string)


func _ready() -> void:
	UI_NameBox.text = Config.config_data["Player_name"]


func _on_HostButton_pressed() -> void:
	Network.create_server()


func _on_JoinButton_pressed() -> void:
	Network.connect_to_server()


func _on_NameTextbox_text_entered(new_text: String) -> void:
	emit_signal("playername_changed", new_text)


func _on_IPTextbox_text_entered(new_text: String) -> void:
	emit_signal("hostip_changed", new_text)


func _on_PortTextbox_text_entered(new_text: String) -> void:
	emit_signal("hostport_changed", new_text)



func _on_MaxPlayersTextbox_text_entered(new_int: int) -> void:
	emit_signal("maxplayers_changed", new_int)
