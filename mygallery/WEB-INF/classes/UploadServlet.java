import java.io.*;
import java.util.*;
 
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.output.*;

public class UploadServlet extends HttpServlet {
   
   private boolean isMultipart;
   private String filePath;
   private int maxFileSize = 5000 * 1024;
   private int maxMemSize = 400 * 1024;
   private File file ;
   private String filenamep;


   public void init( ){
      // Get the file location where it would be stored.
      filePath = getServletContext().getInitParameter("file-upload");
 
   }
   public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
      // Check that we have a file upload request
      isMultipart = ServletFileUpload.isMultipartContent(request);
      response.setContentType("text/html");
	  String caption = "";


	  
      java.io.PrintWriter out = response.getWriter( );
      if( !isMultipart ){
         out.println("<html>");
         out.println("<head>");
         out.println("<title>Servlet upload</title>");  
         out.println("</head>");
         out.println("<body>");
         out.println("<p>No file uploaded</p>"); 
         out.println("</body>");
         out.println("</html>");
         return;
      }
      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
	 
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("/usr/share/tomcat6/webapps/mygallery/image/"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
	

      try{ 
      // Parse the request to get file items.
      List fileItems = upload.parseRequest(request);
	
      // Process the uploaded file items
      Iterator i = fileItems.iterator();

      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      while ( i.hasNext () ) 
      {
        
         FileItem fi = (FileItem)i.next();
         if ( !fi.isFormField () )	
         {
            // Get the uploaded file parameters
            String fieldName = fi.getFieldName();
            String fileName = fi.getName();
            String contentType = fi.getContentType();
            boolean isInMemory = fi.isInMemory();
            long sizeInBytes = fi.getSize();
	       
            // Write the file
            if( fileName.lastIndexOf("/") >= 0 ){
               file = new File( filePath + 
               fileName.substring( fileName.lastIndexOf("/"))) ;
		
            }else{
               file = new File( filePath + 
               fileName.substring(fileName.lastIndexOf("/")+1)) ;
			
            }
			
			if(fileName.substring(fileName.lastIndexOf(".") + 1).equalsIgnoreCase("bmp") || fileName.substring(fileName.lastIndexOf(".") + 1).equalsIgnoreCase("jpg") || fileName.substring(fileName.lastIndexOf(".") + 1).equalsIgnoreCase("jpeg") || fileName.substring(fileName.lastIndexOf(".") + 1).equalsIgnoreCase("png") || fileName.substring(fileName.lastIndexOf(".") + 1).equalsIgnoreCase("gif") || fileName.substring(fileName.lastIndexOf(".") + 1).equalsIgnoreCase("gif")) {
                filenamep= fileName; 
                fi.write( file ) ;   
            }
         }
		 
		 else {

             if(fi.getFieldName().equals("caption")) {
                 caption = fi.getString();
             }
       
             
             PrintWriter out_xml = new PrintWriter("/usr/share/tomcat6/webapps/mygallery/xmlFolder/" + filenamep.replaceFirst("[.][^.]+$", "") + ".xml");
	         out_xml.println("<Image>\n<Description>" + caption + "</Description>\n<Width> 300 </Width>\n<Height> 245 </Height>\n<Rotation>0</Rotation>\n</Image>");
	         out_xml.close();
		}
		 
      }
	  
	out.println("<center>Done!</center>");
	out.println("<li><center><a href=\"./imgupload\">Back</a><center></li>");
	  
	  
	  
   }catch(Exception ex) {
       System.out.println(ex);
   }
   }
   public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
		
		response.setContentType("text/html");
       
        String[] answer;
       
        File folder = new File("/usr/share/tomcat6/webapps/mygallery/image/");
        File[] listOfFiles = folder.listFiles(); 
        
        answer = new String[listOfFiles.length];
        
        for(int i = 0; i < answer.length; i++) {
            answer[i] = listOfFiles[i].getName();
        }
       
        request.setAttribute("styles", answer);
        RequestDispatcher view = request.getRequestDispatcher("UploadFile.jsp");
        
        try {    
            view.forward(request, response);
        } 
        catch (ServletException ex) {} 
        catch (IOException ex) {} 
		
   } 
}

