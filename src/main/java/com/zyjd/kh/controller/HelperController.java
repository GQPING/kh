package com.zyjd.kh.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import cn.hutool.core.date.DateUnit;
import cn.hutool.core.date.DateUtil;
import com.zyjd.kh.model.*;
import com.zyjd.kh.service.*;
import com.zyjd.kh.util.QcyConstants;
import com.zyjd.kh.util.TreeVo;
import com.zyjd.kh.vo.SalesBean;
import com.zyjd.kh.vo.UnitsBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 帮助控制器
 * 协助处理相关操作
 */
@Controller
public class HelperController {

	@Autowired
	private LogService LogService;

	@Autowired
	private BillService billService;

	@Autowired
	private CustomerService customerService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private RoleService roleService;

	@Autowired
	private CashingService cashingService;

	@Autowired
	private ProjectService projectService;

	@Autowired
	private OperationService operationService;

	@Autowired
	private PermissionService permissionService;

	// 检测项目回款到期信息
	public List<Project> GetProjectToDate() {
		Project condition = new Project();// 查询条件
		condition.setIsPayEnd(1);// 按状态!='已付清'查询
		condition.setProjectPayState("已付清");
		List<Project> projects = projectService.findByConditions(condition);
		if (projects != null && !projects.isEmpty()) {
			List<Project> temp = new ArrayList<Project>();
			for(Project project:projects) {
				// 处于‘拖欠状态’的直接记录
				if("拖欠中".equals(project.getProjectPayState())){
					temp.add(project);
				}else {
					// 判断距离付款截止日期相差天数小于等于设置的提醒天数后，记录
					if(DateUtil.between(project.getDeadLineDate(), new Date(), DateUnit.DAY) <= project.getProjectRemindDays()){
						temp.add(project);
					}
				}
			}
			return temp;
		}
		return null;
	}

	// 同步刷新项目回款状态
	public void SyncProjectState() {
		List<Project> projects = projectService.findAll();
		if (projects != null && !projects.isEmpty()) {
			Project temp = new Project();// 临时变量
			for(Project project:projects) {
				if(project.getProjectUnQuota()==null) continue;
				temp.setId(project.getId());// 指定ID
				if(project.getProjectUnQuota()==0){
					temp.setProjectPayState("已付清");
				}else{
					// 截止日期小于当前日期，拖欠中
					if(project.getDeadLineDate().getTime() < new Date().getTime()){
						temp.setProjectPayState("拖欠中");
					}else{
						temp.setProjectPayState("未付清");
					}
				}
				projectService.update(temp);// 更新状态
			}
		}
	}

	// 项目数量明细，查询项目数、到期数、未到期数、到期已结清数、到期未结清数
	public List<UnitsBean> GetSummary0(int year) {
		Totals total;// 汇总对象
		UnitsBean bean;// 数量Bean
		Project condition = new Project();
		condition.setIsMonth(1);
		List<UnitsBean> beans = new ArrayList<UnitsBean>();
		// 默认查询年的12个月分别按月记录
		for (int i = 1; i <= 12; i++) {
			bean = new UnitsBean();// 每个月创建一个
			String dateStr = year + "-" + (i < 10 ? "0" + i : "" + i);
			condition.setSignDate(DateUtil.parse(dateStr, "yyyy-MM"));// 1-12月
			total = projectService.findTotalByCondition(condition);
			if(total!=null && total.getProjects()!=0) {
				// 项目
				bean.setProjects(GetCounts(total.getProjects()));
				// 到期
				condition.setIsDeadLine(1);
				total = projectService.findTotalByCondition(condition);// 查询到期数
				bean.setInEnds(GetCounts(total.getProjects()));
				// 未到期
				bean.setUnEnds(bean.getProjects()-bean.getInEnds());
				// 到期已结清
				condition.setProjectPayState("已付清");
				total = projectService.findTotalByCondition(condition);// 查询到期已付清数
				bean.setInPayEnds(GetCounts(total.getProjects()));
				// 到期未结清
				bean.setUnPayEnds(bean.getProjects()-bean.getInPayEnds());
			}
			beans.add(bean);
		}
		return beans;
	}

	// 项目收支明细，查询合计、预算、收入
	public List<SalesBean> GetSummary1(int year) {
		Totals total;// 汇总对象
		SalesBean bean;// 销售额Bean
		Project condition = new Project();
		condition.setIsMonth(1);
		List<SalesBean> beans = new ArrayList<SalesBean>();
		// 默认查询年的12个月分别按月记录
		for (int i = 1; i <= 12; i++) {
			bean = new SalesBean();// 每个月创建一个
			String dateStr = year + "-" + (i < 10 ? "0" + i : "" + i);
			condition.setSignDate(DateUtil.parse(dateStr, "yyyy-MM"));// 1-12月
			total = projectService.findTotalByCondition(condition);
			if(total!=null && total.getProjects()!=0){
				bean.setBudgets(GetQuotas(total.getBudgets())); // 合计
				bean.setCosts(GetQuotas(total.getCosts()));     // 预算
				bean.setIncomes(GetQuotas(total.getIncomes())); // 收入
			}
			beans.add(bean);
		}
		return beans;
	}

	// 项目回款明细，查询合计、回款、余款
	public List<SalesBean> GetSummary2(int year) {
		Totals total;// 汇总对象
		SalesBean bean;// 销售额Bean
		Project condition = new Project();
		condition.setIsMonth(1);
		List<SalesBean> beans = new ArrayList<SalesBean>();
		// 默认查询年的12个月分别按月记录
		for (int i = 1; i <= 12; i++) {
			bean = new SalesBean();// 每个月创建一个
			String dateStr = year + "-" + (i < 10 ? "0" + i : "" + i);
			condition.setSignDate(DateUtil.parse(dateStr, "yyyy-MM"));// 1-12月
			total = projectService.findTotalByCondition(condition);
			if(total!=null && total.getProjects()!=0){
				bean.setBudgets(GetQuotas(total.getBudgets()));   // 合计
				bean.setInQuotas(GetQuotas(total.getInQuotas())); // 回款
				bean.setUnQuotas(GetQuotas(total.getUnQuotas())); // 余款
			}
			beans.add(bean);
		}
		return beans;
	}

	// 客户交易明细，查询预算、回款、余款、滞纳、到期已收、到期未收
	public List<SalesBean> GetSummary3(Integer id,int year) {
		Totals total;// 汇总对象
		SalesBean bean;// 销售额Bean
		Customer customer=null;
		Project condition = new Project();
		condition.setIsMonth(1);// 按月查
		if(id!=null) {
			condition.setCustomerID(id);// 设置客户
			customer = customerService.findById(id);// 指定客户
		}
		List<SalesBean> beans = new ArrayList<SalesBean>();
		// 默认查询年的12个月分别按月记录
		for (int i = 1; i <= 12; i++) {
			bean = new SalesBean();// 每个月创建一个
			bean.setCustomer(customer);// 设置关联客户
			String dateStr = year + "-" + (i < 10 ? "0" + i : "" + i);
			condition.setSignDate(DateUtil.parse(dateStr, "yyyy-MM"));// 1-12月
			total = projectService.findTotalByCondition(condition);
			if(total!=null && total.getProjects()!=0){
				bean.setBudgets(GetQuotas(total.getBudgets()));   // 预算
				bean.setInQuotas(GetQuotas(total.getInQuotas())); // 回款
				bean.setUnQuotas(GetQuotas(total.getUnQuotas())); // 余款
				bean.setDelays(GetQuotas(total.getDelayPays()));  // 滞纳
			}
			condition.setIsDeadLine(1);// 到期查询
			total = projectService.findTotalByCondition(condition);
			if(total!=null && total.getProjects()!=0){
				bean.setInPayEnds(GetQuotas(total.getInQuotas()));  // 到期已收
				bean.setUnPayEnds(GetQuotas(total.getUnQuotas()));  // 到期未收
			}else{
				bean.setInPayEnds(bean.getInQuotas());  // 未到期已收
				bean.setUnPayEnds(bean.getUnQuotas());  // 未到期未收
			}
			condition.setIsDeadLine(null);// 置null
			beans.add(bean);
		}
		return beans;
	}

	// 获取相差天数
	public long GetBetweenDays(Date start, Date end) {
		return (end.getTime() - start.getTime()) / (1000L * 3600L * 24L);
	}
	
	// 获取项目地址
	public String GetBasePath(HttpServletRequest request) {
		return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	}

	// 获取额度(为null时，默认为0)
	public Double GetQuotas(Double quota) {
		return quota == null ? 0.0 : quota;
	}

	// 获取数量(为null时，默认为0)
	public Integer GetCounts(Integer quota) { return quota == null ? 0 : quota; }

	// IP静态记录
	public  static String IPAddress = "";

	// 保存用户真实IP地址
	public void SetRemoteIP(HttpServletRequest request) {
		String ip = "127.0.0.1";
		if (request.getHeader("x-forwarded-for") == null)
		{
			ip= request.getRemoteAddr();
		}else{
			ip = request.getHeader("x-forwarded-for");
		}
		IPAddress =ip;
	}

	// UserID静态记录
	public  static Integer UserID = 0;

	// 保存UserID,用于日志记录
	public void SetUserID(Integer userID) {
		UserID = userID;
	}

	// 日志记录
	public void AddLog(String operateType,String operateDetail) {
		try{
			LogService.add(new Log(UserID,operateType,operateDetail,IPAddress,new Date()));
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	// 获取父子菜单
	public List<Menu> SyncParentChildren(List<Menu> menus){
		Menu condition = new Menu();
		for(int i =0; i<menus.size(); i++) {
			if(menus.get(i).getParentID()==0){
				// 一级菜单
				menus.get(i).setParent(null);// 无父级
				condition.setId(0);
				menus.get(i).setChildren(menuService.findByConditions(condition));// 找子级
			}else{
				// 下级菜单
				menus.get(i).setParent(menuService.findById(menus.get(i).getParentID()));  // 找父级
				condition.setId(menus.get(i).getId());
				menus.get(i).setChildren(menuService.findByConditions(condition));// 找子级
			}
		}
		return menus;
	}

	// 构造权限树结构
	public Object GetPermissionTree(Role role){
		return GetPermissionTree(roleService.findByRolePermissions(role));
	}

	//  递归获取上一级树节点 TreeVo<String> parent = GetParentNode(root, node.getParentId());
	public TreeVo<String> GetParentNode(TreeVo<String> node, Integer parentId){
		if(node == null){
			return node;
		}
		TreeVo<String> parent = new TreeVo<String>();
		for (TreeVo<String> child : node.getChildren()) {
			if (child.getId() == parentId) {
				parent = child;
				break;
			}
			parent=GetParentNode(child, parentId);
		}
		return parent;
	}

	// 构造权限树
	public TreeVo<String> GetPermissionTree(List<Permission> permissions){
		// 树根节点
		TreeVo<String> root = new TreeVo<String>();
		root.setId(0);
		root.setTitle("所有权限");
		root.setHasParent(false);
		root.setHasChildren(true);
		root.setValue("所有权限-查看");
		// 二级节点
		Menu condition = new Menu();
		condition.setParentID(0);
		List<Menu> firsts = menuService.findByConditions(condition);// firsts：项目管理、客户管理、用户管理、系统管理、项目提醒弹窗
		// 有下级菜单情况
		if(firsts!=null && !firsts.isEmpty()) {
			TreeVo<String> tree1;
			root.setHasChildren(true);
			List<TreeVo<String>> trees1 = new ArrayList<TreeVo<String>>();
			for(int i =0; i<firsts.size(); i++) {
				tree1= new TreeVo<String>();
				tree1.setHref(null);
				tree1.setHasParent(true);
				tree1.setParentId(root.getId());
				tree1.setId(firsts.get(i).getId());
				tree1.setTitle(firsts.get(i).getMenuName());
				tree1.setValue(firsts.get(i).getMenuName()+"-查看");
				// 三级节点
				condition.setParentID(firsts.get(i).getId());
				List<Menu> seconds = menuService.findByConditions(condition);// seconds:开荒项目列表、开荒数据统计、修改密码、系统扩展等
				// 有下级菜单情况
				if(seconds!=null && !seconds.isEmpty()) {
					TreeVo<String> tree2;
					tree1.setHasChildren(true);
					List<TreeVo<String>> trees2 = new ArrayList<TreeVo<String>>();
					for(int j =0; j<seconds.size(); j++) {
						tree2= new TreeVo<String>();
						tree2.setHref(null);
						tree2.setHasParent(true);
						tree2.setParentId(tree1.getId());
						tree2.setId(seconds.get(j).getId());
						tree2.setTitle(seconds.get(j).getMenuName());
						tree2.setValue(seconds.get(j).getMenuName()+"-查看");
						// 四级节点
						condition.setParentID(seconds.get(j).getId());
						List<Menu> thirds = menuService.findByConditions(condition);// thirds:按预算成本收入统计、按预算回款余款统计、流式刷新等
						// 有下级菜单情况
						if(thirds!=null && !thirds.isEmpty()) {
							TreeVo<String> tree3;
							tree2.setHasChildren(true);
							List<TreeVo<String>> trees3 = new ArrayList<TreeVo<String>>();
							for(int k =0; k<thirds.size(); k++) {
								tree3= new TreeVo<String>();
								tree3.setHref(null);
								tree3.setHasParent(true);
								tree3.setHasChildren(false);// 只是叶子菜单
								tree3.setChecked(IsTreeNodeChecked(permissions,thirds.get(k).getMenuName(),"查看"));// 设置叶子菜单状态
								tree3.setParentId(tree2.getId());
								tree3.setId(thirds.get(k).getId());
								tree3.setTitle(thirds.get(k).getMenuName());
								tree3.setValue(thirds.get(k).getMenuName()+"-查看");
								tree3.setChildren(SetTreeOperation(thirds.get(k).getId(),thirds.get(k).getMenuName(),permissions));// 操作节点
								trees3.add(tree3);
							}
							tree2.setChildren(trees3);
						}
						// 没有下级菜单情况，列表
						else{
							if(seconds.get(j).getHasOperationChildren()==1){// 有无操作节点
								tree2.setHasChildren(true);
								tree2.setChildren(SetTreeOperation(seconds.get(j).getId(),seconds.get(j).getMenuName(),permissions));// 操作节点,具体
							}else{
								tree2.setHasChildren(false);
								tree2.setChecked(IsTreeNodeChecked(permissions,seconds.get(j).getMenuName(),"查看"));// 设置叶子菜单状态,修改密码
							}
						}
						trees2.add(tree2);
					}
					tree1.setChildren(trees2);
				}
				// 没有下级菜单情况，弹窗
				else{
					if(firsts.get(i).getHasOperationChildren()==1){// 有无操作节点
						tree1.setHasChildren(true);
						tree1.setChildren(SetTreeOperation(firsts.get(i).getId(),firsts.get(i).getMenuName(),permissions));// 操作节点,具体
					}else{
						tree1.setHasChildren(false);
						tree1.setChecked(IsTreeNodeChecked(permissions,firsts.get(i).getMenuName(),"查看"));// 设置叶子菜单状态，合同管理
					}
				}
				trees1.add(tree1);
			}
			root.setChildren(trees1);
		}
		// 没有下级菜单情况
		else{
			//root.setHasChildren(true);
			//root.setChildren(SetTreeOperation(root.getId(), root.getTitle(),permissions));// 操作节点
		}
		return root;
	}

	// 设置权限操作节点
	// 叶子菜单节点选中即可查看
	// 叶子操作节点选中即可操作
	public List<TreeVo<String>> SetTreeOperation(Integer menuId, String menuName,List<Permission> permissions){
		List<TreeVo<String>> operations = new ArrayList<TreeVo<String>>();
		switch(menuName){
			case "开荒项目管理":
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.LOOKUP,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.CREATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.UPDATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.DELETE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.FLUSH,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.CONTACT,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.APPLY,permissions));
				break;
			case "开荒项目列表":
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.LOOKUP,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.CASHING,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.BILLING,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.FLUSH,permissions));
				break;
			case "项目收款列表":
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.LOOKUP,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.UPDATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.DELETE,permissions));
				break;
			case "项目开票列表":
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.LOOKUP,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.UPDATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.DELETE,permissions));
				break;
			case "客户信息列表":
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.LOOKUP,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.CREATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.UPDATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.DELETE,permissions));
				break;
			case "项目联系列表":
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.LOOKUP,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.UPDATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.DELETE,permissions));
				break;
			case "用户列表":
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.LOOKUP,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.CREATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.UPDATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.DELETE,permissions));
				break;
			case "角色列表":
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.LOOKUP,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.CREATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.UPDATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.DELETE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.ASSIGN,permissions));
				break;
			case "权限列表":
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.LOOKUP,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.CREATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.UPDATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.DELETE,permissions));
				break;
			case "菜单列表":
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.LOOKUP,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.CREATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.UPDATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.DELETE,permissions));
				break;
			case "操作列表":
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.LOOKUP,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.CREATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.UPDATE,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.DELETE,permissions));
				break;
			case "系统日志":
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.LOOKUP,permissions));
				operations.add(GetTreeOperation(menuId,menuName,QcyConstants.DELETE,permissions));
				break;
		}
		return operations;
	}

	// 设置是否选中节点
	public Boolean IsTreeNodeChecked(List<Permission> permissions,String menuName,String operationName) {
		for (Permission permission : permissions) {
			if (permission.getMenu().getMenuName().equals(menuName) && permission.getOperation().getOperateName().equals(operationName)) {
				return true;
			}
			continue;
		}
		return false;
	}

	// 获取操作节点
	public TreeVo<String> GetTreeOperation(Integer menuId,String menuName,String operationName,List<Permission> permissions){
		TreeVo<String> operation = new TreeVo<String>();
		Operation temp = operationService.findByName(operationName);
		if(temp!=null) {
			operation.setHref(null);
			operation.setHasParent(true);
			operation.setOperation(true);
			operation.setParentId(menuId);
			operation.setId(menuId*100+temp.getId());// 设置唯一性规则ID,不可以重复
			operation.setChecked(IsTreeNodeChecked(permissions,menuName,operationName));
			operation.setHasChildren(false);
			operation.setValue(menuName+"-"+operationName);// 对应权限名称
			operation.setTitle(operationName);
		}
		return operation;
	}
}
