package kr.coo.onehari.my.service;

import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.coo.onehari.hr.dto.EmpDto;
import kr.coo.onehari.login.dao.LoginDao;
import kr.coo.onehari.my.dao.MyDao;
import kr.coo.onehari.my.dto.Theme;
import lombok.extern.slf4j.Slf4j;

/*
작성자: 오형남
시작: 2020. 1. 10
완료: 
내용: 사원(개인)관련 서비스
*/
//전자결재 폼 service
@Slf4j
@Service
public class MyService {

	@Autowired
	private SqlSession sqlsession;

	// 형남 0110 로그인 성공 시 로그인 횟수 초기화
	public int loginCntInit(String str) {
		System.out.println("str: " + str);
		int result = 0;

		LoginDao dao = sqlsession.getMapper(LoginDao.class);
		try {
			int empNum = Integer.parseInt(str);
			result = dao.loginCntInit(empNum);
		} catch (ClassNotFoundException | SQLException e) {
			log.debug("loginCntInit : " + e.getMessage());
		}
		return result;
	}

	// 형남 0110 로그인 실패, 로그인 시도횟수 증가
	public void countFailure(String str) {
		LoginDao dao = sqlsession.getMapper(LoginDao.class);
		int result = 0;
		int empNum = Integer.parseInt(str);
		try {
			result = dao.updateFailureCount(empNum);
			if (result > 0) {
				System.out.println("로그인 실패, 로그인 시도횟수 증가 업데이트 성공");
			} else {
				System.out.println("로그인 실패, 로그인 시도횟수 증가 업데이트 성공");
			}
		} catch (ClassNotFoundException | SQLException e) {
			log.debug("countFailure : " + e.getMessage());
		}
	}

	// 형남 0110 현재 로그인 시도 횟수
	public int checkFailureCount(String str) {
		int result = 0;
		int empNum = Integer.parseInt(str);
		LoginDao dao = sqlsession.getMapper(LoginDao.class);
		try {
			result = dao.checkFailureCount(empNum);
		} catch (ClassNotFoundException | SQLException e) {
			log.debug("loginCntInit : " + e.getMessage());
		}
		return result;
	}

	// 형남 0110 로그인 잠금처리
	public void disabledUsername(String str) {
		int result = 0;
		int empNum = Integer.parseInt(str);
		LoginDao dao = sqlsession.getMapper(LoginDao.class);
		try {
			result = dao.disabledUsername(empNum);
			if (result > 0) {
				System.out.println("로그인 잠금처리 업데이트 성공");
			} else {
				System.out.println("로그인 잠금처리 업데이트 성공");
			}
		} catch (ClassNotFoundException | SQLException e) {
			log.debug("loginCntInit : " + e.getMessage());
		}
	}

	// 형남 0110 비밀번호 초기화, 변경
	public int updatePassword(String empNumStr, String password) {
		MyDao dao = sqlsession.getMapper(MyDao.class);
		int result = 0;
		int empNum = Integer.parseInt(empNumStr);
		try {
			result = dao.updatePassword(empNum, password);
			if (result > 0) {
				System.out.println("비밀번호 변경 성공");
			} else {
				System.out.println("비밀번호 변경 실패");
			}
		} catch (ClassNotFoundException | SQLException e) {
			log.debug("updatePassword : " + e.getMessage());
		}
		return result;
	}

	// 김진호 2020. 1. 21 개인정보 프로필 수정(변경)
	@Transactional
	public int updateEmpMyInfo(EmpDto empdto) throws Exception {
		MyDao mydao = sqlsession.getMapper(MyDao.class);
		int result = 0;

		try {
			result = mydao.updateEmpMyInfo(empdto);
			result = mydao.updateSubempMyInfo(empdto);
		} catch (ClassNotFoundException | SQLException e) {
			log.debug("MyService myInfo 예외발생: " + e.getMessage());
			throw e;
		}
		return result;
	}

	// 오형남 2020. 1. 16 (color) / 김정하 2020. 1. 21 (file) 개인테마 가져오기
	public Theme getMyTheme(String empNum) {
		MyDao mydao = sqlsession.getMapper(MyDao.class);
		Theme theme = null;
		try {
			theme = mydao.getMyTheme(empNum);
		} catch (ClassNotFoundException | SQLException e) {
			log.debug("MyService getMyTheme 예외발생: " + e.getMessage());
		}
		return theme;
	}

	// 오형남 2020. 1. 16 (color) / 김정하 2020. 1. 21 (file) 개인테마 설정
	public int setMyTheme(Theme theme) {
		MyDao mydao = sqlsession.getMapper(MyDao.class);
		int result = 0;
		try {
			result = mydao.setMyTheme(theme);
		} catch (ClassNotFoundException | SQLException e) {
			log.debug("MyService myTheme 예외발생: " + e.getMessage());
		}
		return result;
	}
}
