package com.zyjd.kh.service;

import com.zyjd.kh.dao.PermissionDao;
import com.zyjd.kh.model.Permission;

public interface PermissionService extends PermissionDao{
    Permission findByName(String permissionName);
}
