def simple_next(status):
	if status.current==-1:
		status.midinote=60
		status.current=0
		status.dur=1
		status.amp=1		
	elif status.current==0:
		status.midinote=status.midinote+1
		status.dur=1		
		if status.midinote==84:
			status.dur=4
			status.current=1
	elif status.current==1:
		status.dur=1
		status.midinote=status.midinote-1
		if status.midinote==0:
			status.current=0
			status.dur=4
