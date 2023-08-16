package com.team1.health.service;

import com.team1.health.vo.ReportVO;

public interface ReportService {
	public int reportInsert(ReportVO vo);
	public int userReportCount(String user);
}
