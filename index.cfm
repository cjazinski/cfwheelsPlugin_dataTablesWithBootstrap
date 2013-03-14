<h1>CFWheels plugin for DataTables v0.1a</h1>
<h2>Christopher Jazinski</h2>

== Modified ==<br />
<a href="https://github.com/mhenke/DataTablesForWheels">https://github.com/mhenke/DataTablesForWheels</a><br />

<br />
== Requirements ==<br />
CFWheels [Tested 1.1.8]<br />
DataTables jQuery plugin (included)<br />
bootstrap style sheet (included)<br />
DataTables images (included)<br />
jQuery<br />
<br />
== Changes from Base==<br />
<ul>
	<li>Pass in custom params
		<ul>
			<li>Requires modification of DataTables.cfc</li>
			<li>Defaults are CRUD params added $dataTablesCRUDParams()</li>
		</ul>
	</li>
	<li>Added bootstrap theme</li>
	<li>Added bootstrap pagination</li>
	<li>Added default CRUD links to table</li>
	<li>Added Ability to make columns <b>NOT</b> sortable</li>
	<li>Added Ability to show/hide footer columns</li>
</ul><br />

== Installation ==<br />
1) Place the DataTables-X.X.zip in your plugins folder<br />
2) Place assets in javascripts/images/stylesheets of cfWheels directory(s)<br />
3) Add this code to your /Controllers/Controller.cfc<br />
	cfinclude template="/plugins/datatables/datatables.cfm" <br />
	or cfscript<br />
	include "../plugins/datatables/datatables.cfm";<br />
4) Reload your Wheels application.<br />

<h3>EXAMPLE</h3>
<h4>== VIEW FILE ==</h4>
<p>
	styleSheetLinkTag(source='datatables/DT_bootstrapv2', head="true")<br />
	javaScriptIncludeTag("datatables/DT_bootstrap")<br />
</p>
<p>
	<span class="comment">// table name is your ACTION NAME appended with _table_id</span> <br />
	getdatatablesHTML(myActionName,myColumnNames)
</p>

<h4>== Controller (for View) ==</h4>
<p>
	In your Controller have a function called your ACTION NAME that returns a query.
</p>
<p>
	<span class="comment">// my ACTION NAME for the datatables</span> <br />
	private query function example() {
	<div style="padding-left: 15px;">
		var entries = model('entry').findAll(select='BODY,ID, TITLE')<br />
		return entries;<br />
	</div><br />
	}
</p>
<p>In your Controller under the action that will run (this case demo)</p>
<p>	
	public any function demo() {
	<div style="padding-left: 15px;">
		myActionName = 'example';<br />	
		myColumnNames = ArrayNew(1);<br />
		myColumnNames[1] = 'Body';<br />
		myColumnNames[2] = 'ID';<br />
		myColumnNames[3] = 'Title';<br />
		<br />	
		<span class="comment">// pass in controller and ACTION NAME OR</span><br />
		getdatatablesJS('datatables','example')<br />
		<br />	
		<span class="comment">// pass in controller, action name, and sort order OR </span> <br />
		getdatatablesJS('datatables','example','body desc, dateCreated desc')<br />
		<br />
		<span class="comment">// pass in controller, action name, sort order, array of user params or defaults ($dataTablesCrudParams()), and cols NOT sortable </span> <br />
		getDatatablesJS('datatables', 'example', 'id asc', $dataTablesCrudParams(delete=false), [4,5])<br />
	</div><br />
	}
	<br />
</p>

<style type="text/css">
	.comment {
		background-color: yellow;
	}
</style>
