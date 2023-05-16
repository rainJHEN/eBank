package tw.ebank.rain;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.DocumentException;

import tw.ebank.api.pdftrade;


@WebServlet("/pdftrade")
public class PdfTradeServlet extends HttpServlet {
	
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"pdftrade.pdf\"");
        
        pdftrade pdftrade = new pdftrade();
        byte[] pdfBytes = null;
		try {
			pdfBytes = pdftrade.generatePDF();
		} catch (DocumentException | IOException e) {
			e.printStackTrace();
		}
        
        // Write PDF bytes to response output stream
        InputStream inputStream = new ByteArrayInputStream(pdfBytes);
        OutputStream outputStream = response.getOutputStream();
        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
          outputStream.write(buffer, 0, bytesRead);
        }
        outputStream.flush();
        inputStream.close();
        outputStream.close();
      }
    }
   