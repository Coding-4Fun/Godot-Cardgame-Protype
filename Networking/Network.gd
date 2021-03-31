#class_name Template_Script

#const Template = preload("res://Script_Templates/Template_Script.gd")

#Nutze die Vergangenheitsform um Signale zu benennen:
#
#signal door_opened
#signal score_changed

#Verwende CONSTANT_CASE, alles in Großbuchstaben, mit einem Unterstrich zur Worttrennung:
#const CONSTAND_VAR = 200:

#Verwenden Sie PascalCase für Aufzählungsnamen und CONSTANT _CASE für deren Mitglieder, da es sich um Konstanten handelt:

# enum Element {
#    EARTH,
#    WATER,
#    AIR,
#    FIRE,
#}

#-------------------------------------------------------------------------------

#01. tool
#02. class_name
#03. extends
#04. # docstring
#
#05. signals
#06. enums
#07. constants
#08. exported variables
#09. public variables
#10. private variables
#11. onready variables
#
#12. optional built-in virtual _init method
#13. built-in virtual _ready method
#14. remaining built-in virtual methods
#15. public methods
#16. private methods

#-------------------------------------------------------------------------------
# Header
#-------------------------------------------------------------------------------
#tool
#class_name
extends Node
# Eine Vorlage für neue Scripte
#-------------------------------------------------------------------------------
# Signals
#signal player_disconnected
#signal server_disconnected
#-------------------------------------------------------------------------------
# enums
#-------------------------------------------------------------------------------
# constants
const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 32023
const MAX_PLAYERS = 2
#-------------------------------------------------------------------------------
# exported variables
#-------------------------------------------------------------------------------
# private variables
var local_player_id : int = 0 setget set_local_player_id
#-------------------------------------------------------------------------------
# onready variables
#onready var myVar: string

#-------------------------------------------------------------------------------
# optional built-in virtual _init method
#-------------------------------------------------------------------------------
# built-in virtual _ready method
func _ready() -> void:
	var err = {}
	err["playerdisconnected"] = get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected") > 0
	err["playerconnected"] = get_tree().connect("network_peer_connected", self, "_on_player_connected") > 0

	if not err.values().empty():
		for e in err.values():
			print(str(e))
#-------------------------------------------------------------------------------
# remaining built-in virtual methods
#-------------------------------------------------------------------------------
# public methods
func create_server() -> void:
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEFAULT_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	set_local_player_id(get_tree().get_network_unique_id())
	print("Server wurde erstellt")
	print("I am " + str(local_player_id))


func connect_to_server() -> void:
	var peer = NetworkedMultiplayerENet.new()
	var err = {}
	err["playerdisconnected"] = get_tree().connect("connected_to_server", self, "_connected_to_server") > 0
	if not err.values().empty():
		for e in err.values():
			print(str(e))
	peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(peer)
	set_local_player_id(get_tree().get_network_unique_id())
#-------------------------------------------------------------------------------
# private methods
func _connected_to_server() -> void:
	rpc("_send_player_info", local_player_id)


func _on_player_connected(id:int) -> void:
	if not get_tree().is_network_server ():
		print(str(id) + " hat sich verbunden")
#-------------------------------------------------------------------------------
# remote RPC methods
remote func _send_player_info(id: int) -> void:
	if get_tree().is_network_server ():
		print(str(id) + " ID ist jetzt verbunden")
#-------------------------------------------------------------------------------
# Getter und Setter
func set_local_player_id(id: int) -> void :
	local_player_id = id
