package tw.ebank.api;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.GrayColor;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;




public class pdftrade{
	
	private final static String USER = "kiki"; 
	private final static String PASSWORD = "kiki312090";
	private final static String URL = "jdbc:sqlserver://127.0.0.1:1433;databaseName=eBanktest;Encrypt=false;";
	public byte[] generatePDF() throws DocumentException, IOException {
//	public static void main(String[] args) {
	    Document document = new Document();
	    try { 
	    	
	    	ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
	        //檔案名子
	        PdfWriter.getInstance(document, outputStream);
	        //浮水印
	        PdfWriter writer = PdfWriter.getInstance(document, outputStream);
            writer.setEncryption(null, null, PdfWriter.ALLOW_PRINTING, PdfWriter.STANDARD_ENCRYPTION_128);
            writer.setPageEvent(new Watermark("eBank"));
            
            
            
            document.open();
	        
	        //我這邊先寫sql 參考key04
	        String sql = "SELECT transNum, NTAccount, CAST(REPLACE(transNTAmount, ',', '') AS INT) AS transNTAmount, transTime, CAST(REPLACE(transNTBalance, ',', '') AS INT) AS transNTBalance, other\r\n"
	        		+ "FROM transInNTRecord\r\n"
	        		+ "WHERE NTAccount = '047182546793'\r\n"
	        		+ "UNION ALL\r\n"
	        		+ "SELECT transNum, NTAccount, CAST(REPLACE(transNTAmount, ',', '') AS INT) AS transNTAmount, transTime, CAST(REPLACE(transNTBalance, ',', '') AS INT) AS transNTBalance, other\r\n"
	        		+ "FROM transOutNTRecord\r\n"
	        		+ "WHERE NTAccount = '047182546793'\r\n"
	        		+ "ORDER BY transTime DESC, transNum DESC";
	        Properties prop = new Properties();
	        prop.put("user", USER); prop.put("password", PASSWORD);
	        try {
	            Connection conn = DriverManager.getConnection(URL, prop);
	            PreparedStatement pstmt = conn.prepareStatement(sql);
	            ResultSet rs = pstmt.executeQuery();
	            
	         // 建立表格
	            PdfPTable table = new PdfPTable(5); // 5欄
	            table.setWidthPercentage(100); // 設定表格寬度為100%
	            PdfPCell cell = new PdfPCell(); // 建立儲存格
	            cell.setBackgroundColor(BaseColor.LIGHT_GRAY); // 設定背景顏色
	            cell.setPadding(5); // 設定內距
	            
	            Font font = FontFactory.getFont("標楷體", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
	            cell.setPhrase(new Phrase("transaction schedule", font)); // 建立儲存格內容
	            cell.setColspan(5); // 設定儲存格合併
	            table.addCell(cell); // 加入表格
	            
	            // 加入表頭
	            table.addCell(new PdfPCell(new Phrase("transNum", font)));
	            table.addCell(new PdfPCell(new Phrase("NTAccount", font)));
	            table.addCell(new PdfPCell(new Phrase("transNTAmount", font)));
	            table.addCell(new PdfPCell(new Phrase("transTime", font)));
	            table.addCell(new PdfPCell(new Phrase("Balance", font)));
	            
	            
	            
	            
	            // 加入資料列
	            while (rs.next()) {
	                int transNum = rs.getInt("transNum");
	                String NTAccount = rs.getString("NTAccount");
	                double transNTAmount = rs.getDouble("transNTAmount");
	                Date transTime = rs.getDate("transTime");
	                double transNTBalance = rs.getDouble("transNTBalance");

	                
	           
	                // 加入儲存格
	                table.addCell(new PdfPCell(new Phrase(String.valueOf(transNum))));
	                table.addCell(new PdfPCell(new Phrase(NTAccount)));
	                table.addCell(new PdfPCell(new Phrase(String.valueOf(transNTAmount))));
	                table.addCell(new PdfPCell(new Phrase(transTime.toString())));
	                table.addCell(new PdfPCell(new Phrase(String.valueOf(transNTBalance))));
//	                table.addCell(new PdfPCell(new Phrase(other)));
	            }
	            
	            
	            
	            // 加入表格到文件中
	            
	            document.add(table);
	            document.close();
	    		return outputStream.toByteArray();
//	            System.out.println("PDF created successfully!");
	            
	        }catch (Exception e) {
	            System.out.println(e);
	        }
	        System.out.println(document);

	    } catch (Exception e) {
	        e.printStackTrace();
	    } 
//		return outputStream.toByteArray();
		return null;
	    
	}
}
	    
//	}
	
//	}

//浮水印的class
class Watermark extends PdfPageEventHelper {
    private static final Font FONT = new Font(Font.FontFamily.HELVETICA, 52, Font.BOLD, new GrayColor(0.95f));
    private final Phrase watermarkText;

    public Watermark(String watermarkText) {
        this.watermarkText = new Phrase(watermarkText, FONT);
    }

    @Override
    public void onEndPage(PdfWriter writer, Document document) {
        PdfContentByte canvas = writer.getDirectContentUnder();
        ColumnText.showTextAligned(canvas, Element.ALIGN_CENTER, watermarkText, 298, 421, 45);
    }

}

    
    
//public class PDFGenerator {
//	  
//	  public byte[] generatePDF() throws DocumentException, IOException {
//	    Document document = new Document();
//	    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
//	    PdfWriter.getInstance(document, outputStream);
//	    document.open();
//	    document.add(new Paragraph("This is my PDF document."));
//	    document.close();
//	    return outputStream.toByteArray();
//	  }
//	}

