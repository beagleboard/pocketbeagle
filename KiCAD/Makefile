# Create fab files.

PocketBeagle-fab.zip:

%-fab.zip : %-fab.kicad_pcb
	python ../kicad-scripts/kicad-fab.py $< plot/
	zip -r $@ plot/

# Replacing any %%gitversion%% with a github version string.
%-fab.kicad_pcb : %.kicad_pcb
	sed "s/%%gitversion%%/`git log --date=short --pretty=format:'%h@%cd' -n 1 $^`/" < $^ > $@
