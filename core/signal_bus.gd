extends Node
#class_name SignalBus

# SignalBus is a global event dispatcher used to decouple systems.
# Nodes emit and listen for signals here instead of talking to each other directly.
# Intended to be an autoload singleton (Project → Project Settings → Globals).

signal game_paused
signal game_resumed
signal player_died
