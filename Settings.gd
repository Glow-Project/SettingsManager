tool
extends Node
class_name Settings

var config: Dictionary = {}
var default_config: Dictionary = {}
var file_path = "user://settings.dat"

# Wether the config should be automatically saved
# when `Settings.sets()` is called
export var auto_save: bool = false

# Wether the config should be automatically loaded
# when `Settings.gets()` is called
export var auto_load: bool = false

# Get a certain setting
#
# Example:
#     ```
#     Settings.gets("Test")
#     ```
#
func gets(setting: String):
	if auto_load:
		read()

	if config.has(setting):
		return config[setting]
	else:
		return null


# Set a certain setting
#
# Example:
#   ```
#   Settings.sets("Test", 4)
#   ```
#
func sets(setting: String, new_val) -> void:
	config[setting] = new_val

	if auto_save:
		write()

# Set a default value for setting
func set_default(setting: String, new_val) -> void:
	default_config[setting] = new_val

# Set the default config if there is no value
func adapt_default() -> void:
	for key in default_config.keys():
		if !config.has(key):
			config[key] = default_config[key]

# Write the current config to a file
func write():
	var file = File.new()

	var error = file.open(file_path, file.WRITE)
	
	if error == OK:
		file.store_var(config)
		file.close()


# Read the current config from a file
func read():
	var file = File.new()

	var error = file.open(file_path, file.READ)
	
	if error == OK:
		config = file.get_var()
		file.close()

	# Adapt the default config
	adapt_default()
