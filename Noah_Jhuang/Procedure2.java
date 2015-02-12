import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;

public class Procedure2 {
	public static void main(String[] args) {
		
		Procedure2 pd = new Procedure2();
		pd.callable_insert("2009-12-25 13:00", 1, "A�U");
	}

	public boolean callable_insert(String ptime, int movie, String roomid) {
		// JAVA�{���� �I�s gen_seats stored procedure(�s�W)���w�������q�v�y���� �� seats���
		final String URL = "jdbc:sqlserver://localhost:1433;databaseName = northwind";
		final String USER = "sa";
		final String PASSWORD = "passw0rd";
		
		String sql = "{call gen_seats(?, ?, ?)}";
		boolean result = true;
		try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
				CallableStatement cstmt = conn.prepareCall(sql);) {

			// �I�s JDBC ��J'2009-12-25 13:00', 1, 'A�U' �� playlists ���

			cstmt.setString(1, ptime);
			cstmt.setInt(2, movie);
			cstmt.setString(3, roomid);
			result = cstmt.execute();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (!result) { // �^�ǭȬ�false�O���\,true�O����
			System.out.println("����gen_seats�w�s�{�Ǧ��\!");
		} else {
			System.out.println("����gen_seats�w�s�{�ǥ���...");
		}
		return result;
	}

}