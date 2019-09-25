extends Node

export (PackedScene) var Mob
var score

func _ready():
	randomize()

func new_game():
	score = 0
	$Hud.update_score(score)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Hud.show_message("Get Ready")
	$Music.play()

func game_over():
	$GameOver.play()
	$ScoreTimer.stop()
	$MobTime.stop()
	$Hud.game_over()

func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0)).rotated(direction)
	$Hud.connect("start_game", mob, "_on_start_game")

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)