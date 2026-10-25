#extends CharacterBody2D
#
#@export var target_node: Node2D 
#
#var speed: float = 120.0        
#var stop_distance: float = 60.0 
#
#func _physics_process(delta):
	#if target_node != null:
		#var jarak = global_position.distance_to(target_node.global_position)
		#if jarak > stop_distance:
			#var arah = global_position.direction_to(target_node.global_position)
			#velocity = arah * speed
			#if abs(arah.x) > abs(arah.y): 
				#if arah.x > 0:
					#$AnimatedSprite2D.play("move_right")
				#else:
					#$AnimatedSprite2D.play("move_left")
			#else:
				#if arah.y > 0:
					#$AnimatedSprite2D.play("move_down") 
				#else:
					#$AnimatedSprite2D.play("move_up")
		#else:
			#velocity = velocity.move_toward(Vector2.ZERO, speed * delta * 5)
		#move_and_slide()
extends CharacterBody2D

@export var target_node: Node2D

var speed: float = 120.0
var stop_distance: float = 60.0
var ride_speed: float = 60.0
var is_ridden: bool = false

func _ready():
	# Cadangan kalau lupa isi di Inspector (player harus masuk group "player")
	if target_node == null:
		target_node = get_tree().get_first_node_in_group("player")
	print("target hantu: ", target_node)  # cek di Output, jangan sampai <null>

func _physics_process(delta):
	if is_ridden:
		velocity = Vector2(0, -ride_speed)
		$AnimatedSprite2D.play("move_up")
	elif target_node != null and global_position.distance_to(target_node.global_position) > stop_distance:
		var arah = global_position.direction_to(target_node.global_position)
		velocity = arah * speed

		if abs(arah.x) > abs(arah.y):
			$AnimatedSprite2D.play("move_right" if arah.x > 0 else "move_left")
		else:
			$AnimatedSprite2D.play("move_down" if arah.y > 0 else "move_up")
	else:
		# Idle, atau target null: selalu rem sampai berhenti
		velocity = velocity.move_toward(Vector2.ZERO, speed * delta * 5)

	move_and_slide()

func _on_area_deteksi_body_entered(body: Node2D) -> void:
	# Hanya aktif kalau player benar-benar di atas kepala, bukan nyenggol dari samping
	if body.name == "player" and body.global_position.y < global_position.y:
		is_ridden = true

func _on_area_deteksi_body_exited(body: Node2D) -> void:
	if body.name == "player":
		is_ridden = false
		velocity = Vector2.ZERO
