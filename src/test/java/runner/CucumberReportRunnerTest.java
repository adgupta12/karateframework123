package runner;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.core.ExecutionHook;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Properties;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import static org.junit.Assert.*;

import org.junit.BeforeClass;
import org.junit.Test;

import utilities.DBUtilities;
import utilities.ReadConfig;
import utilities.ScenarioReporter;



public class CucumberReportRunnerTest {


//run as junit  
	
	private static final Logger LOG = LogManager.getLogger(CucumberReportRunnerTest.class);
	String classpathRoot = System.getProperty("user.dir");
	File sourcePath = new File(String.format("%s/target/surefire-reports", classpathRoot));
	

    @Test
    public void testSelected() throws Exception 
    {
    	  
    	String updated_rp_description,updated_attributes;
    	
    	String build_url = System.getProperty("build_url");
    	String rp_mode = System.getProperty("rp_mode");
    	
    	LOG.info("build_url -> " + build_url);
		String classpathRoot1 = classpathRoot.replace("\\", "/");
		
		if(build_url == null)
		{
			updated_attributes = "execution:local";
			updated_rp_description = "Cucumber Report Path -> " + classpathRoot1 + "/target/cucumber-html-reports/overview-features.html";
		}
		else
		{
			updated_attributes = "execution:looper";
			updated_rp_description = "Cucumber Report URL -> " + build_url + "cucumber-html-reports/overview-features.html";
			System.setProperty("rp.mode", rp_mode);
		}
		LOG.info("updated_rp_description -> " + updated_rp_description);

		System.setProperty("rp.attributes", updated_attributes);
		System.setProperty("rp.description", updated_rp_description);
		
		 	
    	String tags1 = System.getProperty("tags");
		
		if(tags1 == null)
		{
//			tags1 = "~@ignore"; //use this to run all test cases except with tag @ignore
//			tags1 = "@All"; //use this to run all test cases
//			tags1 = "@WS013";
//			tags1 = "@PreadviceInjectionAndParcelPutaway";
//			tags1 = "@CreatePreAdvice_2Parcels";
			tags1 = "@CDM"; //use this to run specific web services/test cases
		}
	
        List<String> tags = Arrays.asList(tags1);
        List<String> features = Arrays.asList("classpath:features");
        String karateOutputPath = "target/surefire-reports";
        
        
        try { 
        	FileUtils.cleanDirectory(sourcePath);
		} catch (Exception e) {
			LOG.info(e.getMessage());
			
		} 
        
        List<ExecutionHook> hooks = Arrays.asList(new ScenarioReporter());
       
//        Results results = Runner.parallel(tags, features, 1, karateOutputPath);
        Results results = Runner.parallel(tags, features, null, hooks, 1, karateOutputPath);
        generateReport(karateOutputPath);
        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }
    
    public static void generateReport(String karateOutputPath) {        
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "ToYou_WS_Automation");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();        
    }

}
