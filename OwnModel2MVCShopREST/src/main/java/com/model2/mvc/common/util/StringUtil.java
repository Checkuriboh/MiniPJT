package com.model2.mvc.common.util;

import java.sql.Date;
import java.text.SimpleDateFormat;


public class StringUtil {
	
	///Field
	
	///Constructor
	
	///Method
	
	public static String toDateStr(Date date, int len) 
	{
		if (date == null) {
			return "";
		}
		else {
			return StringUtil.toDateStr(date.toString(), len);
		}
	}
	
	public static String toDateStr(String dateStr, int len)
	{		
		if ( dateStr == null || dateStr.isEmpty() ) {
			return "";
		}
		
		if (dateStr.length() == len) {
			return dateStr;
		}
		else if (dateStr.length() > 10) {
			return toDateStr(dateStr.substring(0, 10), len);
		}
		else if (dateStr.length() == 10 && len == 8) {
			return dateStr.substring(0, 4) + dateStr.substring(5, 7) + dateStr.substring(8, 10);
		}
		else if (dateStr.length() == 8 && len == 10) {
			return dateStr.substring(0, 4) + "-" + dateStr.substring(4, 6) + "-" + dateStr.substring(6, 8);
		}
		else {
			return dateStr + " (" + len + ")";
		}
	}
	
	public static Date toStrDate(String dateStr)
	{
		if (dateStr == null) {
			return null;
		}
		else {
			String date = StringUtil.toDateStr(dateStr, 10);
			return Date.valueOf(date);
		}
	}
	
	public static String trim(String str)
	{
		if (str == null) {
			return null;
		}
		else {
			return str.trim();
		}
	}
	
}
