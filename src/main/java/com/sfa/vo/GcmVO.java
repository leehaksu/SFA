package com.sfa.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class GcmVO {

	private String title = "제목입니다.";
	private String msg = "내용입니다.";
	private String typeCode = "코드입니다.";

	private String regId;
	private boolean pushSuccessOrFailure;
	private String msgId;
	private String errorMsg;

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) throws UnsupportedEncodingException {
		this.msg = URLEncoder.encode(msg, "UTF-8");
	}

	public String getTypeCode() {
		return typeCode;
	}

	public boolean isPushSuccessOrFailure() {
		return pushSuccessOrFailure;
	}

	public void setPushSuccessOrFailure(boolean pushSuccessOrFailure) {
		this.pushSuccessOrFailure = pushSuccessOrFailure;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMsgId() {
		return msgId;
	}

	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

}
