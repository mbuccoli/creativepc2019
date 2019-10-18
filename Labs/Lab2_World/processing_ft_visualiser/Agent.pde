import ddf.minim.*;
import ddf.minim.analysis.*;
int HEIGHT=720;
int SMOOTHING_WINDOW = 10;
int MARGIN;

float[] create_zero_buffer(){
  float[] buffer = new float[SMOOTHING_WINDOW];
  for (int i=0; i<SMOOTHING_WINDOW; i++){
    buffer[i]=0.;
  }
  return buffer;
}
float compute_flatness(FFT fft, float sum_of_spectrum){  
  float flatness= random(-1000,1000);
  return flatness;
}

float compute_centroid(FFT fft, float sum_of_spectrum, 
                                        float[] freqs){
   float centroid = 0.;//random(-1000,1000); // initialize to 0
   for(int i=0; i<fft.specSize(); i++){
     centroid += fft.getBand(i)*freqs[i];
   }   
   
   return centroid/sum_of_spectrum;
}

float compute_spread(FFT fft, float centroid, float sum_of_bands, float[] freqs){
  float spread= random(-1000,1000);  
  return spread;
}

float compute_skewness(FFT fft, float centroid, float spread, float[] freqs){
  float skewness= random(-1000,1000);
  return skewness;
}

float compute_entropy(FFT fft){
  float entropy = random(-1000,1000);
  return entropy;
}

float compute_sum_of_spectrum(FFT fft){
  float sum_of=0;
  for(int i = 0; i < fft.specSize(); i++)
   {
     sum_of += fft.getBand(i);      
   }
  return sum_of+1e-15; // adding a little displacement to avoid division by zero
}

float[] compute_peak_band_and_freq(FFT fft, float[] freqs){
  float val=0;
  float maxPeakVal=0;
  float maxFreqVal=0;
  float[] peak_band_freq= new float[2];
  peak_band_freq[0]=0.; // peak band
  peak_band_freq[1]=0.; // peak freq
  
  for(int i = 0; i < fft.specSize(); i++){
    val=fft.getBand(i);
    if(val>maxPeakVal){ 
      maxPeakVal=val;
      peak_band_freq[0]=1.0*i;
    }
    if(val>maxFreqVal && freqs[i]>20.){ 
      // if new max in the audible spectrum
      peak_band_freq[1]=freqs[i];
      maxFreqVal=val;
    }
  }   
  
  return peak_band_freq;
}

float get_average(float[] buffer){
  float average=0;
  for(int i=0; i<buffer.length; i++){
      average+=buffer[i];
  }
  return average/buffer.length;
}
float compute_energy(FFT fft) {    
  float energy = 0;
  for(int i = 0; i < fft.specSize(); i++){
    energy+=pow(fft.getBand(i),2);      
  }   
  return energy;
}
class AgentFeature { 
  int index_buffer=0;
  int index_spectrogram=0;
  int bufferSize;
  float sampleRate;
  int specSize;
  FFT fft;
  BeatDetect beat;
  float[] centroidBuffer;
  float[] spreadBuffer;
  float[] skewnessBuffer;
  float[] entropyBuffer;
  float[] flatnessBuffer;
  float[] energyBuffer;
  float[] sum_of_bands;  
  float[] peak_frequencyBuffer;
  float[][] spectrogram;
  float[] freqs;  
  float centroid;
  float spread;
  float energy;
  float skewness;
  float entropy;
  float flatness;
  boolean isBeat;
  
  AgentFeature(int bufferSize, float sampleRate){
    this.bufferSize=bufferSize;
    this.sampleRate=sampleRate;
    this.fft = new FFT(bufferSize, sampleRate);
    this.fft.window(FFT.HAMMING);
    this.specSize=this.fft.specSize();
    this.beat = new BeatDetect();
    
    this.sum_of_bands = create_zero_buffer();
    this.centroidBuffer = create_zero_buffer();
    this.spreadBuffer = create_zero_buffer();
    this.skewnessBuffer = create_zero_buffer();
    this.entropyBuffer = create_zero_buffer();
    this.flatnessBuffer = create_zero_buffer();
    this.energyBuffer = create_zero_buffer();
    this.peak_frequencyBuffer = create_zero_buffer();    
    this.freqs=new float[this.specSize];
    for(int i=0; i<this.specSize; i++){
      this.freqs[i]= 0.5*(1.0*i/this.specSize)*this.sampleRate;
    }
    this.spectrogram = new float[width][this.specSize];
    this.isBeat=false;
    this.centroid=0;
    this.spread=0;
    this.skewness=0;    
    this.entropy=0;
    this.energy=0;
  }
  void reasoning(AudioBuffer mix){
     this.fft.forward(mix);
     this.beat.detect(mix);
     this.sum_of_bands[this.index_buffer]= compute_sum_of_spectrum(this.fft);
     this.centroidBuffer[this.index_buffer] = compute_centroid(this.fft,this.sum_of_bands[this.index_buffer],this.freqs);
     this.flatnessBuffer[this.index_buffer]= compute_flatness(this.fft,
                                                             this.sum_of_bands[this.index_buffer]);
     this.spreadBuffer[this.index_buffer] = compute_spread(this.fft, this.centroidBuffer[this.index_buffer], 
                                                           this.sum_of_bands[this.index_buffer], this.freqs);                                  
     this.skewnessBuffer[this.index_buffer]= compute_skewness(this.fft, this.centroidBuffer[this.index_buffer], 
                                                              this.spreadBuffer[this.index_buffer], this.freqs);
                                                              
     this.entropyBuffer[this.index_buffer] = compute_entropy(this.fft);     
     this.energyBuffer[this.index_buffer] = compute_energy(this.fft);
     //float[] band_freq = compute_peak_band_and_freq(this.fft, this.freqs);
     
     this.index_buffer = (this.index_buffer+1)%SMOOTHING_WINDOW;
     this.centroid = get_average(this.centroidBuffer);    
     this.energy = get_average(this.energyBuffer);
     this.flatness = get_average(this.flatnessBuffer);
     this.spread = get_average(this.spreadBuffer);
     this.skewness = get_average(this.skewnessBuffer);
     this.entropy = get_average(this.entropyBuffer);
     this.isBeat = this.beat.isOnset();
  }   
} 

class AgentDrawer{
  AgentFeature feat;
  int numFeatures;
  float heightFeatures;
  float maxWidth;
  int textSpace;
  int marginLeft;
  float maxFeatures[];
  float minFeatures[];
  String[] labels={"ENERGY","CENTR", "SPREAD", "SKEW", "ENTR", "FLAT"};
  color[] colors={color(255,255,0), color(255,0,255), color(0,255,255),
                  color(255,0,0), color(0,255,0), color(255,128,0)};
  AgentDrawer(AgentFeature feat, int numFeatures){
    this.feat=feat;
    MARGIN=int(0.05*height);
    
    this.numFeatures=numFeatures;
    this.heightFeatures= 1.0*(height-2*MARGIN)-((this.numFeatures-1)*MARGIN);
    this.heightFeatures/=numFeatures;
    this.textSpace= int(this.heightFeatures*4);
    this.marginLeft= MARGIN+this.textSpace;
    this.maxWidth= width-MARGIN-this.marginLeft;
    this.maxFeatures = new float[numFeatures];
    this.minFeatures = new float[numFeatures];
  }
  void action(){
    float[] values = {this.feat.energy, this.feat.centroid, 
             this.feat.spread, this.feat.skewness,
             this.feat.entropy, this.feat.flatness};    
    int aboveSpace=MARGIN;    
    float x;
    textSize((int)this.heightFeatures);
    for (int i=0; i<this.numFeatures; i++){
        aboveSpace=MARGIN+i*((int)this.heightFeatures+MARGIN);    
        fill(this.colors[i]);
        text(this.labels[i], MARGIN, aboveSpace+this.heightFeatures);
        if (values[i]>this.maxFeatures[i]){
             this.maxFeatures[i]=values[i];}
        if (values[i]<this.minFeatures[i]){
            this.minFeatures[i]=values[i];}    
        x=map(values[i], this.minFeatures[i], this.maxFeatures[i], 0, this.maxWidth);
        rect(this.marginLeft, aboveSpace,  x, this.heightFeatures); 
        
    }
  
  }

}  
