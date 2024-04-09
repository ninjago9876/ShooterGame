extends Node

var kills: int = 0
var level: float = 0
var musicoffset = 0

func update_highscore():
	var file = FileAccess.open("user://highscore", FileAccess.WRITE_READ)
	var content = file.get_as_text()
	if content.is_empty():
		return
	var dict = JSON.parse_string(content)
	if not dict or not dict.level or not dict.kills:
		file.store_string(JSON.stringify({
			level: 0,
			kills: 0
		}))
	var newLevel = dict.level
	if dict.level < level:
		newLevel = level
	var newKills = dict.kills
	if dict.kills < kills:
		newKills = kills
	file.store_string(JSON.stringify({
		level: newLevel,
		kills: newKills
	}))
	kills = newKills
	level = newLevel
