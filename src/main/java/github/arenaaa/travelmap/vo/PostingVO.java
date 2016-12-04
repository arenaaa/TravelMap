package github.arenaaa.travelmap.vo;

public class PostingVO {

	private Integer seq;  // pk
	private String title;
	private String contents;
	private String ctime;  // "2016-01-11 12:21:44",
	private Integer viewcount;
	private Integer writer;
	private UserVO writer0;
	private Integer recocount;
	
	//private FileVO attachedFile ;
	
	/*
	 * 얘는 없어지게 됩니다.
	 */
	public PostingVO(Integer seq, String title, String contents, String ctime, Integer viewcount, Integer writer) {
		super();
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.ctime = ctime;
		this.viewcount = viewcount;
		this.writer = writer;
	}

	public PostingVO(Integer seq, String title, String content, String ctime, Integer viewcount, Integer recocount, UserVO writer) {
		super();
		this.seq = seq;
		this.title = title;
		this.contents = content;
		this.ctime = ctime;
		this.viewcount = viewcount;
		this.recocount = recocount;
		this.writer0 = writer;
	}

	public PostingVO(String title, String contents, UserVO writer) {
		this.title = title;
		this.contents = contents;
		this.writer0 = writer;
	}
//	public PostingVO(String title, String contents, UserVO writer, FileVO file) {
//		this.title = title;
//		this.contents = contents;
//		this.writer0 = writer;
//		this.attachedFile = file;
//	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getCtime() {
		return ctime;
	}

	public void setCtime(String ctime) {
		this.ctime = ctime;
	}

	public Integer getViewcount() {
		return viewcount;
	}

	public void setViewcount(Integer viewcount) {
		this.viewcount = viewcount;
	}
	
	public Integer getRecocount() {
		return recocount;
	}

	public void setRecocount(Integer recocount) {
		this.recocount = recocount;
	}

	public UserVO getWriter() {
		return writer0;
	}

	public void setWriter(UserVO writer) {
		this.writer0 = writer;
	}
	
//	public FileVO getAttachedFile() {
//		return attachedFile;
//	}
//
//	public void setAttachedFile(FileVO attachedFile) {
//		this.attachedFile = attachedFile;
//	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((seq == null) ? 0 : seq.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PostingVO other = (PostingVO) obj;
		if (seq == null) {
			if (other.seq != null)
				return false;
		} else if (!seq.equals(other.seq))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "PostingVO [seq=" + seq + ", title=" + title + ", contents=" + contents + ", ctime=" + ctime
				+ ", viewcount=" + viewcount + ", writer=" + writer0 + "]";
	}
	

	
	
}
