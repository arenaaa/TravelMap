package github.arenaaa.travelmap.vo;

public class GuestHouse {

	private Integer id; 
	private String name;
	private String info;
	private double lat;
	private double lng;
	private String url;
	
	public GuestHouse(Integer id, String name, String info, double lat, double lng, String url) {
		super();
		this.id = id;
		this.name = name;
		this.info = info;
		this.lat = lat;
		this.lng = lng;
		this.url = url;
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
	
	@Override
	public String toString() {
		return "GuestHouse [id=" + id + ", name=" + name + ", info=" + info + ", lat=" + lat + ", lng=" + lng + ", url="
				+ url + "]";
	}
	
	
	
	
}
