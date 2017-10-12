package com.sfa.vo;

public class MessageVO
{
	private String text;
	
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	@Override
	public String toString() {
		return "MessageVO [text=" + text + "]";
	}
}
