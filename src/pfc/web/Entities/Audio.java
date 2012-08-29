package pfc.web.Entities;

import org.apache.catalina.ha.session.SerializablePrincipal;

import pfc.Global;

public class Audio extends SerializablePrincipal {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3L;
	int id_audio;	
	String text;
	String src;
	
	public int getId_audio() {
		return id_audio;
	}
	public void setId_audio(int id_audio) {
		this.id_audio = id_audio;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	public String getAbsoluteSrc() {
		return Global.path_audio+ src;
	}
	public String getNameAudioSrc(){
		String [] parts = src.split("[.]");
		System.out.println("filename " +src);
		if(parts.length == 0) return "dummy";
		return parts[0];
	}
}
