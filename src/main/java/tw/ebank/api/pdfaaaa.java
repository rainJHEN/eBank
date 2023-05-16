package tw.ebank.api;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;

import javax.servlet.http.HttpServlet;

import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

public class pdfaaaa  extends HttpServlet{
	
	private static final String DB_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String DB_URL = "jdbc:sqlserver://127.0.0.1:1433;databaseName=eBank;Encrypt=false;";
    private static final String DB_USERNAME = "kiki";
    private static final String DB_PASSWORD = "kiki312090";

   public static void main(String[] args) {
      Document document = new Document();
      try {
         PdfWriter.getInstance(document, new FileOutputStream("aaaa.pdf"));
         document.open();
         Paragraph paragraph = new Paragraph("Hello, World!");
         paragraph.setAlignment(Element.ALIGN_CENTER);
         document.add(paragraph);
         document.close();
         System.out.println("PDF created successfully!");
      } catch (FileNotFoundException e) {
         e.printStackTrace();
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
}
