package utilities;

import java.sql.*; 
import java.util.ArrayList;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class DBUtilities
{
	private static final Logger LOG = LogManager.getLogger(DBUtilities.class);
	
	public Connection storeDBConnection() throws Exception
	{
		String store_db_username, store_db_password;
		
		store_db_username = System.getProperty("store_db_username");
		store_db_password = System.getProperty("store_db_password");
		
		if(store_db_username == null && store_db_password == null)
		{
			store_db_username = ReadConfig.getConfigData().get("store_db_username");
			store_db_password = ReadConfig.getConfigData().get("store_db_password");
		}
		
		
		
		//load the driver class  
		Class.forName("oracle.jdbc.driver.OracleDriver");  
		  
		//create  the connection object  
		Connection con=DriverManager.getConnection("jdbc:oracle:thin:@s608661-scan2-v1.cert.hosting.asda.com:1523/storcert", store_db_username, store_db_password);
		LOG.info("Database connection opened successful");
		
		return con;
	}
	
	
	public Connection cdmDBConnection() throws Exception
	{
		String cdm_db_username, cdm_db_password;
		
		cdm_db_username = System.getProperty("cdm_db_username");
		cdm_db_password = System.getProperty("cdm_db_password");
		
		if(cdm_db_username == null && cdm_db_password == null)
		{
			cdm_db_username = ReadConfig.getConfigData().get("cdm_db_username");
			cdm_db_password = ReadConfig.getConfigData().get("cdm_db_password");
		}
		
		
		
		//load the driver class  
		Class.forName("oracle.jdbc.driver.OracleDriver");  
		 
		//create  the connection object  
		Connection con=DriverManager.getConnection("jdbc:oracle:thin:@s608661-scan2-v1.cert.hosting.asda.com:1523/SHARECRT", cdm_db_username, cdm_db_password);
		LOG.info("Database connection opened successful");
		
		return con;
	}
	
	//connect_parcel_return_map
	public List<String> validateParcelReturnMapTable(String parcel_number)
	{  
		String parcel_number1 = "";
		String ship_confirm_flag = "";
		String shipping_label = "";
		List<String> parcelReturnMapDataList = new ArrayList<String>();
		try{  
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query 
			ResultSet rs=stmt.executeQuery("Select * from ora_cert_isc.connect_parcel_return_map where parcel_number = '" + parcel_number + "'");
			
			while(rs.next())  
			{
				parcel_number1 = rs.getString(1);
				ship_confirm_flag = rs.getString(4);
				shipping_label = rs.getString(9);
				
				parcelReturnMapDataList.add(parcel_number1);
				parcelReturnMapDataList.add(ship_confirm_flag);
				parcelReturnMapDataList.add(shipping_label);
				
				LOG.info("PARCEL_NUMBER -> " + parcel_number1 + ", SHIP_CONFIRM_FLAG -> " + ship_confirm_flag + ", SHIPPING_LABEL -> " + shipping_label);
				
			}
			
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful"); 
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
		}  
		  
		return parcelReturnMapDataList;
		
	} 
	
	//connect_parcel_rna
	public List<String> getParcelRNATable(String parcel_number)
	{  
		String slot_id = "";
		String store_id = "";
		String putaway_status = "";
		List<String> parcelRNADataList = new ArrayList<String>();
		try{  
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("Select * from ora_cert_isc.connect_parcel_rna where lpn_id = '" + parcel_number + "'");
			
			while(rs.next())  
			{
				slot_id = rs.getString(2);
				store_id = rs.getString(4);
				putaway_status = rs.getString(5);
				
				parcelRNADataList.add(slot_id);
				parcelRNADataList.add(store_id);
				parcelRNADataList.add(putaway_status);
				
				LOG.info("parcel_number -> " + parcel_number + ", slot_id -> " + slot_id + ", store_id -> " + store_id + ", putaway_status -> " + putaway_status);
				
			}
			
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
	  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return parcelRNADataList;
		
	} 
	
	//connect_parcel_state
	public List<String> getParcelDetailsFromParcelStateTable(String orderNum)
	{  
		String parcel_number = "";
		String do_received_flag = "";
		String do_number = "";
		String delivery_number = "";
		List<String> parcelDetailsList_ParcelStateTable = new ArrayList<String>();
		
		try{ 
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select * from ORA_CERT_ISC.connect_parcel_state where order_number = '" + orderNum + "'");
			while(rs.next())  
			{
				parcel_number = rs.getString(1);
				do_received_flag = rs.getString(7);
				do_number = rs.getString(9);
				delivery_number = rs.getString(5);
				LOG.info("parcel_number -> " + parcel_number + ", do_received_flag -> " + do_received_flag + ", do_number -> " + do_number + ", delivery_number -> " + delivery_number);
				
				parcelDetailsList_ParcelStateTable.add(parcel_number);	//0
				parcelDetailsList_ParcelStateTable.add(do_received_flag);	//1
				parcelDetailsList_ParcelStateTable.add(do_number);	//2
				parcelDetailsList_ParcelStateTable.add(delivery_number);	//3
			}
			
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");

		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return parcelDetailsList_ParcelStateTable;
		
	} 
	
	//connect_parcel_state
	public String getOrderNumberFromParcelStateTable(String parcelNumber)
	{  
		String order_number = "";
					
		try{ 
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select * from ORA_CERT_ISC.connect_parcel_state where parcel_number = '" + parcelNumber + "'");
			while(rs.next())  
			{
				order_number = rs.getString(2);
				LOG.info("order_number -> " + order_number);
				
			}
			
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
	
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return order_number;
		
	} 
	
	//connect_parcel_state
	public String getContainerNumberFromParcelStateTable(String storeNum, String statusIds)
	{  
		String container_number = "";
					
		try{ 
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select container_number from (select * from ORA_CERT_ISC.connect_parcel_latest_trans a" +
										   " inner join ORA_CERT_ISC.connect_parcel_state b" +
										   " on a.parcel_number = b.parcel_number" +
										   " where b.container_number is not null" +
										   " and a.status_id in (" + statusIds + ")" +
										   " and a.destination_id = '" + storeNum + "'" +
										   " order by a.created_date desc) where rownum = 1");
			while(rs.next())  
			{
				container_number = rs.getString(1);
				LOG.info("container_number -> " + container_number);
				
			}
			
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");

		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return container_number;
		
	} 
		
	//connect_parcel_latest_trans
	public List<String> getParcelDetailsFromParcelLatestTransTable(String parcelNumber)
	{  
		String status_id = "";
		String reason_code = "";
		String audit_flag = "";
		String store_return_flag = "";
		String dwell_time = "";
		String dwell_time_update_flag = "";
		String destination_id = "";
		String ship_confirm_flag = "";
		String updated_date = "";
		
		List<String> latestTransDetailsList = new ArrayList<String>();
		try{  
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("Select * from ora_cert_isc.connect_parcel_latest_trans where parcel_number = '" + parcelNumber + "'");  
			
			while(rs.next())  
			{
				status_id = rs.getString(2);
				reason_code = rs.getString(3);
				audit_flag = rs.getString(9);
				store_return_flag = rs.getString(7);
				dwell_time = rs.getString(6);
				dwell_time_update_flag = rs.getString(10);
				destination_id = rs.getString(4);
				ship_confirm_flag = rs.getString(12);
				updated_date = rs.getString(18);
				
				latestTransDetailsList.add(status_id);	//0
				latestTransDetailsList.add(reason_code);	//1
				latestTransDetailsList.add(audit_flag);	//2	
				latestTransDetailsList.add(store_return_flag);	//3
				latestTransDetailsList.add(dwell_time);	//4
				latestTransDetailsList.add(dwell_time_update_flag);	//5
				latestTransDetailsList.add(destination_id);	//6
				latestTransDetailsList.add(ship_confirm_flag);	//7
				latestTransDetailsList.add(updated_date);	//8
				
				LOG.info("parcel_number -> " + parcelNumber + ", status_id -> " + status_id + ", reason_code -> " + reason_code + ", audit_flag -> " + audit_flag + ", store_return_flag -> " + store_return_flag + ", dwell_time -> " + dwell_time + ", dwell_time_update_flag -> " + dwell_time_update_flag + ", destination_id -> " + destination_id + ", ship_confirm_flag -> " + ship_confirm_flag + ", updated_date -> " + updated_date);
				
			}
			
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
	  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return latestTransDetailsList;
		
	}
	
	//connect_parcel_latest_trans
	public String getParcelDetailsFromParcelLatestTransTable(String storeNum, String statusId, String rowNum)
	{  
		String parcel_number = "";
		
		try{  
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select * from (Select parcel_number, rownum as rn from ora_cert_isc.connect_parcel_latest_trans where destination_id = '" + storeNum + "' and status_id = " + statusId + "order by created_date desc) where rn = " + rowNum);  
			
			while(rs.next())  
			{
				parcel_number = rs.getString(1);
								
				LOG.info("parcel_number -> " + parcel_number);
				
			}
			
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
	  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return parcel_number;
		
	}
	
	//connect_parcel_latest_trans
	public String getParcelSpecificUserFromParcelLatestTransTable(String storeNum, String statusId, String rowNum, String updated_by)
	{  
		String parcel_number = "";
		
		try{  
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select * from (Select parcel_number, rownum as rn from ora_cert_isc.connect_parcel_latest_trans where destination_id = '" + storeNum + "' and status_id = '" + statusId  + "' and updated_by = '" + updated_by + "' order by created_date desc) where rn = " + rowNum);  
			
			while(rs.next())  
			{
				parcel_number = rs.getString(1);
								
				LOG.info("parcel_number -> " + parcel_number);
				
			}
			
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
	  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return parcel_number;
		
	}
	
	//connect_parcel_latest_trans
	public String getB2CParcelSpecificUserFromParcelLatestTransTable(String storeNum, String statusId, String rowNum, String updated_by)
	{  
		String parcel_number = "";
		
		try{  
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select * from (Select parcel_number, rownum as rn from ora_cert_isc.connect_parcel_latest_trans where parcel_number not like 'ASD%' and destination_id = '" + storeNum + "' and status_id = '" + statusId  + "' and updated_by = '" + updated_by + "' order by created_date desc) where rn = " + rowNum);  
			
			while(rs.next())  
			{
				parcel_number = rs.getString(1);
								
				LOG.info("parcel_number -> " + parcel_number);
				
			}
			
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
	  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return parcel_number;
		
	}
	
	//connect_parcel_latest_trans
	public String getB2CParcelTNASFromParcelLatestTransTable(String storeNum, String statusId, String rowNum, String clientId)
	{  
		String parcel_number = "";
		
		try{  
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select * from (Select parcel_number, rownum as rn from ora_cert_isc.connect_parcel_latest_trans where parcel_number like '" + clientId + "%' and destination_id = '" + storeNum + "' and status_id = '" + statusId  + "' order by created_date desc) where rn = " + rowNum);  
			
			while(rs.next())  
			{
				parcel_number = rs.getString(1);
								
				LOG.info("parcel_number -> " + parcel_number);
				
			}
			
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
	  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return parcel_number;
		
	}
	
	
	//connect_parcel_latest_trans
	public String getParcelForDTEFromParcelLatestTransTable(String storeNum, String updated_by)
	{  
		String parcel_number = "";
		
		try{  
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("Select * from (Select * from ora_cert_isc.connect_parcel_latest_trans where destination_id = '" + storeNum + "' and status_id = 4 and dwell_time_update_flag is null and updated_by = '" + updated_by + "' order by created_date desc) where rowNum = 1");  
			
			while(rs.next())  
			{
				parcel_number = rs.getString(1);
								
				LOG.info("parcel_number -> " + parcel_number);
				
			}
			
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
	  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return parcel_number;
		
	}
	
	
	//connect_loc_pkg_trans
	public List<String> validateLocPkgTransTable1(String storeNum, String parcelNumber)
	{  
		String slot_id = "";
		String package_level = "";
		
		List<String> locPkgTransDetailsList = new ArrayList<String>();
		
		try{  
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select * from ORA_CERT_ISC.connect_loc_pkg_trans where store_id = '" + storeNum + "' and parcel_number = '" + parcelNumber + "'");  
			
			while(rs.next())  
			{
				slot_id = rs.getString(3);
				package_level = rs.getString(2);
				
				locPkgTransDetailsList.add(slot_id); //0
				locPkgTransDetailsList.add(package_level); //1
				
				LOG.info("parcel_number -> " + parcelNumber + ", slot_id -> " + slot_id + ", package_level -> " + package_level);
				
			}
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
		  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return locPkgTransDetailsList;
		
	}
	
	//connect_loc_pkg_trans
	public String validateLocPkgTransTable2(String storeNum, String slot_id)
	{  
		String parcel_number = "";
		
		try{  
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select * from ORA_CERT_ISC.connect_loc_pkg_trans where store_id = '" + storeNum + "' and slot_id = '" + slot_id + "'");  
			
			while(rs.next())  
			{
				parcel_number = rs.getString(1);
				
				LOG.info("parcel_number -> " + parcel_number);
				
			}
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
				  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return parcel_number;
		
	}
	
	//cdm_client_value
	public String getParcelNumberAfterCreateLabel(String clientType)
	{  
		String parcel_number = "";
		
		try{  
			//create database connection
			Connection con = cdmDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query 
			ResultSet rs=stmt.executeQuery("select * from (Select * from ora_cert_cdm.cdm_client_value where created_by = '" + clientType + "WebReturn' order by created_date desc) where rownum=1");
						
			while(rs.next())  
			{
				parcel_number = rs.getString(1);
				
				LOG.info("parcel_number -> " + parcel_number);
				
			}
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
				  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return parcel_number;
		
	}

	//connect_parcel_latest_trans, connect_status_master
	public String validateParcelStatusDatabase(String parcelNumber)
	{  
		String parcel_status = "";
		try{  
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select a.parcel_number, a.status_id, b.status_name"
					+ " from ORA_CERT_ISC.connect_parcel_latest_trans a join ORA_CERT_ISC.connect_status_master b"
					+ " on a.status_id = b.status_id where a.parcel_number = '" + parcelNumber + "'");  
			
			while(rs.next())  
			{
				parcel_status = rs.getString(3);
				LOG.info("PARCEL_NUMBER -> " + rs.getString(1) + ", STATUS_ID -> " + rs.getInt(2) + ", STATUS_NAME -> " + parcel_status);
				
			}
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");

		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return parcel_status;
		
	}
	
	//CDM_QR_LINK_SMS
	public List<String> getParcelDetailsFromCDM_QR_LINKTable(String parcelNumber)
	{  
		String unique_code = "";
		String order_number = "";
		String client_name = "";
		String facility_name = "";
		String dwell_time = "";
		
		List<String> cdmQRLinkDetailsList = new ArrayList<String>();
		
		try{  
			//create database connection
			Connection con = cdmDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select * from ORA_CERT_CDM.CDM_QR_LINK_SMS where parcel_number = '" + parcelNumber + "'");  
			
			while(rs.next())  
			{
				unique_code = rs.getString(1);
				order_number = rs.getString(2);
				client_name = rs.getString(3);
				facility_name = rs.getString(5);
				dwell_time = rs.getString(6);
				
				cdmQRLinkDetailsList.add(unique_code); //0
				cdmQRLinkDetailsList.add(order_number); //1
				cdmQRLinkDetailsList.add(client_name); //2
				cdmQRLinkDetailsList.add(facility_name); //3
				cdmQRLinkDetailsList.add(dwell_time); //4
				
				LOG.info("parcel_number -> " + parcelNumber + ", unique_code -> " + unique_code + ", order_number -> " + order_number + ", client_name -> " + client_name + ", facility_name -> " + facility_name + ", dwell_time -> " + dwell_time);
				
			}
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
		  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return cdmQRLinkDetailsList;
		
	}
	
	//cdm_client_ref
	public List<String> getClientDetailsFromCdm_client_refTable(String client_name)
	{  
		String client_id = "";
				
		List<String> cdmClientDetailsList = new ArrayList<String>();
		
		try{  
			//create database connection
			Connection con = cdmDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select * from ORA_CERT_CDM.cdm_client_ref where client_name = '" + client_name + "'");  
			
			while(rs.next())  
			{
				client_id = rs.getString(2);
							
				cdmClientDetailsList.add(client_id); //0
				
				LOG.info("client_name -> " + client_name + ", client_id -> " + client_id);
				
			}
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
		  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return cdmClientDetailsList;
		
	}
	
	
	//cdm_facility_ref
	public List<String> getFacilityDetailsFromCdm_facility_refTable(String facility_name)
	{  
		String facility_id = "";
				
		List<String> cdmFacilityDetailsList = new ArrayList<String>();
		
		try{  
			//create database connection
			Connection con = cdmDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select * from ORA_CERT_CDM.cdm_facility_ref where facility_name = '" + facility_name + "'");  
			
			while(rs.next())  
			{
				facility_id = rs.getString(2);
							
				cdmFacilityDetailsList.add(facility_id); //0
				
				LOG.info("facility_name -> " + facility_name + ", facility_id -> " + facility_id);
				
			}
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
		  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return cdmFacilityDetailsList;
		
	}
	
	//connect_parcel_latest_trans, connect_parcel_state
	public List<String> getParcelDetailsForNotReceivedContainers(String storeId)
	{  
		String parcel_number = "";
		String container_number = "";
				
		List<String> parcelDetailsList = new ArrayList<String>();
		
		try{  
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			/*
			ResultSet rs=stmt.executeQuery("select * from (select * from ORA_CERT_ISC.connect_parcel_latest_trans a" + 
										   " inner join ORA_CERT_ISC.connect_parcel_state b" +
										   " on a.parcel_number = b.parcel_number" +
										   " where b.container_number is not null" +
										   " and a.status_id = 1" +
										   " and a.destination_id = '" + storeId + "'" +
										   " and a.parcel_number not like 'PLTC%'" +
										   " order by a.created_date desc) where rownum = 1");  
			*/
			
			ResultSet rs=stmt.executeQuery("select * from ORA_CERT_ISC.connect_parcel_latest_trans a" + 
					   " inner join ORA_CERT_ISC.connect_parcel_state b" +
					   " on a.parcel_number = b.parcel_number" +
					   " where b.container_number is not null" +
					   " and a.status_id = 1" +
					   " and a.destination_id = '" + storeId + "'" +
					   " and a.parcel_number not like 'PLTC%'" +
					   " order by a.created_date desc"); 
			
			while(rs.next())  
			{
				parcel_number = rs.getString(1);
				container_number = rs.getString(24);
							
				parcelDetailsList.add(parcel_number); //0
				parcelDetailsList.add(container_number); //1
				
				LOG.info("parcel_number -> " + parcel_number + ", container_number -> " + container_number);
				
			}
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
		  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return parcelDetailsList;
		
	}
	
	//connect_container_trans
	public String getCageNumber(String container_number)
	{  
		String cage_number = "";
					
		try{  
			//create database connection
			Connection con = storeDBConnection();
			
			//create the statement object  
			Statement stmt=con.createStatement();  
			  
			//execute query  
			ResultSet rs=stmt.executeQuery("select * from ORA_CERT_ISC.connect_container_trans where container_number = '" + container_number + "'");  
			
			while(rs.next())  
			{
				cage_number = rs.getString(5);
							
				LOG.info("cage_number -> " + cage_number);
				
			}
			//close the connection object  
			con.close(); 
			LOG.info("Database connection closed successful");
		  
		}
		catch(Exception e)
		{ 
			LOG.info(e.getMessage());
			
		}  
		  
		return cage_number;
		
	}
	
}
