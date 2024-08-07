extends Node2D
@export var enemy_scene: PackedScene
var score 

func _ready():
	new_game()


func _on_score_timer_timeout():
	score += 1 #score = score + 1

func _on_player_hit():
	game_over()
	
func game_over():
	$enemyTimer.stop()
	$scoreTimer.stop()
	
func new_game():
	score = 0
	
	$player.start($startPosition.position)
	$startTimer.start()

func _on_enemy_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var enemy_spawn_location = $enemyPath/enemyPathFollow2D
	enemy_spawn_location.progress_ratio = randf()
	
	var direction = enemy_spawn_location.rotation + PI / 2
	enemy.position = enemy_spawn_location.position
	
	direction += randf_range(-PI/4,PI/4)
	enemy.rotation = direction

	var velocity = Vector2(randf_range(100, 250), 0)#se le asigna velocidad al enemigo
	enemy.linear_velocity = velocity.rotated(direction)
	
	add_child(enemy)
func _on_start_timer_timeout():
	$enemyTimer.start()
	$scoreTimer.start()
	
	
	



