//
//  DPPageControlAleppo.swift
//  DPPageControl
//
//  Created by Xueqiang Ma on 2/12/18.
//  Copyright © 2018 Daniel Ma. All rights reserved.
//

import UIKit

class DPPageControlAleppo: DPBasePageControl {
    
    // MARK: - Properties
    
    // indicators
    fileprivate var active: CALayer = CALayer()
    fileprivate var inactives: [CALayer] = [] {
        didSet {
            oldValue.forEach{ $0.removeFromSuperlayer() }
            inactives.forEach(layer.addSublayer)
            active.zPosition = (inactives.last?.zPosition ?? CGFloat(inactives.count)) + 1
        }
    }
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(active)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard isNeedLayoutSubviews() else { return }
        resetFrames()
    }
    
    override func resetFrames() {
        let horizontalOffset = (bounds.width - intrinsicContentSize.width) / 2
        let y = bounds.minY
        // active
        let activeX = bounds.minX
            + horizontalOffset
            + (indicatorSize.width + spacing) * CGFloat(currentPage)  // previous indicators' length
        active.frame = CGRect(x: activeX, y: y, width: indicatorSize.width, height: indicatorSize.height)
        // inactive
        inactives.enumerated().forEach{ pageIndex, inactive in
            let inactiveX = bounds.minX
                + horizontalOffset
                + (indicatorSize.width + spacing) * CGFloat(pageIndex)  // previous indicators' length
            inactive.frame = CGRect(x: inactiveX, y: y, width: indicatorSize.width, height: indicatorSize.height)
        }
    }
    
    override func updatedNumberOfPages(_ count: Int) {
        inactives = (0..<count).map { _ in
            let newLayer = CALayer()
            return newLayer
        }
    }
    
    override func updateColors() {
        active.backgroundColor = selectedColor.cgColor
        inactives.forEach{ $0.backgroundColor = indicatorColor.cgColor }
    }
    
    override func updatedRadius() {
        active.cornerRadius = radius
        inactives.forEach{ inactive in
            inactive.cornerRadius = radius
        }
    }
    
    override func update(for progress: Double) {
        guard (0...1).contains(progress), numberOfPages > 1 else {return}
        let total = intrinsicContentSize.width - indicatorSize.width
        let horizontalOffset = (bounds.width - intrinsicContentSize.width) / 2
        let startX = bounds.minX
            + horizontalOffset
            + CGFloat(progress) * total
        let calculateProgress = progress * Double(numberOfPages - 1)
        let distance = abs(round(calculateProgress) - calculateProgress)
        let mult = 1 + distance * 2
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)   // Prevent animatable property from animating
        active.frame.origin.x = startX
        active.frame.size.width = indicatorSize.width * CGFloat(mult)
        CATransaction.commit()
    }
}
