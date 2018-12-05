//
//  DPBasePageControl.swift
//  DPPageControl
//
//  Created by Xueqiang Ma on 2/12/18.
//  Copyright © 2018 Daniel Ma. All rights reserved.
//

import UIKit

open class DPBasePageControl: UIControl {
    open var numberOfPages: Int = 0 {               // Total number of pages
        didSet {
            guard numberOfPages != oldValue else { return }
            numberOfPages = max(0, numberOfPages)
            invalidateIntrinsicContentSize()        // Recalculate the size
            updatedNumberOfPages(numberOfPages)     // update frames
            updateColors()                          // update colors
        }
    }
    open var currentPage: Int {                     // The selected page
        return Int(round(progress * (CGFloat(numberOfPages) - 1)))
    }
    open var indicatorColor: UIColor = .lightGray { didSet { updateColors() } }
    open var selectedColor: UIColor = .red { didSet { updateColors() } }
    open var spacing: CGFloat = 4 {
        didSet {
            spacing = max(1, spacing)
            invalidateIntrinsicContentSize()
            resetFrames()
        }
    }
    open var indicatorSize: CGSize = CGSize(width: 6, height: 6) {
        didSet {
            guard indicatorSize.width > 1 else {
                indicatorSize.width = max(1, indicatorSize.width)
                return
            }
            guard indicatorSize.height > 1 else {
                indicatorSize.height = max(1, indicatorSize.height)
                return
            }
            invalidateIntrinsicContentSize()
            resetFrames()
        }
    }
    open var radius: CGFloat = 0 {
        didSet {
            updatedRadius()
        }
    }
    open var progress: CGFloat = 0 {
        didSet {
            update(for: progress)
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        let width = CGFloat(numberOfPages) * indicatorSize.width + (CGFloat(numberOfPages) - 1) * spacing
        let height = indicatorSize.height
        return CGSize(width: width, height: height)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false    // ???
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    internal func updatedNumberOfPages(_ count: Int) {
        fatalError("Should be implemented in child class")
    }
    
    internal func updateColors() {
        fatalError("Should be implemented in child class")
    }
    
    internal func updatedRadius() {
        fatalError("Should be implemented in child class")
    }
    
    /// update progress
    ///
    /// - Parameters:
    ///   - progress: 0...1
    ///   - animated: true for animation, false for immediate change.
    internal func update(for progress: CGFloat) {
        fatalError("Should be implemented in child class")
        // let calculateProgress = progress * Double(numberOfPages - 1)
    }
    
    internal func resetFrames() {
        fatalError("Should be implemented in child class")
    }
    
    // Other Methods
    
    // Update the positions when the view's size changes
    fileprivate var lastSize = CGSize.zero
    internal func isNeedLayoutSubviews() -> Bool {
        guard bounds.size != lastSize else { return false }
        lastSize = bounds.size
        return true
    }
}
