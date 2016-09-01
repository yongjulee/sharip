<%@ page contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 1L);
	
	boolean check = (Boolean)request.getAttribute("exist");
	String result = null;
	if(check == true){
		result = "1";
	} 
	else{
		result = "2";
	}
%>
<%=result%>