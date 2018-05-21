//
//  ViewController.swift
//  StatusBar
//
//  Created by Matt Tian on 2018/5/21.
//  Copyright © 2018 TTSY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        navigationController?.navigationBar.isHidden = true
        
        // If set it to false, the naviView will under the naviBar, when set it to true,
        // the naviView will beneath the naviBar.
        /*
        navigationController?.navigationBar.isTranslucent = false
        */
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if naviView.alpha < 1 {
            navigationController?.lightStatusBar()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.flashScrollIndicators()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.darkStatusBar()
    }
    
    let naviView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.fromHEX(string: "#79C09F")
        view.alpha = 0
        return view
    }()
    
    let naviBottom: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let naviTitle: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.fromHEX(string: "#AD8FA5")
        view.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
        view.scrollIndicatorInsets = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        view.delegate = self
        return view
    }()
    
    func setupViews() {
        view.addSubview(scrollView)
        view.addConstraints(format: "H:|[v0]|", views: scrollView)
        view.addConstraints(format: "V:|[v0]|", views: scrollView)
        
        view.addSubview(naviView)
        view.addSubview(naviBottom)
        view.addConstraints(format: "H:|[v0]|", views: naviView)
        view.addConstraints(format: "H:|[v0]|", views: naviBottom)
        view.addConstraints(format: "V:|[v0(64)][v1(1)]", views: naviView, naviBottom)
        
        view.addSubview(nextButton)
        view.addConstraints(format: "H:[v0(80)]-15-|", views: nextButton)
        view.addConstraints(format: "V:[v0(44)]", views: nextButton)
        nextButton.bottomAnchor.constraint(equalTo: naviBottom.topAnchor).isActive = true
        
        view.addSubview(naviTitle)
        view.addConstraints(format: "V:[v0(44)]", views: naviTitle)
        naviTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        naviTitle.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
    }
    
    @objc func handleNext() {
        let nextViewController = NextViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }

}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        
        if offSetY > 50 {
            UIView.animate(withDuration: 0.4) {
                self.naviView.alpha = 1
                self.navigationController?.darkStatusBar()
            }
            
            guard naviTitle.textColor == .white else { return }
            UIView.transition(with: naviTitle, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.naviTitle.textColor = .black
            })
            
            guard nextButton.titleColor(for: .normal) == .white else { return }
            UIView.transition(with: nextButton, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.nextButton.setTitleColor(.black, for: .normal)
            })
            
        } else {
            UIView.animate(withDuration: 0.4) {
                self.naviView.alpha = 0
                self.navigationController?.lightStatusBar()
            }
            
            guard naviTitle.textColor == .black else { return }
            UIView.transition(with: naviTitle, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.naviTitle.textColor = .white
            })
            
            guard nextButton.titleColor(for: .normal) == .black else { return }
            UIView.transition(with: nextButton, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.nextButton.setTitleColor(.white, for: .normal)
            })
        }
    }
    
}

