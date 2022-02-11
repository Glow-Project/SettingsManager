# Godot-Settings

Set, get, save and load Settings in Godot

## Installation

You can install this plugin using the [ppm cli](https://github.com/Glow-Project/ppm)

```bash
$ ppm install SettingsManager
```

## Getting started

Firstly create a new script (here called `InitSettings.gd`) that extends the Settings class:
`InitSettings.gd`

```gdscript
extends Settings
```

Then create a Global instance (here called `settings`)

Now you can configure your Settings instance
`InitSettings.gd`

```gdscript
extends Settings

# Runs at launch, because it is a global script
func _enter_tree():
    # Automatically save the settings to a settings file
    # when a setting is changed
    auto_save = true

    # Automatically load settings from file on startup
    auto_load = true

    # Set a default value for the fullscreen setting
    set_default("fullscreen", false)
```

**Every** kind of serializable data can be a value.

From outside the `InitSettings.gd` script, you can use the settings instance like that:

```gdscript
# Get the fullscreen setting, which is going
# to return the default value
settings.gets("fullscreen") # => false

# Set the fullscreen setting to true
settings.sets("fullscreen", true)

settings.gets("fullscreen") # => true
```

## More advanced usage

You can override a method, like `sets` to run a certain function whenever some setting is getting set

`InitSettings.gd`

```gdscript
extends Settings

func _enter_tree():
    set_default("fullscreen", false)

func sets(setting: String, value):
    .sets(setting, value)
    adadpt_settings()

func adapt_settings():
    OS.window_fullscreen = gets("fullscreen")
```
