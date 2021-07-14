package com.zyjd.kh.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.kh.dao.MenuDao;
import com.zyjd.kh.model.Menu;
import com.zyjd.kh.service.MenuService;

@Service
@Transactional
public class MenuServiceImpl implements MenuService {

	@Resource
	private MenuDao menuDao;
	
	@Override
	public int add(Menu menu) {
		return menuDao.add(menu);
	}

	@Override
	public int delete(int id) {
		return menuDao.delete(id);
	}

	@Override
	public int update(Menu menu) {
		return menuDao.update(menu);
	}

	@Override
	public Menu findById(int id) {
		return menuDao.findById(id);
	}

	@Override
	public List<Menu> findAll() {
		return menuDao.findAll();
	}

	@Override
	public List<Menu> findByCondition(Menu menu) {
		return menuDao.findByCondition(menu);
	}

	@Override
	public List<Menu> findByConditions(Menu obj) { return menuDao.findByConditions(obj); }

	@Override
	public List<Menu> findByConditionPage(Menu menu) {
		return menuDao.findByConditionPage(menu);
	}

	@Override
	public Menu findByName(String menuName) {
		Menu menu = new Menu();
		menu.setMenuName(menuName);
		List<Menu> menus = menuDao.findByConditions(menu);
		if(menus!=null && !menus.isEmpty() && menus.size()==1){
			return menus.get(0);
		}
		return  null;
	}
}
