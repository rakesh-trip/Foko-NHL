//
//  ContainerViewController.swift
//  FokoRetail
//
//  Created by Rakesh Tripathi on 2020-02-27.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum DrawerState {
        case collapsed
        case expanded
    }
    var listOfTeams: Teams?

    var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    var drawerMenuViewController: DrawerMenuViewController?
    
    let expandedOffset: CGFloat = 140
    
    var currentState: DrawerState = .collapsed {
        didSet {
            let shouldShowShadow = currentState != .collapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChild(centerNavigationController)
        
        centerNavigationController.didMove(toParent: self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
}



// MARK: CenterViewController delegate

extension ContainerViewController: CenterViewControllerDelegate {

    
    
    func toggleDrawerMenu() {
        let notAlreadyExpanded = (currentState != .expanded)
        
        if notAlreadyExpanded {
            addDrawerMenuViewController()
        }
        
        animateDrawerMenu(shouldExpand: notAlreadyExpanded)
    }
    
    func addDrawerMenuViewController() {
        guard drawerMenuViewController == nil else { return }
        
        if let vc = UIStoryboard.drawerMenuViewController() {
            
            addChildDrawerViewController(vc)
            drawerMenuViewController = vc
        }
    }
    
    func animateDrawerMenu(shouldExpand: Bool) {
        if shouldExpand {
            currentState = .expanded
            animateCenterPanelXPosition(
                targetPosition: centerNavigationController.view.frame.width - expandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { _ in
                self.currentState = .collapsed
                self.drawerMenuViewController?.view.removeFromSuperview()
                self.drawerMenuViewController = nil
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut, animations: {
                        self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func addChildDrawerViewController(_ viewController: DrawerMenuViewController) {
        viewController.delegate = centerViewController
        view.insertSubview(viewController.view, at: 0)
        
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
        self.view.clipsToBounds = false
        if shouldShowShadow {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
}



// MARK: Gesture recognizer

extension ContainerViewController: UIGestureRecognizerDelegate {
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        
        switch recognizer.state {
        case .began:
            if currentState == .collapsed {
                if gestureIsDraggingFromLeftToRight {
                    addDrawerMenuViewController()
                    showShadowForCenterViewController(true)
                }
            }
            
        case .changed:
            if (currentState == .collapsed && gestureIsDraggingFromLeftToRight) || (currentState == .expanded && !gestureIsDraggingFromLeftToRight) {
                if let rview = recognizer.view {
                    rview.center.x = rview.center.x + recognizer.translation(in: view).x
                    recognizer.setTranslation(CGPoint.zero, in: view)
                }
            }
            
        case .ended:
            if let _ = drawerMenuViewController,
                let rview = recognizer.view {
                // animate the side panel open or closed based on whether the view
                // has moved more or less than halfway
                let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
                animateDrawerMenu(shouldExpand: hasMovedGreaterThanHalfway)
            }
        default:
            break
        }
    }
}
