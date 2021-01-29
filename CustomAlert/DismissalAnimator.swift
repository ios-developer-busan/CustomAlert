//
//  DismissalAnimator.swift
//  CustomAlert
//
//  Created by Jaemyeong Jin on 2021/01/29.
//

import UIKit

final class DismissalAnimator: NSObject {}

extension DismissalAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.25
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        assert(transitionContext.view(forKey: .from) != nil)
        let fromView = transitionContext.view(forKey: .from)!

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            fromView.alpha = 0.0
        } completion: { _ in
            if !transitionContext.transitionWasCancelled {
                fromView.removeFromSuperview()
            }
            transitionContext.completeTransition(true)
        }
    }
}
