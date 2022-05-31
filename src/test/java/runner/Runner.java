package runner;

import cucumber.api.CucumberOptions;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.AfterClass;
import org.junit.runner.RunWith;

import com.jayway.restassured.response.Response;

import utilities.InvokeWebService;
//import utilities.KarateReportPortalRunner;
import utilities.ReadConfig;
import utilities.ReadRPProperties;


//@RunWith(KarateReportPortalRunner.class)
@CucumberOptions(
		features = "classpath:features",
		tags = {"@AuditPutaway"},
		plugin = {"pretty",
				"com.epam.reportportal.cucumber.ScenarioReporter",
				"html:target/cucumber-reports/cucumber-pretty",
				"json:target/cucumber-reports/json-reports/CucumberTestReport.json",
				"rerun:target/cucumber-reports/rerun.txt",}
		)
public class Runner {
    
	private static final Logger LOG = LogManager.getLogger(Runner.class);
	
	 //@AfterClass
	 public static void updateReportPortalLaunchDetails() throws Exception
	 {
		
		String rp_enable = ReadRPProperties.getConfigData().get("rp.enable");
		
		if(rp_enable.equalsIgnoreCase("false"))
		{
			LOG.info("Report Portal - no changes done.");
		}
		else
		{
			//code for injecting Cucumber Report path and Execution Source to Report Portal
			int launchId;
			String execution_source = "";
			String updated_rp_description="";
			String authorization = "";
			String build_url = System.getProperty("build_url");
			String classpathRoot = System.getProperty("user.dir");
			classpathRoot = classpathRoot.replace("\\", "/");
			
			if(build_url == null)
			{
				execution_source = "local";
				updated_rp_description = "Cucumber Report Path -> " + classpathRoot + "/target/cucumber-reports/cucumber-html-reports/overview-features.html";
				authorization = ReadConfig.getConfigData().get("rp_auth_token");
			}
			else
			{
				execution_source = "looper";
				updated_rp_description = "Cucumber Report URL -> " + build_url + "cucumber-html-reports/overview-features.html";
				authorization = "bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MDAyNjU0OTQsInVzZXJfbmFtZSI6InZuMGh3dnEiLCJhdXRob3JpdGllcyI6WyJST0xFX1VTRVIiXSwianRpIjoiYTU1ODdlZDAtYjM0NS00MTA1LTk3ZjUtZWMxZjU2NGI2NGEzIiwiY2xpZW50X2lkIjoidWkiLCJzY29wZSI6WyJ1aSJdfQ.60By2miokbsWinzVtpYOk2FhsUSBD4Z3N0I0V__ww_8";
			}
			
			InvokeWebService invokeWebService = new InvokeWebService();
			Response response = invokeWebService.getLatestLaunchDetails(authorization);
			int response_status = response.getStatusCode();
			if(response_status == 200)
			{
				launchId = response.path("content[0].id");
				LOG.info("Report Portal - getLatestLaunchDetails successful. launchId -> " + launchId);
				
				response = invokeWebService.updateLatestLaunch(launchId, "execution", execution_source, updated_rp_description, authorization);			
				response_status = response.getStatusCode();
				if(response_status == 200)
				{
					LOG.info("Report Portal - updateLatestLaunch successful");
				}
				else
				{
					LOG.info("Report Portal - updateLatestLaunch failed. Please check response for details.");
				}
			}
			else
			{
				LOG.info("Report Portal - getLatestLaunchDetails failed . Please check response for details.");
			}
		}
		
		 
	 }
	
	
}

