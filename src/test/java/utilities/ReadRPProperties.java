package utilities;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class ReadRPProperties 
{
	private static String classpathRoot = System.getProperty("user.dir");
	private static String sourcePath = String.format("%s/src/test/java/reportportal.properties", classpathRoot);
	
	public static Map<String, String> getConfigData() 
	{
		Map<String, String> map = new HashMap<String, String>();	  
		  
		File file = new File(sourcePath);
		  
		FileInputStream fileInput = null;
		try {
				fileInput = new FileInputStream(file);
		} catch (FileNotFoundException e) {
				e.printStackTrace();
		}
			
		Properties prop = new Properties();
			
		//load properties file
		try {
			prop.load(fileInput);
		} catch (IOException e) {
			e.printStackTrace();
		}
			
		map.put("rp.endpoint", prop.getProperty("rp.endpoint"));
		map.put("rp.uuid", prop.getProperty("rp.uuid"));
		map.put("rp.launch", prop.getProperty("rp.launch"));
		map.put("rp.project", prop.getProperty("rp.project"));
		map.put("rp.description", prop.getProperty("rp.description"));
		map.put("rp.enable", prop.getProperty("rp.enable"));

		
		return map;

	  }

}
