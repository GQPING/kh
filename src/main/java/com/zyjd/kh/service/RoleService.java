package com.zyjd.kh.service;

import com.zyjd.kh.dao.RoleDao;
import com.zyjd.kh.model.Role;

public interface RoleService extends RoleDao{
    Role findByName(String roleName);
}
