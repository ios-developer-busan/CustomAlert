//
//  AlertButton.swift
//  CustomAlert
//
//  Created by Jaemyeong Jin on 2021/01/29.
//

import UIKit

final class AlertButton: UIControl {
    enum ButtonType {
        case `default`

        case cancel
    }

    let type: ButtonType

    let titleLabel: UILabel

    init(type: ButtonType, title: String) {
        self.type = type
        self.titleLabel = UILabel()

        super.init(frame: .zero)

        if #available(iOS 13.4, *) {
            self.addInteraction(UIPointerInteraction())
        }

        self.configureTitleLabel(title: title)
        self.configureSubviews()
        self.configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 44.0)
    }
}

// MARK: - Configuration
private extension AlertButton {
    func configureTitleLabel(title: String) {
        let titleLabel = self.titleLabel
        titleLabel.text = title

        switch self.type {
        case .default:
            if #available(iOS 13.0, *) {
                titleLabel.textColor = .label
            } else {
                titleLabel.textColor = .black
            }
        case .cancel:
            if #available(iOS 13.0, *) {
                titleLabel.textColor = .secondaryLabel
            } else {
                titleLabel.textColor = .black
            }
        }
    }

    func configureSubviews() {
        self.addSubview(self.titleLabel)
    }

    func configureConstraints() {
        let titleLabel = self.titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
