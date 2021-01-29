//
//  ViewController.swift
//  CustomAlert
//
//  Created by Jaemyeong Jin on 2021/01/29.
//

import UIKit

final class ViewController: UIViewController {}

extension ViewController {
    @IBAction
    private func buttonTapped(_ sender: UIButton) {
        let alert = AlertViewController(
            title: NSLocalizedString("리뷰를 정말 삭제하시겠습니까?", comment: ""),
            message: NSLocalizedString("삭제된 리뷰는 복원되지 않습니다.", comment: "")
        )
        alert.addButton(AlertButton(type: .cancel, title: "취소"))
        alert.addButton(AlertButton(type: .default, title: "삭제하기"))

        self.present(alert, animated: true)
    }
}
