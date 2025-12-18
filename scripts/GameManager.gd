extends Node

const SAVE_FILE_PATH = "user://savegame.save"
const HIGH_SCORE_KEY = "high_score"
const SOUND_ENABLED_KEY = "sound_enabled"
const MUSIC_ENABLED_KEY = "music_enabled"

var high_score: int = 0
var sound_enabled: bool = true
var music_enabled: bool = true

func _ready():
	load_settings()

func get_high_score() -> int:
	return high_score

func update_high_score(new_score: int):
	if new_score > high_score:
		high_score = new_score
		save_settings()

func set_sound_enabled(enabled: bool):
	sound_enabled = enabled
	save_settings()

func set_music_enabled(enabled: bool):
	music_enabled = enabled
	save_settings()

func save_settings():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		var data = {
			HIGH_SCORE_KEY: high_score,
			SOUND_ENABLED_KEY: sound_enabled,
			MUSIC_ENABLED_KEY: music_enabled
		}
		file.store_var(data)
		file.close()

func load_settings():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		if file:
			var data = file.get_var()
			if data:
				if data.has(HIGH_SCORE_KEY):
					high_score = data[HIGH_SCORE_KEY]
				if data.has(SOUND_ENABLED_KEY):
					sound_enabled = data[SOUND_ENABLED_KEY]
				if data.has(MUSIC_ENABLED_KEY):
					music_enabled = data[MUSIC_ENABLED_KEY]
			file.close()
