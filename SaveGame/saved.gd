extends Node

var config_data = {}
const GAMECONFIGFILE = "user://config.json"
const CONFIGDATA_DEFAULT = {
	"Player_name": "Unnamed",
	"Network": {
		"HostIPAdress": "127.0.0.1",
		"HostGamePort": "32023",
		},
	"Audio": {
		"MasterVolume": 100,
		"SfxVolume": 100,
		"MusicVolume": 100
		}
	}

func _ready() -> void:
	config_data = get_data()

func get_data() -> JSONParseResult:
	var file = File.new()
	if not file.file_exists(GAMECONFIGFILE):
		config_data = CONFIGDATA_DEFAULT
		save_game()
	file.open(GAMECONFIGFILE, File.READ)
	var content = file.get_as_text()
	var data = parse_json(content)
	config_data = data
	file.close()
	return(data)


func save_game():
	var config = File.new()
	config.open(GAMECONFIGFILE, File.WRITE)
	config.store_line(to_json(config_data))
	config.close()
