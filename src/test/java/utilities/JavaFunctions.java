package utilities;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.imageio.ImageIO;

import com.google.zxing.BinaryBitmap;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.Result;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.HybridBinarizer;



public class JavaFunctions 
{
	
	DBUtilities dbUtilities = new DBUtilities();
	
	public String runNumber()
	{
		String runNum = System.getProperty("run_number");
		return runNum;
	}
	
	public String getSubString(String str, int start_index, int end_index)
	{
		String subStr = str.substring(start_index, end_index+1);
		return subStr;
	}
	
	public String decodeBase64QRCode(String base64QRCode) throws Exception
	{		
		byte[] decodedBytes = Base64.getDecoder().decode(base64QRCode);
		BufferedImage bufferedImage = ImageIO.read(new ByteArrayInputStream(decodedBytes));
	    LuminanceSource source = new BufferedImageLuminanceSource(bufferedImage);
	    BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
	    Result result = new MultiFormatReader().decode(bitmap);
	    return result.getText();
	    
	    
	}
	
	public String decodeBase64Barcode(String base64Barcode) throws Exception
	{		
		byte[] decodedBytes = Base64.getDecoder().decode(base64Barcode);
		BufferedImage bufferedImage = ImageIO.read(new ByteArrayInputStream(decodedBytes));
	    LuminanceSource source = new BufferedImageLuminanceSource(bufferedImage);
	    BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
	    if (bitmap.getWidth() < bitmap.getHeight())
	    {
            if (bitmap.isRotateSupported()) 
            {
                bitmap = bitmap.rotateCounterClockwise();
            }
	    }
	    Result result = new MultiFormatReader().decode(bitmap);
	    return result.getText();
	    
	    
	}
	
	public String formatDate(String dateToBeFormatted, String fromFormat, String toFormat) throws Exception //E, MMM dd yyyy
	{
		DateFormat sdf1 = new SimpleDateFormat(fromFormat);
  		Date date = sdf1.parse(dateToBeFormatted);
  		
  		DateFormat sdf2 = new SimpleDateFormat(toFormat);
  		String formattedDate = sdf2.format(date);
  		
  		return formattedDate;
	}
	
	public String getProjectRootPath()
	{
		String classpathRoot =  System.getProperty("user.dir");
		return classpathRoot;
	}
	
	public String getCurrentDateTime()
	{
		DateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS"); 
  		Date date = new Date();
  		String currentDateTime = sdf.format(date);
		return currentDateTime;
	}
	
	
	
	public String createRandomParcelNumber(String cliendId) throws Exception
	{
		// generate a random integer from 10 to 90 i.e 2 digit random no.
		Random random = new Random();
	    int randomInteger;
	    String parcelNumber;
	    List<String> latestTransDetailsList;
	    String code;
	    
	    if(cliendId.equalsIgnoreCase("ASD"))
	    {
	    	code = "J";
	    }
	    else
	    {
	    	code = "C";
	    }
	    
	    
	    //Get current datetime
  		DateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
  		Date date = new Date();
  		String currentDateTime = sdf.format(date);
  		String mmdd = currentDateTime.substring(4,8);
	    
	    while(true)
	    {
	    	randomInteger = 10000 + random.nextInt(90000);
		    parcelNumber = cliendId + code + mmdd + randomInteger;
		    latestTransDetailsList = dbUtilities.getParcelDetailsFromParcelLatestTransTable(parcelNumber);
		    if(latestTransDetailsList.size()==0)
		    {
		    	break;
		    }
	    }
	    
	    return parcelNumber;
	}
}
