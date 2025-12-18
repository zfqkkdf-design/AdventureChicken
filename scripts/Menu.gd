extends Control

@onready var play_button = $UILayer/PlayButton
@onready var sound_button = $UILayer/SoundButton
@onready var music_button = $UILayer/MusicButton

# Аудиоресурсы
const MUSIC_BG = preload("res://assets/audio/music/bg_music.mp3")

# AudioStreamPlayer для музыки
var music_player: AudioStreamPlayer

func _ready():
	play_button.pressed.connect(_on_play_pressed)
	sound_button.pressed.connect(_on_sound_pressed)
	music_button.pressed.connect(_on_music_pressed)
	
	# Загружаем настройки из GameManager
	_update_settings_from_game_manager()
	
	# Инициализируем аудио систему
	_init_audio()
	
	# Применяем наклон к текстовым подсказкам
	_apply_text_rotation()
	
	# Обновляем визуальное состояние кнопок
	_update_buttons_visual_state()

func _apply_text_rotation():
	# Наклон текста "Collect the eggs" (вверх влево)
	var collect_label = $UILayer/CollectEggsLabel
	if collect_label:
		collect_label.rotation_degrees = -15.0
	
	# Наклон текста "Don't fall for the fox" (вверх вправо)
	var dont_fall_label = $UILayer/DontFallLabel
	if dont_fall_label:
		dont_fall_label.rotation_degrees = 15.0

func _init_audio():
	# Создаем AudioStreamPlayer для музыки
	music_player = AudioStreamPlayer.new()
	music_player.stream = MUSIC_BG
	music_player.volume_db = -5.0  # Немного тише фоновой музыки
	add_child(music_player)
	
	# Запускаем музыку если она включена
	if GameManager.music_enabled:
		music_player.play()

func _update_settings_from_game_manager():
	# Настройки уже загружены в GameManager при старте
	# Здесь просто используем их значения
	pass

func _update_buttons_visual_state():
	# Обновляем визуальное состояние кнопки звука
	if sound_button:
		if GameManager.sound_enabled:
			sound_button.text = "🔊"
		else:
			sound_button.text = "🔇"
	
	# Обновляем визуальное состояние кнопки музыки
	if music_button:
		if GameManager.music_enabled:
			music_button.modulate = Color(1, 1, 1, 1)  # Полная видимость
		else:
			music_button.modulate = Color(0.5, 0.5, 0.5, 1)  # Затемнённая

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/Game.tscn")

func _on_sound_pressed():
	GameManager.set_sound_enabled(not GameManager.sound_enabled)
	_update_buttons_visual_state()
	print("Sound: ", "ON" if GameManager.sound_enabled else "OFF")

func _on_music_pressed():
	GameManager.set_music_enabled(not GameManager.music_enabled)
	
	# Управляем музыкой
	if music_player:
		if GameManager.music_enabled:
			music_player.play()
		else:
			music_player.stop()
	
	_update_buttons_visual_state()
	print("Music: ", "ON" if GameManager.music_enabled else "OFF")
