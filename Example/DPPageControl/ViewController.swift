//
//  ViewController.swift
//  DPPageControl
//
//  Created by danielpluvia on 12/02/2018.
//  Copyright (c) 2018 danielpluvia. All rights reserved.
//

import UIKit
import DPPageControl

class ViewController: UIViewController {
    
    fileprivate let pageControls: [DPBasePageControl] = [
        DPPageControlAleppo(),
        DPPageControlJaloro()
    ]
    
    fileprivate let scrollView = PagingScrollView()
    fileprivate let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupStackView()
        setupPageControls()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.delegate = self
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
            ])
        scrollView.totalNumberOfPages = 4
    }
    
    fileprivate func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    fileprivate func setupPageControls() {
        pageControls.forEach{ pageControl in
            stackView.addArrangedSubview(pageControl)
            pageControl.numberOfPages = scrollView.totalNumberOfPages
        }
    }
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let scrollView = scrollView as? PagingScrollView else {return}
        let totalDistance = scrollView.containerView.frame.size.width - scrollView.frame.size.width
        let percent = scrollView.contentOffset.x / totalDistance
        pageControls.forEach{ $0.progress = percent }
    }
}
