extends Node

@export var mob_scene: PackedScene

func _on_mob_timer_timeout():
	# Create instance of mob scene
	var mob = mob_scene.instantiate()
	
	# Choose random location on the spawn path
	# Store reference to spawn location node
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	# Give it a random offset
	mob_spawn_location.progress_ratio = randf()
	
	var player_position = $Player.position
	mob.initialize(mob_spawn_location.position, player_position)
	
	# Spawn mob by adding it to the Main scene
	add_child(mob)
