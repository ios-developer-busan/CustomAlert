//
//  PresentationController.swift
//  CustomAlert
//
//  Created by Jaemyeong Jin on 2021/01/29.
//

import UIKit

final class PresentationController: UIPresentationController {
    private let dimmingView: UIView

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        self.dimmingView = UIView()

        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

        self.configureDimmingView()
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = self.containerView else { return .zero }
        guard let presentedView = self.presentedView else { return containerView.bounds }

        let bounds = containerView.bounds

        let width = min(bounds.width - 40.0, 320.0)

        let size = presentedView.systemLayoutSizeFitting(
            CGSize(width: width, height: 0.0),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultHigh
        )

        return CGRect(
            x: (bounds.width - width) / 2.0,
            y: (bounds.height - size.height) / 2.0,
            width: width,
            height: size.height
        )
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()

        guard let containerView = self.containerView else { return }
        guard let presentedView = self.presentedView else { return }

        self.dimmingView.frame = containerView.bounds

        presentedView.frame = self.frameOfPresentedViewInContainerView
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        guard let containerView = self.containerView else { return }
        guard let presentedView = self.presentedView else { return }

        presentedView.layer.cornerRadius = 8.0
        presentedView.layer.shadowOpacity = 0.25
        presentedView.layer.shadowOffset = .zero

        let dimmingView = self.dimmingView
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0.0

        containerView.insertSubview(dimmingView, at: 0)

        if let transitionCoordinator = self.presentedViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { _ in
                dimmingView.alpha = 0.25
            }, completion: nil)
        } else {
            dimmingView.alpha = 0.25
        }
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)

        if !completed {
            self.dimmingView.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()

        if let transitionCoordinator = self.presentedViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0.0
            }, completion: nil)
        } else {
            self.dimmingView.alpha = 0.0
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)

        if completed {
            self.dimmingView.removeFromSuperview()
        }
    }
}

private extension PresentationController {
    @objc
    func dimmingViewTapped(_ sender: UITapGestureRecognizer) {
        self.presentedViewController.dismiss(animated: true)
    }
}

// MARK: - Configuration
private extension PresentationController {
    func configureDimmingView() {
        let dimmingView = self.dimmingView
        dimmingView.backgroundColor = .black
        dimmingView.alpha = 0.0
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Self.dimmingViewTapped(_:))))
    }
}
