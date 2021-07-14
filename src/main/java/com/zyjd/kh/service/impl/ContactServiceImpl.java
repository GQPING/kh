package com.zyjd.kh.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.zyjd.kh.dao.ContactDao;
import com.zyjd.kh.model.Contact;
import com.zyjd.kh.service.ContactService;

@Service
@Transactional
public class ContactServiceImpl implements ContactService {

	@Resource
	private ContactDao contactDao;
	
	@Override
	public int add(Contact contact) {
		return contactDao.add(contact);
	}

	@Override
	public int delete(int id) {
		return contactDao.delete(id);
	}

	@Override
	public int update(Contact contact) {
		return contactDao.update(contact);
	}

	@Override
	public Contact findById(int id) {
		return contactDao.findById(id);
	}

	@Override
	public List<Contact> findAll() {
		return contactDao.findAll();
	}

	@Override
	public List<Contact> findByCondition(Contact contact) { return contactDao.findByCondition(contact); }

	@Override
	public List<Contact> findByConditions(Contact obj) { return contactDao.findByConditions(obj); }

	@Override
	public List<Contact> findByConditionPage(Contact contact) {
		return contactDao.findByConditionPage(contact);
	}
}
