package test.util;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DbcpBean {
	private Connection conn;
	
	public DbcpBean() {
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
			conn = ds.getConnection();
			System.out.println("Oracle DB 접속성공");
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//Connection 객체를 리턴해 주는 메소드
	public Connection getConn() {
		return conn;
	}

}
