extends Node

export (PackedScene) var Mob
var score

func _ready():
	randomize()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Hud.show_message("Get Ready")
	$Hud.update_score()

func game_over():
	$ScoreTimer.stop()
	$MobTime.stop()
	$Hud.game_over()

func _on_ScoreTimer_timeout():
	score += 1

func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0)).rotated(direction)
	$$Hud.connect("start_game", mob, "_on_start_game")