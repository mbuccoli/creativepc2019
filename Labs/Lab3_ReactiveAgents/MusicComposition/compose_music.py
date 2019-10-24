import time
import numpy as np
from pythonosc import udp_client
from threading import Thread, Event
from algorithms import simple_next, arpeggio_next
import sys

def note_sleep(BPM, beats):
	time.sleep(beats*60./BPM)

class InstrOSC():
	def __init__(self,ip="127.0.0.1",  port=57121, name="/note"):
		self.name=name
		self.client = udp_client.SimpleUDPClient(ip, port)

	def send(self, *data):		
		print("sending %s"%str(data))
		self.client.send_message(self.name, data)
    
class Status:
	def __init__(self):
		self.current=-1
		self.midinote=-1
		self.dur=0
		self.amp=0
		self.BPM=120.
		self.pars={}
	def __str__(self):
		return "\n\t".join(["Status: %d"%self.current, 
								"midinote: %d"%self.midinote, 
								"duration: %d beats"%self.dur,
								"amplitude: %.1f"%self.amp,
								"BPM: %d"%self.BPM,
								"pars: %s"%str(self.pars)])
class Agent(Thread):
	def __init__(self, port, name, BPM, func, ):
		self.status=Status()
		super().__init__(daemon=True, target=self.action)
		self.instr=InstrOSC(port=port, name=name)				
		self.status.BPM=BPM
		self.func=func
		self.stop=Event()
		self.stop.clear()
		self.planning()
	
	def planning(self):
		self.func(self.status)
	def kill(self):
		self.stop.set()

	def action(self):
		while not self.stop.is_set():
			self.planning()
			print(str(self.status))			
			self.instr.send(self.status.midinote,self.status.amp)			
			note_sleep(self.status.BPM, self.status.dur)


if __name__=="__main__":
	n_agents=1
	agents=[_ for _ in range(n_agents)]
	#agents[0] = Agent(57120, "/moog", 60, simple_next)
	agents[0] = Agent(57120, "/moog", 60, arpeggio_next)

	for agent in agents:
		agent.start()
	#agent.join()
	try:
		while True:
			time.sleep(10)
	except:
		for agent in agents:
			agent.kill()
		sys.exit()