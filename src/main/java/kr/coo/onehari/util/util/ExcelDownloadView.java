package kr.coo.onehari.util.util;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.web.servlet.view.AbstractView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ExcelDownloadView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		Locale locale = (Locale) model.get("locale");
		String workbookName = (String) model.get("workbookName");
		
		// 파일 이름 중복방지를 위해 파일 이름에 시간 추가
		Date date = new Date();
		SimpleDateFormat dayformat = new SimpleDateFormat("yyyyMMdd", locale);
		SimpleDateFormat hourformat = new SimpleDateFormat("hhmmss", locale);
		String day = dayformat.format(date);
		String hour = hourformat.format(date);
		String fileName = workbookName + "_" + day + "_" + hour + ".xlsx";
		
		// 브라우저에 따른 파일 이름 인코딩
        String browser = request.getHeader("User-Agent");
        if (browser.indexOf("MSIE") > -1) {
            fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
        } else if (browser.indexOf("Trident") > -1) {       // IE11
            fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
        } else if (browser.indexOf("Firefox") > -1) {
            fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.indexOf("Opera") > -1) {
            fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.indexOf("Chrome") > -1) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < fileName.length(); i++) {
               char c = fileName.charAt(i);
               if (c > '~') {
                     sb.append(URLEncoder.encode("" + c, "UTF-8"));
                       } else {
                             sb.append(c);
                       }
                }
                fileName = sb.toString();
        } else if (browser.indexOf("Safari") > -1){
            fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1")+ "\"";
        } else {
             fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1")+ "\"";
        }
        
        response.setContentType("application/download;charset=utf-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        
        OutputStream os = null;
        SXSSFWorkbook workbook = null;
        
        try {
        	workbook = (SXSSFWorkbook) model.get("workbook");
        	os = response.getOutputStream();
        	
        	// 파일생성
        	workbook.write(os);
        } catch (Exception e) {
			System.out.println("ExcelDownloadView 예외발생: " + e.getMessage());
			log.debug("ExcelDownloadView 예외발생: " + e.getMessage());
		} finally {
			if (workbook != null) {
				try {
					workbook.close();
				} catch (Exception e) {
					System.out.println("ExcelDownloadView workbook 예외발생: " + e.getMessage());
					log.debug("ExcelDownloadView workbook 예외발생: " + e.getMessage());
				}
			}
			
			if (os != null) {
				try {
					os.close();
				} catch (Exception e) {
					System.out.println("ExcelDownloadView os 예외발생: " + e.getMessage());
					log.debug("ExcelDownloadView os 예외발생: " + e.getMessage());
				}
			}
		}
	}
}