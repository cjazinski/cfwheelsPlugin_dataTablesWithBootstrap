<cfcomponent output="false" mixin="controller">

	 <cffunction name="init">
		<cfset this.version = "1.1.8">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getdatatablesJS">
		<cfargument name="myController" type="string" required="true" />
		<cfargument name="myAction" type="string" required="true" />
		<cfargument name="sIndexColumn" type="string" default="1" />
		<cfargument name="cParams" type="array" default="" required="false" />
		<cfargument name="dSort" type="array" default="" required="false" />
				
		<cfset var myActionID = "#arguments.myAction#_table_id" />
		<cfset var datasorter_js = "" />
		
		<cfsavecontent variable="datasorter_js">
			<cfoutput>
			#javaScriptIncludeTag("datatables/jQuery.dataTables.min")#
			</cfoutput>
			<script type="text/javascript" charset="utf-8">
				$(document).ready(function() {
					$('#<cfoutput>#myActionID#</cfoutput>').dataTable( {
						"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
						"sPaginationType": "bootstrap",
						"oLanguage": {
							"sLengthMenu": "_MENU_ tickets per page"
						},
						//disable columns sort
						"aoColumnDefs": [
							{ "bSortable": false, "aTargets": [
							<cfset ctr = arrayLen(arguments.dSort) />
							<cfoutput>
								<cfloop array="#arguments.dSort#" index="i">
									<cfset ctr = ctr - 1 />
									#i#
									<cfif ctr NEQ 0>,</cfif>
								</cfloop>
							</cfoutput>
							] }
						],
						//for iDevices
						"fnCreatedRow": function(nRow, aData, iDataIndex) {
							nRow.setAttribute("onclick",function() {});	
						},
						"fnServerData": function(sSource, aoData, fnCallback) {
							aoData.push(
								<cfif arrayLen(arguments.cParams) GT 0>
								<cfset ctr = arrayLen(arguments.cParams) />
								<cfoutput>
									<cfloop array="#arguments.cParams#" index="cIndex">
									<cfset ctr = ctr - 1 />
									{"name": "#cIndex.name#" , "value":
										<cfif isBoolean(cIndex.value)>
											#cIndex.value#}
										<cfelse>
											"#cIndex.value#"}
										</cfif>
									<cfif ctr NEQ 0 >,</cfif>	
									</cfloop>
								</cfoutput>
								</cfif>
							);
							$.getJSON(sSource, aoData, function (json) {
								fnCallback(json);
							});
						},					
						"bProcessing": true,
						"bServerSide": true,
						"bStateSave": false,
						"sAjaxSource": "<cfoutput>#URLFor(controller=arguments.myController,action="dataTablesprocessing",params="qFunctionName=#arguments.myAction#&sIndexColumn=#arguments.sIndexColumn#")#</cfoutput>"
					} );
				} );
			</script>
		</cfsavecontent>		
		<cfhtmlhead text = "#datasorter_js#">
	</cffunction>
	
	<cffunction name="getdatatablesHTML">
		<cfargument name="myAction" type="string" required="true" />
		<cfargument name="myColumnNamesArray" type="array"  required="true" />
		<cfargument name="style" type="string" required="false" default="table table-striped table-bordered display dataTable" />
		<cfargument name="showFooter" type="boolean" required="false" default="false" />
		
		<cfset var myActionID = "#arguments.myAction#_table_id" />
		<cfset var datasorter_html = "" />
		<cfset var myColumnName = "" />
		
		<cfsavecontent variable="datasorter_html">
			<table cellpadding="0" cellspacing="0" border="0" class="<cfoutput>#arguments.style#</cfoutput>" id="<cfoutput>#myActionID#</cfoutput>">
				<thead>
					<tr>
						<cfloop index="myColumnName" array="#myColumnNamesArray#">
						   <cfoutput><th>#myColumnName#</th></cfoutput>
						</cfloop>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="4" class="dataTables_empty">Loading data from server</td>
					</tr>
				</tbody>
				<cfif arguments.showFooter>
					<tfoot>
						<tr>
							<cfloop index="myColumnName" array="#myColumnNamesArray#">
							   <cfoutput><th>#myColumnName#</th></cfoutput>
							</cfloop>
						</tr>
					</tfoot>
			    </cfif>
			</table>
		</cfsavecontent>
		
		<cfreturn datasorter_html />
	</cffunction>
	
	<cffunction name="$dataTablesCrudParams" returntype="array" access="public" >
		<cfargument name="delete" required="false" default="true" />
		<cfargument name="edit" required="false" default="true" />
		<cfargument name="details" required="false" default="true" />
		
		<cfscript>
			var loc = {};
			loc.defParams = arrayNew(1);
			var showDel = structNew();
			var showDetails = structNew();
			var showEdit = structNew();
			showDel.name = 'cShowDelete';
			showDel.value = arguments.delete;
			arrayAppend(loc.defParams, showDel);
			showDetails.name = 'cShowDetails';
			showDetails.value = arguments.details;
			arrayAppend(loc.defParams, showDetails);
			showEdit.name = 'cShowEdit';
			showEdit.value = arguments.edit;
			arrayAppend(loc.defParams, showEdit);
			
			return loc.defParams;
		
		</cfscript>
	</cffunction>
	
</cfcomponent>