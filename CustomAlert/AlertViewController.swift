//
//  AlertViewController.swift
//  CustomAlert
//
//  Created by Jaemyeong Jin on 2021/01/29.
//

import UIKit

final class AlertViewController: UIViewController {
    private var contentGroup: UIStackView!

    private var titleLabel: UILabel!

    private var messageLabel: UILabel!

    private var buttonGroup: UIStackView!

    private let transitioningDelegateObject: AlertViewControllerTransitioningDelegate = .init()

    private let titleText: String

    private let messageText: String

    init(title: String, message: String) {
        self.titleText = title
        self.messageText = message

        super.init(nibName: nil, bundle: nil)

        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.transitioningDelegateObject
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        self.view = UIView()
        self.contentGroup = UIStackView()
        self.titleLabel = UILabel()
        self.messageLabel = UILabel()
        self.buttonGroup = UIStackView()

        self.configureView()
        self.configureContentGroup()
        self.configureTitleLabel()
        self.configureMessageLabel()
        self.configureButtonGroup()
        self.configureSubviews()
        self.configureConstraints()
    }
}

extension AlertViewController {
    func addButton(_ button: AlertButton) {
        self.loadViewIfNeeded()

        button.addTarget(self, action: #selector(Self.buttonTapped(_:)), for: .touchUpInside)

        self.buttonGroup.addArrangedSubview(button)
    }
}

private extension AlertViewController {
    @objc
    func buttonTapped(_ sender: AlertButton) {
        self.dismiss(animated: true)
    }
}

// MARK: - Configuration
private extension AlertViewController {
    func configureView() {
        assert(self.view != nil)
        let view = self.view!

        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
    }

    func configureTitleLabel() {
        assert(self.titleLabel != nil)
        let titleLabel = self.titleLabel!
        titleLabel.text = self.titleText
        titleLabel.textAlignment = .center
        titleLabel.font = .preferredFont(forTextStyle: .title1)
        titleLabel.numberOfLines = 0
    }

    func configureMessageLabel() {
        assert(self.messageLabel != nil)
        let messageLabel = self.messageLabel!
        messageLabel.text = self.messageText
        messageLabel.textAlignment = .center
        messageLabel.font = .preferredFont(forTextStyle: .body)
        messageLabel.numberOfLines = 0
    }

    func configureContentGroup() {
        assert(self.contentGroup != nil)
        let contentGroup = self.contentGroup!
        contentGroup.axis = .vertical
        contentGroup.spacing = 8.0
    }

    func configureButtonGroup() {
        assert(self.buttonGroup != nil)
        let buttonGroup = self.buttonGroup!
        buttonGroup.distribution = .fillEqually
    }

    func configureSubviews() {
        assert(self.view != nil)
        let view = self.view!

        assert(self.contentGroup != nil)
        let contentGroup = self.contentGroup!
        view.addSubview(contentGroup)

        assert(self.titleLabel != nil)
        let titleLabel = self.titleLabel!
        contentGroup.addArrangedSubview(titleLabel)

        assert(self.messageLabel != nil)
        let messageLabel = self.messageLabel!
        contentGroup.addArrangedSubview(messageLabel)

        assert(self.buttonGroup != nil)
        let buttonGroup = self.buttonGroup!
        contentGroup.addArrangedSubview(buttonGroup)
    }

    func configureConstraints() {
        assert(self.view != nil)
        let view = self.view!

        assert(self.titleLabel != nil)
        let titleLabel = self.titleLabel!
        titleLabel.setContentCompressionResistancePriority(.defaultHigh + 2, for: .vertical)

        assert(self.messageLabel != nil)
        let messageLabel = self.messageLabel!
        messageLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)

        assert(self.contentGroup != nil)
        let contentGroup = self.contentGroup!
        contentGroup.setContentCompressionResistancePriority(.defaultHigh + 3, for: .vertical)
        contentGroup.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            contentGroup.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0),
            contentGroup.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
            view.trailingAnchor.constraint(equalTo: contentGroup.trailingAnchor, constant: 8.0),
            view.bottomAnchor.constraint(equalTo: contentGroup.bottomAnchor, constant: 8.0)
        ])
    }
}
