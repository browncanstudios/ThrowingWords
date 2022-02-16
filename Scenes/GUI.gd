extends Control

var attack_words_spoken = []

func updateTranscript(transcript):
	$Bottom/VBoxContainer/Transcript/Label.text += " " + transcript
	if $Bottom/VBoxContainer/Transcript/Label.get_line_count() > 1:
		$Bottom/VBoxContainer/Transcript/Label.text = "TRANSCRIPT:" + " " + transcript

func updateAttackWords(word, count):
	if attack_words_spoken.count(word) == 0:
		$Bottom/VBoxContainer/AttackWords/Label.text += " " + word.to_upper() + "x" + str(count)
		attack_words_spoken.append(word)
	else:
		var index = $Bottom/VBoxContainer/AttackWords/Label.text.findn(word)
		$Bottom/VBoxContainer/AttackWords/Label.text[index + word.length() + 1] = str(count)

func updateScore(score):
	$Top/Score/Label.text = "SCORE: " + str(score)
