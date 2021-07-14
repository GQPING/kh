package com.zyjd.kh.service;

import com.zyjd.kh.dao.MenuDao;
import com.zyjd.kh.model.Menu;

public interface MenuService extends MenuDao{
    Menu findByName(String menuName);
}
