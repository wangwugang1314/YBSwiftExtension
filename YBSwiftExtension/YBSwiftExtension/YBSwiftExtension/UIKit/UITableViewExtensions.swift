//
//  UITableViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit


// MARK: - 参数
public extension UITableView {
	
	/// 获取最后一行的索引
	public var yb_indexPathForLastRow: IndexPath? {
		return yb_indexPathForLastRow(inSection: yb_lastSection)
	}
	
	/// 获取雨后一个分组的索引
	public var yb_lastSection: Int {
		return numberOfSections > 0 ? numberOfSections - 1 : 0
	}
	
	/// 获取总行数
	public var yb_numberOfRows: Int {
		var section = 0
		var rowCount = 0
		while section < numberOfSections {
			rowCount += numberOfRows(inSection: section)
			section += 1
		}
		return rowCount
	}
	
}
    
// MARK: - Methods
public extension UITableView {

	/// 获取指定分组的最后一个cell的IndexPath
	///
	/// - Parameter section: 行数
	/// - Returns: 返回的IndexPath
	public func yb_indexPathForLastRow(inSection section: Int) -> IndexPath? {
		guard section >= 0 else {
			return nil
		}
		guard numberOfRows(inSection: section) > 0  else {
			return IndexPath(row: 0, section: section)
		}
		return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
	}
	
	/// 更新数据 + 完成回调
	///
	/// - Parameter completion: 完成的回调
	public func yb_reloadData(_ completion: @escaping () -> Void) {
		UIView.animate(withDuration: 0, animations: {
			self.reloadData()
		}, completion: { _ in
			completion()
		})
	}
	
	/// 删除FooterView
	public func yb_removeTableFooterView() {
		tableFooterView = nil
	}
	
	/// 删除HeaderView
	public func yb_removeTableHeaderView() {
		tableHeaderView = nil
	}
	
	
	/// 滚动到底部
	///
	/// - Parameter animated: set true to animate scroll (default is true).
	public func yb_scrollToBottom(animated: Bool = true) {
		let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
		setContentOffset(bottomOffset, animated: animated)
	}
	
	/// 滚动到顶部
	///
	/// - Parameter animated: set true to animate scroll (default is true).
	public func yb_scrollToTop(animated: Bool = true) {
		setContentOffset(CGPoint.zero, animated: animated)
	}
    
    /// 根据类名获取cell
    ///
    /// - Parameter name: UITableViewCell type
    /// - Returns: UITableViewCell object with associated class name (optional value)
    public func yb_dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: name)) as? T
    }

	/// 根据类名、indexPath获取cell
	///
	/// - Parameters:
	///   - name: UITableViewCell type.
	///   - indexPath: location of cell in tableView.
	/// - Returns: UITableViewCell object with associated class name.
	public func yb_dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as! T
    }
    
    /// 根据类名获取HeaderFooterView
    ///
    /// - Parameter name: UITableViewHeaderFooterView type
    /// - Returns: UITableViewHeaderFooterView object with associated class name (optional value)
    public func yb_dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T
    }

	/// 根据NIB注册HeaderFooterView
	///
	/// - Parameters:
	///   - nib: Nib file used to create the header or footer view.
	///   - name: UITableViewHeaderFooterView type.
	public func yb_register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    /// 根据类名注册HeaderFooterView
    ///
    /// - Parameter name: UITableViewHeaderFooterView type
    public func yb_register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    /// 根据类名注册cell
    ///
    /// - Parameter name: UITableViewCell type
    public func yb_register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }

	/// 根据NIB注册cell
	///
	/// - Parameters:
	///   - nib: Nib file used to create the tableView cell.
	///   - name: UITableViewCell type.
	public func yb_register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
        register(nib, forCellReuseIdentifier: String(describing: name))
    }
	
}
#endif
