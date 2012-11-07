<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,java.io.*,javax.xml.transform.dom.DOMSource,javax.xml.transform.stream.StreamResult,javax.xml.parsers.ParserConfigurationException" %>



<html>
	<head>
		<link rel="stylesheet" href="./style.css" type="text/css"></link>
		<title>Edit Image</title>
	</head>

	<body>

 
		<h1>Your Image</h1>
		<hr align="center" width="60%">

		<%
		String img = request.getParameter("img");
		%>

		<%
		try{
			String img2 = img.substring(0,img.length()-4);
			String XmlPath = "./xmlFolder/"+img2+".xml";
			String path = "/usr/share/tomcat6/webapps/mygallery/xmlFolder/"+ img2 + ".xml";
			
		%>

		<%
		String height = getXMLValue("Height",path);
		String width = getXMLValue("Width",path);
		String rotation = getXMLValue("Rotation",path);
		 
		if(request.getParameter	("width")!=null){

			width = request.getParameter("width");
		
		}

		if(request.getParameter	("height")!=null){

			height = request.getParameter("height");

		}


		if(request.getParameter("rotation")!=null){

			rotation = request.getParameter("rotation");

		}

		%>
		<%!

		Document doc;

		String getXMLValue(String name, String path) {

		try{

			File fXmlFile = new File(path);
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nlist=doc.getElementsByTagName(name);
			String value = nlist.item(0).getFirstChild().getNodeValue();
			return value;

		}

		catch(Exception e){ 
			e.printStackTrace();
		}

		return null;
		}


		void setXMLValue(String s,String name, String path){

		try{

		File fXmlFile = new File(path);
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		doc = dBuilder.parse(fXmlFile);
		doc.getDocumentElement().normalize();
		NodeList nlist=doc.getElementsByTagName(name);
		nlist.item(0).getFirstChild().setNodeValue(s);
		TransformerFactory transformerFactory = TransformerFactory.newInstance();
		Transformer transformer = transformerFactory.newTransformer();
		DOMSource source = new DOMSource(doc);
		StreamResult result = new StreamResult(path);
		transformer.transform(source, result);

		return;
		}
		catch(Exception e){ 
		e.printStackTrace();
		}

		}


		%>
		<%
		String appPath = application.getRealPath("/");
		DocumentBuilderFactory dbf=DocumentBuilderFactory.newInstance();
		DocumentBuilder db=dbf.newDocumentBuilder();
		doc=db.parse(appPath + XmlPath);
		String Desc= getXMLValue("Description",path);
		%>


		<img src='./image/<%= img %>' height="<%=height%>px" width="<%=width%>px" style="transform: rotate(<%=rotation%>deg);
		   -moz-transform: rotate(<%=rotation%>deg);
		   -webkit-transform: rotate(<%=rotation%>deg);" />
		   
		   
		   

		<hr align="center" width="60%">
		<h4>Image Name: <%= img2%></h4>
		<h4>Description:</h4><%= Desc%>
		<h3>Edit Image</h3>
		<form action="showimage.jsp" method="GET">

		Height: <input name="height" type="text" value="<%=height%>" size="25"/>	
		<br/>
		Width: <input name="width" type="text" value="<%=width%>" size="25"/>
		<br/>
		<input name="img" type="hidden" value="<%=img%>"/>
		Rotation: <input name="rotation" type="text" value="<%=rotation%>" size="20" />
		<br/>
		<input type="submit" value="Change dimesion"/>


		</form>
		   

		<%
		setXMLValue(height,"Height",path);
		setXMLValue(width,"Width",path);
		setXMLValue(rotation,"Rotation",path);
		%>
		

		<%
		}catch(Exception e){

		}%>

		<li><a href="./imgupload">Return to the Image Gallery</a></li>   


 
 
	</body>

</html>
