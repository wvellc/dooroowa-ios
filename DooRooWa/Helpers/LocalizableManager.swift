//
//  LocalizableManager.swift
//  DooRooWa
//
//  Created by Vision on 28/03/23.
//

import UIKit

//MARK: Localizable

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

//MARK: - Extended Classes

//Label
final class LocalizableLabel: UILabel {
    @IBInspectable var localizableKey: String? {
        didSet {
            guard let key = localizableKey else { return }
            text = key.localized
        }
    }
}

//Text Field
final class LocalizableText: CustomTextField {
    @IBInspectable var localizableKey: String? {
        didSet {
            guard let key = localizableKey else { return }
            placeholder = key.localized
        }
    }
}

//Button
final class LocalizableButton: UIButton {
    @IBInspectable var localizableKey: String? {
        didSet {
            guard let key = localizableKey else { return }
            setTitle(key.localized, for: .normal)
        }
    }
}
