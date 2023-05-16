//import java.io.ByteArrayOutputStream;
//import java.io.IOException;
//import java.time.LocalDateTime;
//import java.time.format.DateTimeFormatter;
//import java.util.List;
//
//import javax.servlet.http.HttpServletResponse;
//
//import com.itextpdf.io.font.FontConstants;
//import com.itextpdf.kernel.color.Color;
//import com.itextpdf.kernel.font.PdfFont;
//import com.itextpdf.kernel.font.PdfFontFactory;
//import com.itextpdf.kernel.pdf.PdfDocument;
//import com.itextpdf.kernel.pdf.PdfWriter;
//import com.itextpdf.layout.Document;
//import com.itextpdf.layout.border.SolidBorder;
//import com.itextpdf.layout.element.Cell;
//import com.itextpdf.layout.element.Table;
//import com.itextpdf.layout.element.Text;
//import com.itextpdf.layout.property.TextAlignment;
//import com.itextpdf.layout.property.UnitValue;
//
//import tw.ebank.model.Transaction;
//
public class PdfTradeController {}
//
//    public void downloadTradeReport(HttpServletResponse response, List<Transaction> transactions) throws IOException {
//        // 設定標頭，告知瀏覽器下載為 PDF 檔案
//        response.setHeader("Content-Disposition", "attachment; filename=\"trade-report.pdf\"");
//        response.setContentType("application/pdf");
//
//        // 建立 PdfWriter 和 Document 物件
//        ByteArrayOutputStream baos = new ByteArrayOutputStream();
//        PdfWriter writer = new PdfWriter(baos);
//        PdfDocument pdfDoc = new PdfDocument(writer);
//        Document doc = new Document(pdfDoc);
//
//        // 建立表格
//        Table table = new Table(new UnitValue[] { new UnitValue(UnitValue.PERCENT, 20), new UnitValue(UnitValue.PERCENT, 40),
//                new UnitValue(UnitValue.PERCENT, 20), new UnitValue(UnitValue.PERCENT, 20) });
//        table.setWidth(UnitValue.createPercentValue(100));
//
//        // 設定表格標題
//        PdfFont font = PdfFontFactory.createFont(FontConstants.HELVETICA_BOLD);
//        Text title = new Text("交易報表").setFont(font).setFontSize(16);
//        doc.add(title).add(new Text("\n\n"));
//
//        // 建立表格表頭
//        Cell cell = new Cell().add(new Text("交易日期")).setBold().setBackgroundColor(Color.LIGHT_GRAY)
//                .setBorder(new SolidBorder(Color.BLACK, 1));
//        table.addCell(cell);
//        cell = new Cell().add(new Text("交易摘要")).setBold().setBackgroundColor(Color.LIGHT_GRAY)
//                .setBorder(new SolidBorder(Color.BLACK, 1));
//        table.addCell(cell);
//        cell = new Cell().add(new Text("交易金額")).setBold().setBackgroundColor(Color.LIGHT_GRAY)
//                .setBorder(new SolidBorder(Color.BLACK, 1));
//        table.addCell(cell);
//        cell = new Cell().add(new Text("交易餘額")).setBold().setBackgroundColor(Color.LIGHT_GRAY)
//                .setBorder(new SolidBorder(Color.BLACK, 1));
//        table.addCell(cell);
//
//        // 填入表格資料
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
//        double balance = 0.0;
//        for (Transaction t : transactions) {
//            table.addCell(t.getTradeTime().format(formatter));
//            table.addCell(t.getSummary());
//            table.addCell(String.valueOf(t.getAmount()));
//            balance += t.getAmount();
//            table.addCell(String.valueOf(balance));
//        }
//
//        // 加入表格到文件中
//        doc.add(table);
//
//        // 
