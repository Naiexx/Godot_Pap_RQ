extends Control

func _ready():
	Reset_timer()
	
	pass

func _on_timer_timeout():
	if Global.seconds == 0:
		if Global.minutes >0:
			Global.minutes-=1
			Global.seconds= 60
	Global.seconds-=1
	
	if Global.minutes == 0 and Global.seconds == 0:
		$"../../CanvasLayer/estatisticas".visible = true
		$Label.visible = false
		get_tree().paused = true
	
	$Label.text = str(Global.minutes)+":"+str(Global.seconds)
	
	if Global.progressoJogo == 5:
		get_tree().paused = true
		$"../../CanvasLayer/estatisticas".visible = true
		$Label.visible = false
	pass # Replace with function body.

func Reset_timer():
	#Global.seconds = Global.Dseconds
	#Global.minutes = Global.Dminutes
	pass
