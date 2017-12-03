<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.util.*, java.io.*, javax.servlet.*, com.oreilly.servlet.MultipartRequest, 
	com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
String realFolder="";

String saveFolder="fileRepository";
String encType="euc-kr";
int maxSize = 5*1024*1024; //maximum filesize 5MB

ServletContext context = getServletContext();
realFolder = context.getRealPath(saveFolder);
System.out.println(realFolder);
try {
	MultipartRequest multi = null;
	
	multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	Enumeration<?> params = multi.getParameterNames();
	while(params.hasMoreElements()) {
		String name=(String) params.nextElement();
		String value=multi.getParameter(name);
		out.println(name +" = "+value +"<Br/>");
	}
	
	Enumeration<?> files = multi.getFileNames();
	while(files.hasMoreElements()) {
		String name=(String)files.nextElement();
		String filename = multi.getFilesystemName(name);
		String original = multi.getOriginalFileName(name);
		String type = multi.getContentType(name);
		File file = multi.getFile(name);
		
		out.println("파라미터 이름: "+name +"<Br/>");
		out.println("실제 파일 이름: "+original +"<Br/>");
		out.println("저장된 이름: "+filename +"<Br/>");
		out.println("파일 이름: "+type +"<Br/>");
		
		if(file != null) {
			out.println("크기: "+file.length() +"<Br/>");
		}
		out.println("<img src='fileRepository/" + filename + "'>");
	}
}catch(IOException ioe) {
	System.out.println(ioe);
}catch(Exception e) {
	System.out.println(e);
}
%>
</body>
</html>