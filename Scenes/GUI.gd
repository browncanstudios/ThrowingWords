extends Control

func updateTranscript(transcript):
	$Bottom/VBoxContainer/Transcript/Label.text += " " + transcript
	if $Bottom/VBoxContainer/Transcript/Label.get_line_count() > 1:
		$Bottom/VBoxContainer/Transcript/Label.text = "TRANSCRIPT:" + " " + transcript
