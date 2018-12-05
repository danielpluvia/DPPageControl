//
//  PagingScrollView.swift
//  DPPageControl_Example
//
//  Created by Xueqiang Ma on 5/12/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class PagingScrollView: UIScrollView {
    
    var totalNumberOfPages: Int = 0 {
        didSet {
            var tempPages: [UIView] = []
            (0..<totalNumberOfPages).forEach{ _ in
                tempPages.append(UIView())
            }
            pages = tempPages
        }
    }
    var containerView: UIView = UIView()
    fileprivate var pages: [UIView] = [] {
        didSet {
            oldValue.forEach { oldPage in
                oldPage.constraints.forEach{ $0.isActive = false }
                oldPage.removeConstraints(oldPage.constraints)
                oldPage.removeFromSuperview()
            }
            pages.enumerated().forEach { (index, page) in
                containerView.addSubview(page)
                page.backgroundColor = index % 2 == 0 ? .red : .yellow
                page.translatesAutoresizingMaskIntoConstraints = false
                guard totalNumberOfPages > 1 else {
                    NSLayoutConstraint.activate([
                        page.topAnchor.constraint(equalTo: containerView.topAnchor),
                        page.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                        page.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                        page.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                        page.widthAnchor.constraint(equalTo: widthAnchor)
                        ])
                    return
                }
                switch index {
                case 0:
                    NSLayoutConstraint.activate([
                        page.topAnchor.constraint(equalTo: containerView.topAnchor),
                        page.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                        page.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                        page.widthAnchor.constraint(equalTo: widthAnchor)
                        ])
                case totalNumberOfPages - 1:
                    NSLayoutConstraint.activate([
                        page.topAnchor.constraint(equalTo: containerView.topAnchor),
                        page.leadingAnchor.constraint(equalTo: pages[index - 1].trailingAnchor),
                        page.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                        page.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                        page.widthAnchor.constraint(equalTo: widthAnchor)
                        ])
                default:
                    NSLayoutConstraint.activate([
                        page.topAnchor.constraint(equalTo: containerView.topAnchor),
                        page.leadingAnchor.constraint(equalTo: pages[index - 1].trailingAnchor),
                        page.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                        page.widthAnchor.constraint(equalTo: widthAnchor)
                        ])
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isPagingEnabled = true
        setupContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupContentView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .green
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor)
            ])
    }

}
