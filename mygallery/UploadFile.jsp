<%@ page import="java.util.*" %>
<html>

	<head>
		<link rel="stylesheet" href="./style.css" type="text/css"></link>
		<title>Image Uploader</title>
	</head>


	<body>
		<img src="gallery-icon.jpg" alt="Smiley face" height="120" width="120" align="left"> 
		<h1>Upload an Image</h1>
		
		<form action="UploadServlet" method="post" enctype="multipart/form-data" >
			<div>Choose your image</div>
			<input type="file" name="file" size="50" class="input" /> <br><br>
			<div>Describe your Image<br></font><textarea name="caption" id="caption"></textarea> </div><br>
			<div id="button"><input type="submit" value="Submit It!!" /></div>
			<br>
			<h1>Your Gallery !</h1>
		</form>

				<%
					String[] reply = (String [])request.getAttribute("styles");
					 out.println("<table>");
					 for(int i = 0; i < reply.length; i++) {
					   if(i % 3 == 0 && i != 0 ) {
						   out.println("<tr>");
					   }
					   out.println("<td><img id=\"cells\" src=\"./image/" + reply[i] + "\" width=\"300\" height=\"245\"><br>");
					 
					   out.println("<center><a href=\"showimage.jsp?img=" + reply[i] + "\">Edit your photo</a></center></td>");
					  
				
					 }
					 out.println("</table>");
							 
					%>


	</body>
	

</html>
