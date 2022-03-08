//
//  ViewController.swift
//  MVVMSample
//
//  Created by Mika Urakawa on 2022/03/08.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var validationLabel: UILabel!

    private let notificationCenter = NotificationCenter()
    private lazy var viewModel = ViewModel(notificationCenter: notificationCenter)

    override func viewDidLoad() {
        super.viewDidLoad()

        validationLabel.text = "IDとパスワードを入力してください。"

        // textField編集中に発火するメソッド
        idTextField.addTarget(
            self,
            action: #selector(textFieldEditingChanged),
            for: .editingChanged
        )
        passwordTextField.addTarget(
            self,
            action: #selector(textFieldEditingChanged),
            for: .editingChanged
        )

        // ViewModelからのpostを監視する
        notificationCenter.addObserver(
            self,
            selector: #selector(updateValidationText),
            name: .changeText,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(updateValidationColor),
            name: .changeColor,
            object: nil
        )
    }
}

extension ViewController {
    @objc private func textFieldEditingChanged(sender : UITextField) {
        viewModel.idPasswordChanged(
            id: idTextField.text,
            password: passwordTextField.text
        )
    }

    @objc private func updateValidationText(notification: Notification) {
        guard let text = notification.object as? String else { return }
        validationLabel.text = text
    }

    @objc private func updateValidationColor(notification: Notification) {
        guard let color = notification.object as? UIColor else { return }
        validationLabel.textColor = color
    }
}
