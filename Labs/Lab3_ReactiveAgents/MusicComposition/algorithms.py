import random
def simple_next(status):
	if status.current ==-1: # start
		status.midinote=60
		status.dur =1
		status.BPM = 120
		status.amp = 1
		status.current=0
	elif status.current==0:
		status.midinote=status.midinote+1
		if status.midinote==84:
			status.current=1
	elif status.current==1:
		status.midinote -=1
		if status.midinote==60:
			status.current = 0

major_arpeggio=[0, +4,  +7]
minor_arpeggio=[0, +3,  +7]

def arpeggio_next(status):
	if status.current ==-1: # start
		status.midinote=60
		status.dur = 1
		status.pars["count"]=0
		status.pars["verse"]=1
		status.pars["grade"]=0
		status.pars["tonic"]=60
		status.BPM = 240
		status.amp = 1
		status.current=0
		return
	status.pars["count"]+=1 # always increasing count	
	if status.midinote >84:	
		status.pars["verse"]=-1
	if status.midinote <48:	
		status.pars["verse"]=1
	
	status.pars["grade"]+=status.pars["verse"]
	status.amp = 1
	status.dur=0.5
	if status.pars["count"]%3 ==0:
		status.dur=1 # a beat every 3
	if status.pars["count"]%3 ==2:
		status.amp = 0.8 # weak beat

	if status.current==0:
		status.midinote=status.pars["tonic"]+\
						major_arpeggio[status.pars["grade"]%3]
	elif status.current==1:
		status.midinote=status.pars["tonic"]+\
						minor_arpeggio[status.pars["grade"]%3]
		
	random_value=random.random()
	if random_value<.3: #probability 30%
		# change tonic
		status.pars["tonic"]=status.midinote
		status.pars["grade"]=0
		status.pars["count"]=0		
		print("changing tonic!")
	elif random_value>.7: # probability 30%
		# change mode
		status.current = 1-status.current
		print("changin major-minor!")
