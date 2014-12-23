-------------Server code-----------
package beans:
All the class in this pakage is used to store the data retrieved from database, and provide the method to convert to JSON format.

package database:
	Database.java:
		this class used to set up connect, and provides the mothods to retrieve data from database
	QueryGenerator:
		this class generates query available in sql
pakage logic:
	SearchForEvent:
		this class provides the main method to check if a event is suitable for a user's preference.
package parse:
	All codes in this package are used to parse JSON format string or other strings that should be parsed.
package Servlet:
	ActivityReply: accept request for activity query
	all the rest servlet provides the service as their name indicates
index.jsp: contains the front-end web application.