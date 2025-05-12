package kr.or.ddit.member.controller;

import java.io.BufferedReader;
import java.io.IOException;

import jakarta.servlet.http.HttpServletRequest;

public class RequestDataChange {
	public static String changeData(HttpServletRequest req) {
		String line = "";
		StringBuffer strbuf = new StringBuffer();
		
		BufferedReader reader;
		try {
			reader = req.getReader();

			while(true) {
				line = reader.readLine();
				
				if(line == null) break;
				
				strbuf.append(line);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return strbuf.toString();
	}
}
