package pfc.audio;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.InputStreamReader;

import pfc.web.Entities.Audio;

import com.languespeak.dtw.DTW;

public class ExecuteCommands {

	public ExecuteCommands(){
	}

	public String run(String command){
		String output = null;

		 try {
            Runtime rt = Runtime.getRuntime();
            Process pr = rt.exec(command);
            BufferedReader input 	= new BufferedReader(new InputStreamReader(pr.getInputStream()));

            String line = null;
            while((line=input.readLine()) != null) {
                output += line;
            }
            int exitVal = pr.waitFor();
            if(exitVal!=0)
            	System.out.println("Exited with error code "+exitVal);

        } catch(Exception e) {
            System.out.println(e.toString());
            e.printStackTrace();
        }
		return output;
	}

	public String bakuzen(){
		String out = run("/var/www/LanguagelearningServer/test1/run.sh");
		int subindex = out.indexOf("=");
		String solucio = out.substring(subindex-6,subindex);
		System.out.println(solucio);

		return solucio;
	}

	public void sox(String file1, String file2){
		run("sox -V "+file1+" -r 22050 -e signed -c 1 -s "+file2);
	}
    public static void main(String[] argv) {

    	new ExecuteCommands().bakuzen();
    }
    public float dwtFile(Audio a, String recordFile){
    	System.out.println("Sox silences process");
    	run("sox "+recordFile+" -t wav -r 16000 -c 1 -b 16 -e signed "+recordFile+".wav silence 1 0.3 0.8% reverse silence 1 0.1 0.1% reverse");
    	run("cp "+recordFile+".wav /var/www/html/tomcat/records/img_audio/audio ");
    	run("HCopy -C /var/www/html/tomcat/records/dtw.cfg "+recordFile+".wav "+recordFile+".mfc ");
		runHList(recordFile);
    	
		float points = 0.0f;
		try{
			DTW d = new DTW(recordFile+".ascii","/var/www/html/tomcat/records/wav/"+a.getSrc().replace(".mp3", ".ascii"));		
			points = d.scoreNorm;
			
			
			
    	}catch(ArrayIndexOutOfBoundsException e){
    		System.out.println("Compared audio too large ");
    		points = -1.0f;
    	}
    	System.out.println("Points of your good pronuntation: " + points);
    	
    	return points;
    	
    }
    private int runHList(String recordFile)
    {
    	 int countSize = 0;
    	 
		 try {

           Runtime rt = Runtime.getRuntime();
           Process pr = rt.exec("HList -r "+recordFile+".mfc");
           BufferedReader input = new BufferedReader(new InputStreamReader(pr.getInputStream()));

           FileWriter out = new FileWriter(recordFile + ".ascii");
          
           String line = null;
           while((line=input.readLine()) != null) {
               
               countSize++ ;
               out. write(line+ '\n');
           }

           out.close();
           int exitVal = pr.waitFor();
           if(exitVal!=0)
           	System.out.println("Exited with error code "+exitVal);

          	System.out.println("El file: "+recordFile+" size "+countSize);
       } catch(Exception e) {
           System.out.println(e.toString());
           e.printStackTrace();
       }
		 return countSize;
    }
    @SuppressWarnings("unused")
	private int runGetLines(String processFile){
    	
		int countLines = 0;
		 try {

          @SuppressWarnings("resource")
          BufferedReader input = new BufferedReader( new FileReader(processFile) );

          String line = null;
          while((line=input.readLine()) != null) {              
        	  countLines++;
          }
         	System.out.println("Process file: "+processFile+" size "+countLines);
      } catch(Exception e) {
          System.out.println(e.toString());
          e.printStackTrace();
      }
		 return countLines;
    }
    @SuppressWarnings("unused")
	private String runGetLastLine(String command)
    {
    	String output = null;
	
		 try {

          Runtime rt = Runtime.getRuntime();
          Process pr = rt.exec(command);
          BufferedReader input = new BufferedReader( new InputStreamReader(pr.getInputStream()));

          String line = null;
          while((line=input.readLine()) != null) {
              output = line;
          }
          int exitVal = pr.waitFor();
          if(exitVal!=0)
          	System.out.println("Exited with error code "+exitVal);

         	System.out.println("The points get : "+output);
      } catch(Exception e) {
          System.out.println(e.toString());
          e.printStackTrace();
      }
	 return output;
    
    }
}
