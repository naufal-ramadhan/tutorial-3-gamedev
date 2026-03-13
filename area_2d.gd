extends Area2D
@onready var suara_koin = $AudioStreamPlayer2D
@onready var gambar_koin = $AnimatedSprite2D
@onready var area_tabrakan = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gambar_koin.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		suara_koin.play()
		gambar_koin.visible = false
		
		area_tabrakan.set_deferred("disabled", true)
		
		await suara_koin.finished
		
		queue_free()
