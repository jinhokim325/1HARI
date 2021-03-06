package kr.coo.onehari.hr.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
//사원테이블
public class EmpDto {
	private int empNum; //사번
	private int teamCode; //소속해있는 팀 코드
	private String teamName; // 소속팀 이름
	private int rankCode; //직급코드
	private String rankName; // 직급명
	private int positionCode; //직책코드
	private String positionName; // 직책명
	private int employmentCode; //재직구분코드
	private String employmentName; // 재직구분명
	private String empName; //사원이름
	private String password; //비밀번호
	private String birth; //생년월일
	private String resNum; //주민등록번호 뒷자리
	private String phoneNum; //핸드폰번호
	private String email; //이메일
	private String hireDate; //입사일
	private String leaveDate;//퇴사일
	private int loginCnt; //로그인 시도 횟수
	private int isLock; // 로그인 잠금여부
	private String roleName; // 권한명 김진호 2020. 1. 12
	private String roleDSCR; // 권한설명 김진호 2020. 1. 12
	private String taCode; // 근태번호 김진호 2020. 1. 27
	private String taDate; // 근태날짜 김진호 2020. 1. 27
	private String taName; // 근태구분명 김진호 2020. 1. 27
	private String todayWork; // 오늘근무시간 김진호 2020. 1. 27
}
