package utilities;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.jayway.restassured.RestAssured;
import com.jayway.restassured.builder.RequestSpecBuilder;
import com.jayway.restassured.response.Response;
import com.jayway.restassured.specification.RequestSpecification;

public class InvokeWebService 
{
	private static final Logger LOG = LogManager.getLogger(InvokeWebService.class);
	
	//get Report Portal values
	String baseUrl = ReadRPProperties.getConfigData().get("rp.endpoint");
	String projectName = ReadRPProperties.getConfigData().get("rp.project");
	String description = ReadRPProperties.getConfigData().get("rp.description");
	
	
	public Response updateLatestLaunch(int launchId, String attribute_key, String attribute_value, String updated_description, String authorization) throws Exception
	{
			
		//Rest API's URL
		 String restAPIUrl = baseUrl + "/api/v1/{projectName}/launch/{launchId}/update";
		
		 //API Body
		 String apiBody = String.format("{ \"attributes\": [ { \"key\": \"%s\", \"value\": \"%s\" } ], \"description\": \"%s\", \"mode\": \"DEFAULT\"}", attribute_key, attribute_value, updated_description);
		 
		 LOG.info("Request body -> " + apiBody);	 
		 
		 // Building request by using requestSpecBuilder
		 RequestSpecBuilder builder = new RequestSpecBuilder();
		 
		 //Set API's Body
		 builder.setBody(apiBody);
			 
		 //Set API's header
		 builder.addHeader("Authorization", authorization);
		 
		 builder.addPathParam("projectName", projectName);
		 builder.addPathParam("launchId", launchId);
		 			 
		 //Setting content type as application/json
		 builder.setContentType("application/json; charset=UTF-8");	 
		 RequestSpecification requestSpec = builder.build();
		 Response response = RestAssured.given().relaxedHTTPSValidation().spec(requestSpec).when().put(restAPIUrl);		 
		 LOG.info("response -> " + response.body().asString());
		 
		 return response;
	}
	
	

	public Response getLatestLaunchDetails(String authorization) throws Exception
	{
				
		 //Rest API's URL
		 String restAPIUrl = baseUrl + "/api/v1/{projectName}/launch/latest";
		 	 
		 // Building request by using requestSpecBuilder
		 RequestSpecBuilder builder = new RequestSpecBuilder();
		 		 
		 builder.addHeader("Authorization", authorization);
		 
		 builder.addPathParam("projectName", projectName);
		 		 
		 builder.addQueryParam("filter.eq.description", description);
		 
		 //Setting content type as application/json
		 builder.setContentType("application/json; charset=UTF-8");	 
		 RequestSpecification requestSpec = builder.build();
		 Response response = RestAssured.given().relaxedHTTPSValidation().spec(requestSpec).when().get(restAPIUrl);		 
		 LOG.info("response -> " + response.body().asString());
		 
		 return response;
	}
	
	
	
	
}
