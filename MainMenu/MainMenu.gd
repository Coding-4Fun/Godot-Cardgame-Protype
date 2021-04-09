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
extends Control
# Eine Vorlage für neue Scripte
#-------------------------------------------------------------------------------
# Signals
#signal SelectionChanged
#-------------------------------------------------------------------------------
# enums
#-------------------------------------------------------------------------------
# constants
#-------------------------------------------------------------------------------
# exported variables
#-------------------------------------------------------------------------------
# public variables
export var TrueFalse = true setget set_truefalse
#-------------------------------------------------------------------------------
# private variables
#-------------------------------------------------------------------------------
# onready variables
#onready var myVar: string
onready var languages = []
onready var UI_LangBoxSelect = $CenterContainer/GridContainer/OptButtonLangSelect
onready var TRServer = TranslationServer

#-------------------------------------------------------------------------------
# optional built-in virtual _init method
#-------------------------------------------------------------------------------
# built-in virtual _ready method
#-------------------------------------------------------------------------------
# remaining built-in virtual methods
func _ready() -> void:
	languages = TranslationServer.get_loaded_locales ( )
	for lang in languages:
		UI_LangBoxSelect.add_item(TranslationServer.get_locale_name(lang))
		TRServer.set_locale("de")
		var currlang = TranslationServer.get_locale()
		if languages.has(currlang):
			UI_LangBoxSelect.selected = languages.find(currlang)


#		UI_LangBoxSelect.connect("item_selected", self, "_on_SelectionChanged")
	pass


func _process(_delta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	pass


func _unhandled_input(_event: InputEvent) -> void:
	pass


func _init() -> void:
	pass


func _input(_event: InputEvent) -> void:
	pass


#-------------------------------------------------------------------------------
# public methods
func set_truefalse(_newvalue: bool) -> void:
	pass

func _on_SelectionChanged(_idx: int):
	pass
#-------------------------------------------------------------------------------
# private methods
#-------------------------------------------------------------------------------



func _on_OptButtonLangSelect_item_selected(idx: int) -> void:
	if idx > -1:
#		var local  = TranslationServer.get_locale(languages[idx])
		TranslationServer.set_locale(languages[idx])
