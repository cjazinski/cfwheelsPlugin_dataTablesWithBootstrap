CFWheels plugin for DataTables v0.1a
Christopher Jazinski

== Modified ==
https://github.com/mhenke/DataTablesForWheels

== Requirements ==
CFWheels [Tested 1.1.8]
DataTables jQuery plugin (included)
bootstrap style sheet (included)
DataTables images (included)
jQuery

== Changes from Base Version ==
* Pass in custom params
	* Requires modification of DataTables.cfc
	* Defaults are CRUD params added $dataTablesCRUDParams()
* Added bootstrap theme
* Added bootstrap pagination
* Added default CRUD links to table
* Added Ability to make columns <b>NOT</b> sortable
* Added Ability to show/hide footer columns
 
== Installation ==

1) Place the DataTables-X.X.zip in your plugins folder
2) Place assets in javascripts/images/stylesheets of cfWheels directory(s)	
3) Add this code to your /Controllers/Controller.cfc
	<cfinclude template="/plugins/datatables/datatables.cfm" />
	or cfscript
	include "../plugins/datatables/datatables.cfm";
4) Reload your Wheels application.

EXAMPLES OF USE

== VIEW FILE ==
<!--- Assuming jQuery is already loaded --->
	<head>
		<cfoutput>
		#styleSheetLinkTag(source='datatables/DT_bootstrapv2', head="true")#
		#javaScriptIncludeTag("datatables/DT_bootstrap")#
		</cfoutput>
	</head>
	
	<!--- id name is your ACTION NAME appended with _table_id --->
	<cfoutput>#getdatatablesHTML(myActionName,myColumnNames)#</cfoutput>

== Controller (for View) ==
	In your Controller have a function called your ACTION NAME that returns a query.

	<!--- my ACTION NAME for the datatables --->
	<cffunction name="example" returntype="Query" access="private" >
		<cfset var entries = model("entry").findAll(select="BODY,CATEGORYID,TITLE,dateCreated") />
		<cfreturn entries />
	</cffunction>
	
	<!--- here is the demo action --->
	<cffunction name="demo" >
		<cfset myActionName = "example" />
		
		<cfset myColumnNames = ArrayNew(1) />
		<cfset myColumnNames[1] = "Body" />
		<cfset myColumnNames[2] = "Category ID" />
		<cfset myColumnNames[3] = "Title" />
		<cfset myColumnNames[4] = "Date Created" />
		
		<!--- pass in controller and ACTION NAME --->
		#getdatatablesJS("datatables","example")#
		
		<!--- pass in controller, action name, and sort order
		#getdatatablesJS("datatables","example","body desc, dateCreated desc")#
		 --->
		 <!--- pass in controller, action name, sort order, array of user params or defaults ($dataTablesCrudParams()), and cols NOT sortable --->
		#getDatatablesJS('datatables', "example", 'id asc', $dataTablesCrudParams(delete=false), [4,5])#
		
	</cffunction>
