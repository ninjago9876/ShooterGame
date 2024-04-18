extends Resource
class_name Highscore

@export var level: int = 0
@export var kills: int = 0

func update_highscore(newLevel: int, newKills: int):
	if newLevel > level:
		level = newLevel
	if newKills > kills:
		kills = newKills
