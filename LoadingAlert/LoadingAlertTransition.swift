//
//  LoadingAlert
//
//  Copyright (c) 2020 - Present Brandon Erbschloe - https://github.com/berbschloe
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Source attribution https://github.com/sberrevoets/SDCAlertView
//  Copyright (c) 2013 Scott Berrevoets (MIT)

import UIKit

internal class LoadingAlertTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    internal func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return LoadingAlertPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    internal func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LoadingAlertAnimationController(presentation: true)
    }
    
    internal func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LoadingAlertAnimationController(presentation: false)
    }
}

private let kInitialScale: CGFloat = 1.2
private let kSpringDamping: CGFloat = 45.71
private let kSpringVelocity: CGFloat = 0
private let kTransitionDuration: TimeInterval = 0.404

internal class LoadingAlertAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let isPresentation: Bool
    
    init(presentation: Bool) {
        self.isPresentation = presentation
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionContext?.isAnimated == true ? kTransitionDuration : 0.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromController = transitionContext.viewController(forKey: .from),
            let toController = transitionContext.viewController(forKey: .to),
            let fromView = fromController.view,
            let toView = toController.view else
        {
            return
        }
        
        if self.isPresentation {
            transitionContext.containerView.addSubview(toView)
        }
        
        let animatingController = self.isPresentation ? toController : fromController
        let animatingView = animatingController.view
        animatingView?.frame = transitionContext.finalFrame(for: animatingController)
        
        if self.isPresentation {
            
            animatingView?.transform = CGAffineTransform(scaleX: kInitialScale, y: kInitialScale)
            animatingView?.alpha = 0
            
            self.animate({
                    animatingView?.transform = CGAffineTransform(scaleX: 1, y: 1)
                    animatingView?.alpha = 1
                }, inContext: transitionContext, withCompletion: { finished in
                    transitionContext.completeTransition(finished)
                })
        } else {
            
            self.animate({
                    animatingView?.alpha = 0
                }, inContext: transitionContext, withCompletion: { finished in
                    fromView.removeFromSuperview()
                    transitionContext.completeTransition(finished)
                })
        }
    }
    
    private func animate(_ animations: @escaping (() -> Void), inContext context: UIViewControllerContextTransitioning, withCompletion completion: @escaping (Bool) -> Void) {
        
        UIView.animate(
            withDuration: self.transitionDuration(using: context),
            delay: 0,
            usingSpringWithDamping: kSpringDamping,
            initialSpringVelocity: kSpringVelocity,
            options: [],
            animations: animations,
            completion: completion)
    }
}

private let kBackgroundAlpha: CGFloat = 0.2

internal class LoadingAlertPresentationController: UIPresentationController {
    
    private let dimmingView = UIView()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        self.dimmingView.backgroundColor = UIColor(white: 0, alpha: kBackgroundAlpha)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        self.presentingViewController.view.tintAdjustmentMode = .dimmed
        self.dimmingView.alpha = 0
        self.containerView?.addSubview(self.dimmingView)
        let coordinator = self.presentedViewController.transitionCoordinator
        coordinator?.animate(alongsideTransition: { _ in self.dimmingView.alpha = 1 }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        self.presentingViewController.view.tintAdjustmentMode = .automatic
        let coordinator = self.presentedViewController.transitionCoordinator
        coordinator?.animate(alongsideTransition: { _ in self.dimmingView.alpha = 0 }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        if let containerView = self.containerView {
            self.dimmingView.frame = containerView.frame
        }
    }
}
