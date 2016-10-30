package github.arenaaa.travelmap.vo;

public class DetailVO {
	private Integer id;
	private boolean womanOnly;
	
	private String breakfastStart; // null
	private String breakfastEnd; // null
	
	private String limitTime;
	
	private boolean foodOutsideOnly;
	
	private String extra;
	
	private Integer parkingLot;
	
	private boolean bbq;
	private String bbqMemo;
	
	private String checkin;
	private String checkout;
	
	public DetailVO() {
		// TODO Auto-generated constructor stub
	}
	public DetailVO(Integer id, boolean womanOnly, String breakfastStart, String breakfastEnd, String limitTime,
			boolean foodOutsideOnly, String extra, Integer parkingLot, boolean bbq, String bbqMemo, String checkin,
			String checkout) {
		super();
		this.id = id;
		this.womanOnly = womanOnly;
		this.breakfastStart = breakfastStart;
		this.breakfastEnd = breakfastEnd;
		this.limitTime = limitTime;
		this.foodOutsideOnly = foodOutsideOnly;
		this.extra = extra;
		this.parkingLot = parkingLot;
		this.bbq = bbq;
		this.bbqMemo = bbqMemo;
		this.checkin = checkin;
		this.checkout = checkout;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public boolean isWomanOnly() {
		return womanOnly;
	}

	public void setWomanOnly(boolean womanOnly) {
		this.womanOnly = womanOnly;
	}

	public String getBreakfastStart() {
		return breakfastStart;
	}

	public void setBreakfastStart(String breakfastStart) {
		this.breakfastStart = breakfastStart;
	}

	public String getBreakfastEnd() {
		return breakfastEnd;
	}

	public void setBreakfastEnd(String breakfastEnd) {
		this.breakfastEnd = breakfastEnd;
	}
	
	public void setBreakfastTime ( String startTime, String endTime) {
		this.breakfastStart = startTime;
		this.breakfastEnd = endTime;
	}

	public String getLimitTime() {
		return limitTime;
	}

	public void setLimitTime(String limitTime) {
		this.limitTime = limitTime;
	}

	public boolean isFoodOutsideOnly() {
		return foodOutsideOnly;
	}

	public void setFoodOutsideOnly(boolean foodOutsideOnly) {
		this.foodOutsideOnly = foodOutsideOnly;
	}

	public String getExtra() {
		return extra;
	}

	public void setExtra(String extra) {
		this.extra = extra;
	}

	public Integer getParkingLot() {
		return parkingLot;
	}

	public void setParkingLot(Integer parkingLot) {
		this.parkingLot = parkingLot;
	}

	public boolean isBbq() {
		return bbq;
	}

	public void setBbq(boolean bbq) {
		this.bbq = bbq;
	}

	public String getBbqMemo() {
		return bbqMemo;
	}

	public void setBbqMemo(String bbqMemo) {
		this.bbqMemo = bbqMemo;
	}

	public String getCheckin() {
		return checkin;
	}

	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}

	public String getCheckout() {
		return checkout;
	}

	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}

	@Override
	public String toString() {
		return "DetailVO [id=" + id + ", womanOnly=" + womanOnly + ", breakfastStart=" + breakfastStart
				+ ", breakfastEnd=" + breakfastEnd + ", limitTime=" + limitTime + ", foodOutsideOnly=" + foodOutsideOnly
				+ ", extra=" + extra + ", parkingLot=" + parkingLot + ", bbq=" + bbq + ", bbqMemo=" + bbqMemo
				+ ", checkin=" + checkin + ", checkout=" + checkout + "]";
	}
	
	
}
