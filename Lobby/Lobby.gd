extends Control

onready var UI_NameBox:LineEdit = $VBoxContainer/CenterContainer/GridContainer/NameTextbox
onready var UI_HostIPBox:LineEdit = $VBoxContainer/CenterContainer/GridContainer/IPTextbox
onready var UI_HostPortBox:LineEdit = $VBoxContainer/CenterContainer/GridContainer/PortTextbox
onready var UI_MayPlayerBox:LineEdit = $VBoxContainer/CenterContainer/GridContainer/MaxPlayersTextbox

signal playername_changed
#(newname)
signal hostip_changed
#(newip)
signal hostport_changed
#(newport)
signal maxplayers_changed
#(newplayer)


func _ready() -> void:
	UI_NameBox.text = Config.config_data["Player_name"]
	UI_HostIPBox.text = Config.config_data["Network"]["HostIPAdress"]
	UI_HostPortBox.text = str(Config.config_data["Network"]["HostGamePort"])
	UI_MayPlayerBox.text = str(Config.config_data["Network"]["MaxPlayers"])


func _on_HostButton_pressed() -> void:
	Network.create_server()


func _on_JoinButton_pressed() -> void:
	Network.connect_to_server()


func _on_NameTextbox_text_entered(new_text: String) -> void:
	emit_signal("playername_changed", new_text)


func _on_IPTextbox_text_entered(new_text: String) -> void:
	emit_signal("hostip_changed", new_text)


func _on_PortTextbox_text_entered(new_text: String) -> void:
	emit_signal("hostport_changed", int(new_text))


func _on_MaxPlayersTextbox_text_entered(new_text: String) -> void:
	emit_signal("maxplayers_changed", int(new_text))
