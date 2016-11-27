package github.arenaaa.travelmap.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import github.arenaaa.travelmap.dao.AdminDao;
import github.arenaaa.travelmap.vo.DetailVO;

@Service
public class AdminService {

	   @Autowired
	   private AdminDao dao ;
	   public void updateGhDetail ( DetailVO detail) {
	      if ( dao.existDetails( detail.getId()) ) {
	         dao.updateDetail ( detail );
	      } else {
	         dao.insertDetail ( detail );
	      }
	}
}