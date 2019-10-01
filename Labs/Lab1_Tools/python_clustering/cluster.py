import numpy as np
from sklearn.cluster import DBSCAN

from pythonosc import dispatcher, osc_server, udp_client


class AgentCluster():
	def __init__(self, eps=100, min_samples=5):
		self.dbscan=DBSCAN(eps, min_samples=min_samples)

	def reasoning(self, *msg):
		samples=np.reshape(np.array(msg),[-1,2])
		print("%d new samples"%samples.shape[0])
		return self.dbscan.fit_predict(samples)

	
class AgentOSC():
	def __init__(self, eps, min_samples=5,
							ip="127.0.0.1", 
							port_in=57120,
							port_out=57121,
							name_in="/cluster",
							name_out="/labels"):
		self.ac=AgentCluster(eps, min_samples)
		self.name_in=name_in
		self.name_out=name_out
		

		self.dispatcher = dispatcher.Dispatcher()
		self.dispatcher.map(self.name_in, self.reasoning)
		self.client = udp_client.SimpleUDPClient(ip, port_out)

		self.server = osc_server.ThreadingOSCUDPServer(
					           (ip, port_in), self.dispatcher)

	def reasoning(self, name, *data):
		
		labels=self.ac.reasoning(data)
		print("%d clusters"%(np.unique(labels).size-1))
		self.client.send_message(self.name_out, labels.tolist())
    

	def action(self):
		print("... serving")
		self.server.serve_forever()

if __name__=="__main__": # this is run if this is the main script
	agent=AgentOSC(100)
	agent.action()
