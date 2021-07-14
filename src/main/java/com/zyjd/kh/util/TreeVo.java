package com.zyjd.kh.util;

import java.util.ArrayList;
import java.util.List;

/**
 * 树节点模型
 * @param <T>
 */
public class TreeVo<T>{
	private Integer id;//唯一ID
	private String href;//节点链接
	private String title;//节点标题
	private String value;//节点值
	private Integer parentId;//父级节点ID
	private boolean spread = true;//是否展开
	private boolean checked = false;//是否选中
	private boolean disabled = false;//是否禁止
	private boolean hasParent = false;//有无父节点
	private boolean hasChildren = false;// 无孩子节点
	private boolean isOperation = false;//是否为操作节点
	private List<TreeVo<T>> children = new ArrayList<TreeVo<T>>();//孩子节点集合

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) { this.id = id; }

	public String getTitle() {
		return title;
	}

	public void setTitle(String text) { this.title = text; }

	public String getValue() { return value; }

	public void setValue(String value) { this.value = value; }

	public List<TreeVo<T>> getChildren() {
		return children;
	}

	public void setChildren(List<TreeVo<T>> children) {
		this.children = children;
	}

	public boolean isHasParent() {
		return hasParent;
	}

	public void setHasParent(boolean isParent) {
		this.hasParent = isParent;
	}

	public boolean isHasChildren() { return hasChildren; }

	public void setChildren(boolean isChildren) {
		this.hasChildren = isChildren;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	public boolean isSpread() {
		return spread;
	}

	public void setSpread(boolean spread) {
		this.spread = spread;
	}
	
	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) { this.checked = checked; }

	public boolean isDisabled() {
		return disabled;
	}

	public void setDisabled(boolean disabled) {
		this.disabled = disabled;
	}
	
	public void setHasChildren(boolean hasChildren) {
		this.hasChildren = hasChildren;
	}

	public boolean isOperation() { return isOperation; }

	public void setOperation(boolean operation) { isOperation = operation; }

	public TreeVo(Integer id, String href, String title, String value, Integer parentId, boolean spread, boolean checked,
				  boolean disabled, boolean hasParent, boolean hasChildren, boolean isOperation, List<TreeVo<T>> children) {
		this.id = id;
		this.href = href;
		this.title = title;
		this.value = value;
		this.parentId = parentId;
		this.spread = spread;
		this.checked = checked;
		this.disabled = disabled;
		this.hasParent = hasParent;
		this.hasChildren = hasChildren;
		this.isOperation = isOperation;
		this.children = children;
	}

	public TreeVo() {
		super();
	}
}
