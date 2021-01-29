//
//  PresentationAnimator.swift
//  CustomAlert
//
//  Created by Jaemyeong Jin on 2021/01/29.
//

import UIKit

final class PresentationAnimator: NSObject {}

extension PresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.25
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        assert(transitionContext.viewController(forKey: .to) != nil)
        let toViewController = transitionContext.viewController(forKey: .to)!

        let finalFrame = transitionContext.finalFrame(for: toViewController)

        assert(transitionContext.view(forKey: .to) != nil)
        let toView = transitionContext.view(forKey: .to)!

        containerView.addSubview(toView)

        toView.frame = finalFrame
        toView.alpha = 0.0

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            toView.alpha = 1.0
        } completion: { _ in
            if transitionContext.transitionWasCancelled {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(true)
        }
    }
}
