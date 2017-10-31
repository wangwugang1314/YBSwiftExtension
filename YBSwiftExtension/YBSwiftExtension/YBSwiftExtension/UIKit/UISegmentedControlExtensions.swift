//
//  UISegmentedControlExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/28/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit


// MARK: - Properties
public extension UISegmentedControl {
	
	/// 设置标题
	public var yb_segmentTitles: [String] {
		get {
            let range = 0..<numberOfSegments
            return range.flatMap { titleForSegment(at: $0) }
		}
		set {
			removeAllSegments()
			for (index, title) in newValue.enumerated() {
				insertSegment(withTitle: title, at: index, animated: false)
			}
		}
	}
	
	/// 设置图片
	public var yb_segmentImages: [UIImage] {
		get {
            let range = 0..<numberOfSegments
            return range.flatMap { imageForSegment(at: $0) }
		}
		set {
			removeAllSegments()
			for (index, image) in newValue.enumerated() {
				insertSegment(with: image, at: index, animated: false)
			}
		}
	}
}
#endif
