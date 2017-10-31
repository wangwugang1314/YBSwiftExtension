//
//  UICollectionViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 11/12/2016.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit


// MARK: - 参数
public extension UICollectionView {
	
	/// 获取最后一项的IndexPath
	public var yb_indexPathForLastItem: IndexPath? {
		return yb_indexPathForLastItem(inSection: yb_lastSection)
	}
	
	/// 获取最后一个数组的数index
	public var yb_lastSection: Int {
		return numberOfSections > 0 ? numberOfSections - 1 : 0
	}
	
	/// 获取所有item的个数
	public var yb_numberOfItems: Int {
		var section = 0
		var itemsCount = 0
		while section < self.numberOfSections {
			itemsCount += numberOfItems(inSection: section)
			section += 1
		}
		return itemsCount
	}
	
}


// MARK: - 方法
public extension UICollectionView {
    
	/// 获取指定分组的最后一项
	///
	/// - Parameter section: 分组
	/// - Returns: 返回最后一个的indexPath (if applicable).
	public func yb_indexPathForLastItem(inSection section: Int) -> IndexPath? {
		guard section >= 0 else {
			return nil
		}
		guard section < numberOfSections else {
			return nil
		}
		guard numberOfItems(inSection: section) > 0 else {
			return IndexPath(item: 0, section: section)
		}
		return IndexPath(item: numberOfItems(inSection: section) - 1, section: section)
	}
	
	/// 使用完成处理函数重新加载数据
	///
	/// - Parameter completion: 加载完成后执行的方法
	public func yb_reloadData(_ completion: @escaping () -> Void) {
		UIView.animate(withDuration: 0, animations: {
			self.reloadData()
		}, completion: { _ in
			completion()
		})
	}
	
	/// 使用类名获取cell
	///
	/// - Parameters:
	///   - name: UICollectionViewCell type.
	///   - indexPath: 索引
	/// - Returns: UICollectionViewCell object with associated class name.
	public func yb_dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as! T
    }

	/// SwifterSwift: Dequeue reusable UICollectionReusableView using class name.
	///
	/// - Parameters:
	///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
	///   - name: UICollectionReusableView type.
	///   - indexPath: location of cell in collectionView.
	/// - Returns: UICollectionReusableView object with associated class name.
	public func yb_dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, withClass name: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: name), for: indexPath) as! T
    }

	/// SwifterSwift: Register UICollectionReusableView using class name.
	///
	/// - Parameters:
	///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
	///   - name: UICollectionReusableView type.
	public func yb_register<T: UICollectionReusableView>(supplementaryViewOfKind kind: String, withClass name: T.Type) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
    }
	
	/// SwifterSwift: Register UICollectionViewCell using class name.
    ///
    /// - Parameters:
    ///   - nib: Nib file used to create the collectionView cell.
    ///   - name: UICollectionViewCell type.
    public func yb_register<T: UICollectionViewCell>(nib: UINib?, forCellWithClass name: T.Type) {
        register(nib, forCellWithReuseIdentifier: String(describing: name))
    }
    
    /// SwifterSwift: Register UICollectionViewCell using class name.
    ///
    /// - Parameter name: UICollectionViewCell type.
    public func yb_register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: name))
    }

	/// SwifterSwift: Register UICollectionReusableView using class name.
	///
	/// - Parameters:
	///   - nib: Nib file used to create the reusable view.
	///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
	///   - name: UICollectionReusableView type.
	public func yb_register<T: UICollectionReusableView>(nib: UINib?, forSupplementaryViewOfKind kind: String, withClass name: T.Type) {
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
    }

}
#endif
