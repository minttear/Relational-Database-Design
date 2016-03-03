try(Statement stmt =oracleConnection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
	ResultSet.CONCUR_READ_ONLY)){
	ResultSet rst =stmt.executeQuery("CREATE VIEW TEMP1
AS
SELECT DISTINCT FIRST_NAME,LENGTH(FIRST_NAME) AS VALUE FROM" +userTableName+
"ORDER BY LENGTH(FIRST_NAME) ;

SELECT FIRST_NAME FROM TEMP1
WHERE VALUE =(SELECT MAX(VALUE) FROM TEMP1);DROP VIEW TEMP1"
);
while(rst.next()){
	String firstname  =getString(1);
	this.longestFirstNames.add(firstname);

rst = stmt.executeQuery("CREATE VIEW TEMP1 AS SELECT DISTINCT FIRST_NAME,LENGTH(FIRST_NAME) AS VALUE FROM" +userTableName+
"ORDER BY LENGTH(FIRST_NAME) ;
SELECT FIRST_NAME FROM TEMP1 WHERE VALUE =(SELECT MIN(VALUE) FROM TEMP1);DROP VIEW TEMP1"
);
while(rst.next()){
	String firstname  =getString(1);
	this.shortestFirstNames.add(firstname);

}

rst =stmt.executeQuery("CREATE VIEW TEMP2 AS SELECT FIRST_NAME, COUNT(*) AS NUM FROM" +userTableName+"
GROUP BY FIRST_NAME;
SELECT FIRST_NAME,NUM FROM TEMP2 WHERE NUM=(SELECT MAX(NUM)FROM TEMP2); DROP VIEW TEMP2"
	);

while(rst.next()){
	String firstname  =getString(1);
	this.mostCommonFirstNames.add(firstname);
	mostCommonFirstNamesCount++;
}

rst.close();
stmt.close();
}catch(SQLException) err{
	System.err.println(err.getMessage());
}
}


