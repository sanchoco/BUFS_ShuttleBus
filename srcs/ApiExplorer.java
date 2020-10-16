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
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;


public class ApiExplorer {
    public static void main(String[] args) throws IOException {

    	//URL
        StringBuilder urlBuilder = new StringBuilder("http://61.43.246.153/openapi-data/service/busanBIMS2/stopArr"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + "%2FxFc4AdSit3wq68y%2Fgc7Vqzqh0EnFrZbuTtUz%2FzOYCDgEDz3fhvIqRGsgO4Ygiuri0sd%2Bwq1bJktZ1lrBYCALg%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("5", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("bstopid","UTF-8") + "=" + URLEncoder.encode("506480000", "UTF-8")); /*정류소 명*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/xml");
        //System.out.println(urlBuilder.toString());

        //Connect
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd = null;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }

		//save to sb
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();


        //System.out.println(sb);

        //parsing
		try {

	        //DB connect settings
	        Connection con = null;
	        PreparedStatement pstmt = null;
            Class.forName("org.mariadb.jdbc.Driver");

            con = DriverManager.getConnection(
                    "jdbc:mariadb://127.0.0.1:3306/goSchool",
                    "apiUpdate",
                    "1234");

			pstmt = con.prepareStatement("update city_301 set min1 = NULL, min2 = NULL");
            pstmt.executeQuery(); //run query

	        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	        DocumentBuilder builder;
			builder = factory.newDocumentBuilder();
	        InputSource is = new InputSource(new StringReader(sb.toString()));
	        Document xml = builder.parse(is);
	        //add Node
	        NodeList list = xml.getElementsByTagName("item");

	        //nopo = 62, guseo = 10;
	        for (int i = 0; i < 2; i++) {
	        	int idx = 0, min1 = -1, min2 = -1;
		        for(Node node= list.item(i).getFirstChild() ; node !=null ; node=node.getNextSibling()) {
		            if(node.getNodeName().equals("bstopIdx"))
		                  idx = Integer.parseInt(node.getTextContent());
		            else if(node.getNodeName().equals("min1"))
		                  min1 = Integer.parseInt(node.getTextContent());
		            else if(node.getNodeName().equals("min2"))
		                  min2 = Integer.parseInt(node.getTextContent());
		        }
		        pstmt = con.prepareStatement("update city_301 set min1=" 
		        		+ (min1!=-1?min1:"NULL") + ", min2 =" + (min2!=-1?min2:"NULL") + " where idx=" + idx);
		        //System.out.println(pstmt);
                pstmt.executeQuery(); //run query
	        }
            if(pstmt != null) {
                pstmt.close(); // 선택사항이지만 호출 추천
            }

            if(con != null) {
                con.close(); // 필수 사항
            }
           //log
           SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
           Date time = new Date();
           String time1 = format1.format(time);
	       System.out.println("Success! " + time1);

		} catch (Exception e) {
			e.printStackTrace();
		}
    }
}
