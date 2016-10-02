package github.arenaaa.travelmap.vo;

public class GuestHouse {

	private Integer id; 
	private String name;
	private String info;
	private double lat;
	private double lng;
	private String url;
	private String address;
	private String phone;
	private Integer owner;
	
	public GuestHouse(Integer id, String name, String info, double lat, double lng, String url, String address, String phone) {
		super();
		this.id = id;
		this.name = name;
		this.info = info;
		this.lat = lat;
		this.lng = lng;
		this.url = url;
		this.address = address;
		this.phone = phone;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	@Override
	public String toString() {
		return "GuestHouse [id=" + id + ", name=" + name + ", info=" + info + ", lat=" + lat + ", lng=" + lng + ", url="
				+ url + "]";
	}
	
	
	
	
}
