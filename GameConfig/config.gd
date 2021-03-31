extends Node

var config_data = {}
const GAMECONFIGFILE = "res://config.json"
const CONFIGDATA_DEFAULT = {
	"Player_name": "Unnamed",
	"Network": {
		"HostIPAdress": "127.0.0.1",
		"HostGamePort": "32023",
		"MaxPlayers": 2
		},
	"Audio": {
		"MasterVolume": 100,
		"SfxVolume": 100,
		"MusicVolume": 100
		}
	}

#signal playername_changed (string)
#signal hostip_changed(string)
#signal hostport_changed(string)
#signal maxplayers_changed(string)

onready var lobby = get_node("/root/Lobby")

func _ready() -> void:
	config_data = get_configdata()

	lobby.connect("playername_changed", self, "_on_playername_change")
	lobby.connect("hostip_changed", self, "_on_hostip_change")
	lobby.connect("hostport_changed", self, "_on_hostport_change")
	lobby.connect("maxplayers_changed", self, "_on_maxplayer_change")


func get_configdata() -> JSONParseResult:
	var file = File.new()
	if not file.file_exists(GAMECONFIGFILE):
		config_data = CONFIGDATA_DEFAULT
		save_gameconfig()
	file.open(GAMECONFIGFILE, File.READ)
	var content = file.get_as_text()
	var data = parse_json(content)
	config_data = data
	file.close()
	return(data)


func save_gameconfig ():
	var config = File.new()
	config.open(GAMECONFIGFILE, File.WRITE)
	config.store_line(to_json(config_data))
	config.close()


func _on_playername_change(newname:String) -> void:
	if not newname.empty():
		Config.config_data["Player_name"] = newname
		Config.save_gameconfig()
	else:
		print("Bitte name eingeben")


func _on_hostip_change(newhostip:String) -> void:
	if not newhostip.empty():
		Config.config_data["Network"]["HostIPAdress"] = newhostip
		Config.save_gameconfig()
	else:
		print("Bitte IP Adresse eingeben")


func _on_hostport_change(newhostport: int) -> void:
	if newhostport > 0:
		Config.config_data["Network"]["HostGamePort"] = newhostport
		Config.save_gameconfig()
	else:
		print("Bitte Port eingeben")


func _on_maxplayer_change(newmaxplayers:int) -> void:
	if newmaxplayers > 0:
		Config.config_data["Network"]["MaxPlayers"] = newmaxplayers
		Config.save_gameconfig()
	else:
		print("Bitte Maximale anzahl Spieler eingeben")
