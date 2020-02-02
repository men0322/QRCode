//
//  PassCodePageViewController.swift
//  mf_qr_code
//
//  Created by Nguyen Hung on 3/8/19.
//  Copyright © 2019 Money Forward, Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PassCodePageViewController: UIPageViewController {

    var pageContentViewControllers: [UIViewController] = []
    
    var currentPageIndex = BehaviorRelay<Int>(value: 0)
    
    let fillPassCode = R.storyboard.passCode.passCodeChildViewController()
    
    let confirmPassCode = R.storyboard.passCode.passCodeChildViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        configureView()
    }
    
    private func configureView() {
        guard let fillPassCode = fillPassCode,
            let confirmPassCode = confirmPassCode else {
                return
        }
        fillPassCode.passCodeType = .fillPass
        confirmPassCode.passCodeType = .confirmPass
        
        pageContentViewControllers = [fillPassCode, confirmPassCode]
        
        setViewControllers([fillPassCode], direction: .forward, animated: true, completion: nil)
    }
    
    func fillPassCodeWithType(type: PassCodeType, number: Int) {
        switch type {
        case .fillPass:
            fillPassCode?.drawPin(number: number)
        case .confirmPass:
            confirmPassCode?.drawPin(number: number)
        }
    }
    
    func setPageViewContent(at index: Int, direction: UIPageViewController.NavigationDirection) {
        let viewController = pageContentViewControllers[index]
        setViewControllers([viewController], direction: direction, animated: true, completion: { [weak self] complete in
            if complete {
                self?.currentPageIndex.accept(index)
            }
        })
    }
    
}

extension PassCodePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
        ) -> UIViewController? {
        guard var index = pageContentViewControllers.index(of: viewController) else {
            return nil
        }
        
        index -= 1
        
        if index >= 0 && index < pageContentViewControllers.count {
            return pageContentViewControllers[index]
        }
        return nil
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
        ) -> UIViewController? {
        guard var index = pageContentViewControllers.index(of: viewController) else {
            return nil
        }
        
        index += 1
        
        if index >= 0 && index < pageContentViewControllers.count {
            return pageContentViewControllers[index]
        }
        return nil
    }
}

extension PassCodePageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
        ) {
        guard let viewC = viewControllers?.last else { return }
        
        if completed {
            self.currentPageIndex.accept(pageContentViewControllers.index(of: viewC) ?? 0)
        }
    }
}

