package com.team1.health.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team1.health.vo.ReportVO;

@Mapper
@Repository
public interface ReportDAO {
	public int reportInsert(ReportVO vo);
	public int userReportCount(String user);
}
