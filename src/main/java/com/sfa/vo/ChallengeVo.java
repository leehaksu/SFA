package com.sfa.vo;
//도전과제
public class ChallengeVo {
	
	private Long challenge_no;//도전과제 번호
	private String content;//도전과제 내용
	private String dept;//부서
	private Long activity;
	public Long getChallenge_no() {
		return challenge_no;
	}
	public void setChallenge_no(Long challenge_no) {
		this.challenge_no = challenge_no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public Long getActivity() {
		return activity;
	}
	public void setActivity(Long activity) {
		this.activity = activity;
	}
	@Override
	public String toString() {
		return "ChallengeVo [challenge_no=" + challenge_no + ", content=" + content + ", dept=" + dept + ", activity="
				+ activity + "]";
	}
}
