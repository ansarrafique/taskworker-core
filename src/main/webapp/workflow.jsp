<%--


        Copyright 2013 KU Leuven Research and Development - iMinds - Distrinet

        Licensed under the Apache License, Version 2.0 (the "License");
        you may not use this file except in compliance with the License.
        You may obtain a copy of the License at

            http://www.apache.org/licenses/LICENSE-2.0

        Unless required by applicable law or agreed to in writing, software
        distributed under the License is distributed on an "AS IS" BASIS,
        WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
        See the License for the specific language governing permissions and
        limitations under the License.

        Administrative Contact: dnet-project-office@cs.kuleuven.be
        Technical Contact: bart.vanbrabant@cs.kuleuven.be

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	   <title>Workflow list</title>
	   
	   <script type="text/javascript" src="js/raphael-min.js"></script>
       <script type="text/javascript" src="js/graffle.js"></script>
       <script type="text/javascript" src="js/graph.js"></script>
	</head>
	<body>
		<h1>Workflow list</h1>
        <form action="/workflow" method="GET">
            <select name="workflowId">
                <c:forEach var="workflow" items="${workflows}">
				<option value="${workflow.workflowId}">${workflow.workflowId} - ${workflow.name}</option>
			    </c:forEach>
			</select>
			
            <input type="submit" name="submit" value="Submit">
		</form>
		
		<c:if test="${not empty workflow}">
		<h2>Workflow history for ${workflow.workflowId} - ${workflow.name}</h2>
		
        <script type="text/javascript">
<!--

	var redraw;
	var height = 600;
	var width = 1000;

	/* only do all this when document has finished loading (needed for RaphaelJS */
	window.onload = function() {
	    var g = new Graph();

        <c:forEach var="task" items="${workflow.history}">
        g.addEdge("${task.getParentTask().getId()}", "${task.getId()}");
        </c:forEach>
	
	    /* layout the graph using the Spring layout implementation */
	    var layouter = new Graph.Layout.Spring(g);
	    layouter.layout();
	    
	    /* draw the graph using the RaphaelJS draw implementation */
	    var renderer = new Graph.Renderer.Raphael('canvas', g, width, height);
	    renderer.draw();
	    
	    redraw = function() {
	        layouter.layout();
	        renderer.draw();
	    };
	};

-->     </script>
        
        <div id="canvas"></div>
        </c:if>
	</body>
</html>
