package project2;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class TestFakebookOracle {
	
	static String dataType = "PUBLIC"; 
	static String oracleUserName = "myuniqname"; //replace with your Oracle account name
	static String password = "myOraclepassword"; //replace with your Oracle password

	public static void main(String[] args) {
		
		try (Connection conn = getConnection()) {
			FakebookOracle fbwz = new MyFakebookOracle(dataType, conn);
			OutputStreamWriter out = new OutputStreamWriter(System.out);
			
			// Query 0
			fbwz.findMonthOfBirthInfo();
			fbwz.printMonthOfBirthInfo(out);
			
			// Query 1
			fbwz.findNameInfo();
			fbwz.printNameInfo(out);
			
			// Query 2
			fbwz.lonelyFriends();
			fbwz.printLonelyFriends(out);
			
			// Query 3
			fbwz.liveAwayFromHome();
			fbwz.printLiveAwayFromHome(out);
			
			// Query 4
			fbwz.findPhotosWithMostTags(5);
			fbwz.printPhotosWithMostTags(out);
			
			// Query 5
			fbwz.matchMaker(5,2);
			fbwz.printBestMatches(out);
			
			// Query 6	
			fbwz.suggestFriendsByMutualFriends(5);
			fbwz.printMutualFriendsInfo(out);
			
			// Query 7
			fbwz.findAgeInfo(215L);
			fbwz.printAgeInfo(out);
			
			// Query 8
			fbwz.findEventStates();
			fbwz.printStateNames(out);
			
			// Query 9
			fbwz.findPotentialSiblings();
			fbwz.printPotentialSiblings(out);
			
			
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		  }
		  catch (IOException e) {
			e.printStackTrace();
		  }
	}
	
	public static Connection getConnection() throws SQLException{
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
		} catch (InstantiationException e1) {
			e1.printStackTrace();
		} catch (IllegalAccessException e1) {
			e1.printStackTrace();
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		return DriverManager.getConnection("jdbc:oracle:thin:@forktail.dsc.umich.edu:1521:COURSEDB", oracleUserName, password);
	}
}
