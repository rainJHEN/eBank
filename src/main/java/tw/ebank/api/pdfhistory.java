package tw.ebank.api;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

public class pdfhistory extends HttpServlet {
    
    private static final String DB_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String DB_URL = "jdbc:sqlserver://127.0.0.1:1433;databaseName=eBank;Encrypt=false;";
    private static final String DB_USERNAME = "kiki";
    private static final String DB_PASSWORD = "kiki312090";
    
   
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 取得資料庫連線
            Class.forName(DB_DRIVER);
            Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            

           // 建立 PDF 文件
            Document document = new Document(PageSize.A4, 50, 50, 50, 50);
            PdfWriter.getInstance(document, resp.getOutputStream());
            resp.setContentType("application/pdf");
            resp.setHeader("Content-Disposition", "attachment;filename=history.pdf");
            document.open();
            
            // 定义 SQL 查询语句
            String sql = "SELECT transTime, summary, ChangeBalanceAccount, expenses, TransferIn, Balance, transNum, transInOutAcc, other FROM ("
                    + "SELECT transOutNTRecord.transTime as transTime, '轉出' as summary, transOutNTRecord.NTAccount as ChangeBalanceAccount, transOutNTRecord.transNTAmount as expenses, null as TransferIn, transOutNTRecord.transNTBalance as Balance, transOutNTRecord.transNum as transNum, transInNTRecord.NTAccount as transInOutAcc, transOutNTRecord.other as other FROM transOutNTRecord JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum WHERE transOutNTRecord.NTAccount = '00003333' AND transOutNTRecord.transTime BETWEEN '2023-05-01' AND '2023-05-31'"
                    + ") t1 "
                    + "UNION ALL "
                    + "SELECT transTime, summary, ChangeBalanceAccount, expenses, TransferIn, Balance, transNum, transInOutAcc, other FROM ("
                    + "SELECT transInNTRecord.transTime as transTime, '轉入' as summary, transInNTRecord.NTAccount as ChangeBalanceAccount, null as expenses, transInNTRecord.transNTAmount as TransferIn, transInNTRecord.transNTBalance as Balance, transInNTRecord.transNum as transNum, transOutNTRecord.NTAccount as transInOutAcc, transInNTRecord.other as other FROM transOutNTRecord JOIN transInNTRecord ON transOutNTRecord.transNum = transInNTRecord.transNum WHERE transInNTRecord.NTAccount = '00003333'"
                    + ") t2 ORDER BY transTime";
            
            
            
            // 执行 SQL 查询，并获取查询结果集
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            // 将每一行数据写入 PDF 文件
            while (rs.next()) {
            	if(!rs.isBeforeFirst()){
            		   System.out.println("No data");
            		}else{
            			
            		
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date transTime = rs.getTimestamp("transTime");
                String summary = rs.getString("summary");
                String ChangeBalanceAccount = rs.getString("ChangeBalanceAccount");
                Integer expenses = rs.getInt("expenses");
                Integer TransferIn = rs.getInt("TransferIn");
                Integer Balance = rs.getInt("Balance");
                String transNum = rs.getString("transNum");
                String transInOutAcc = rs.getString("transInOutAcc");
                String other = rs.getString("other");

                // 将数据写入 PDF 文件
                Paragraph paragraph = new Paragraph(
                        dateFormat.format(transTime) + "\t" +
                        summary + "\t" +
                        ChangeBalanceAccount + "\t" +
                        expenses + "\t" +
                        TransferIn + "\t" +
                        Balance + "\t" +
                        transNum + "\t" +
                        transInOutAcc+ "\t" +
                        other);
                document.add(paragraph);
                System.out.println("PDF created successfully!");
            }
            }

            
            // 關閉 PDF 文件
            document.close();
            rs.close();
            stmt.close();
            conn.close();
            
        } catch (ClassNotFoundException | SQLException | DocumentException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to generate PDF");
        }
    }
    
}
    
