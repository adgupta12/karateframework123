package utilities;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class ReadConfig 
{
	
	public static Map<String, String> getConfigData() 
	{
		Map<String, String> map = new HashMap<String, String>();	  
		  
		File file = new File("C:\\Users\\vn0hwvq\\config_ToYou_WS.properties");
		  
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
			
		map.put("rp_auth_token", prop.getProperty("rp_auth_token"));
		map.put("store_db_username", prop.getProperty("store_db_username"));
		map.put("store_db_password", prop.getProperty("store_db_password"));
		map.put("cdm_db_username", prop.getProperty("cdm_db_username"));
		map.put("cdm_db_password", prop.getProperty("cdm_db_password"));
		
		return map;

	  }

}
