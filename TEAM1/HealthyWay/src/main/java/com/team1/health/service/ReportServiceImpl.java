package com.team1.health.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team1.health.dao.ReportDAO;
import com.team1.health.vo.ReportVO;

@Service
public class ReportServiceImpl implements ReportService {
	@Inject
	ReportDAO dao;

	@Override
	public int reportInsert(ReportVO vo) {
		return dao.reportInsert(vo);
	}

	@Override
	public int userReportCount(String user) {
		return dao.userReportCount(user);
	}
	
}
