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
<%@page import="drm.taskworker.tasks.AbstractTask"%>
<%@page import="java.util.List"%>
<%@page import="drm.taskworker.tasks.Task"%>
<%@page import="drm.taskworker.monitoring.Monitor"%>
<%@page import="drm.taskworker.monitoring.IMonitor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    IMonitor mon = new Monitor();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	   <title>Monitor</title>
	</head>
	<body>
	    <%=mon.getStats()%>
	</body>
</html>