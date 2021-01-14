import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class HolidayApi {
public static void main(String[] args) throws IOException {
	for (int mon = 1; mon <= 12; mon++) {
		Calendar cal = Calendar.getInstance();
		String year = Integer.toString(cal.get(Calendar.YEAR));
		String month = (mon < 10) ? "0" + Integer.toString(mon) : Integer.toString(mon);

		// URL
		StringBuilder urlBuilder = new StringBuilder(
			"http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo"); /* URL */
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "="
			+ "%2FxFc4AdSit3wq68y%2Fgc7Vqzqh0EnFrZbuTtUz%2FzOYCDgEDz3fhvIqRGsgO4Ygiuri0sd%2Bwq1bJktZ1lrBYCALg%3D%3D"); /*

		urlBuilder.append(
				"&" + URLEncoder.encode("solYear", "UTF-8") + "=" + URLEncoder.encode(year, "UTF-8")); /* 년도 */
		urlBuilder.append(
			"&" + URLEncoder.encode("solMonth", "UTF-8") + "=" + URLEncoder.encode(month, "UTF-8")); /* 월 */
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Accept", "application/xml");

		// Connect
		BufferedReader rd = null;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		// save to sb
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();

		// parsing
		try {
		// DB connect settings
		Connection con = null;
		PreparedStatement pstmt = null;
		Class.forName("org.mariadb.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/goSchool", "apiUpdate", "1234");
		pstmt = con.prepareStatement("update city_301 set min1 = NULL, min2 = NULL");
		pstmt.executeQuery(); // run query
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder;
		builder = factory.newDocumentBuilder();
		InputSource is = new InputSource(new StringReader(sb.toString()));
		Document xml = builder.parse(is);
		// add Node
		NodeList list = xml.getElementsByTagName("item");

		// db insert
		for (int i = 0; list.item(i) != null; i++) {
			String dateName = null, locdate = null;
			for (Node node = list.item(i).getFirstChild(); node != null; node = node.getNextSibling()) {
				if (node.getNodeName().equals("dateName"))
					dateName = node.getTextContent();
				else if (node.getNodeName().equals("locdate")) {
					locdate = node.getTextContent();
					Date date = new SimpleDateFormat("yyyyMMdd").parse(locdate); // String to date
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // new format
					locdate = sdf.format(date); // result
				}
			}
			pstmt = con.prepareStatement("insert into holiday values  ('" +
				dateName + "', '" + locdate + "') on duplicate key update locdate = values(locdate)");
			pstmt.executeQuery(); // run query
		}
		if (pstmt != null) {
			pstmt.close();
		}
		if (con != null) {
			con.close();
		}
		// log
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date time = new Date();
		String time1 = format1.format(time);
		System.out.println(year + "/" +mon + "\tHoliday Update Success! date: " + time1);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
}
