//
//  CustomTextField.swift
//
//  Created by iOS Developer 3.
//
//

import UIKit

protocol CustomTextProtocol {
   func didClearText(_ sender:CustomTextField)
}
@IBDesignable
class CustomTextField: UITextField {
    
    //MARK: - IBInspectable
    
    @IBInspectable var bottomBorderHeight: CGFloat = 0
    @IBInspectable var bottomBorderColor: UIColor? {
        didSet {
            updateBottomBorder()
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateLeftView()
        }
    }
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable var clearButtonImage: UIImage? {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable var showPasswordButtonImage: UIImage? {
       didSet {
          updateRightView()
       }
    }
    
    @IBInspectable var hidePasswordButtonImage: UIImage? {
       didSet {
          updateRightView()
       }
    }
    
    
    @IBInspectable var placeholderColor: UIColor = ColorsConst.Placeholder ?? .gray {
        didSet {
            //            self.setPlaceholder()
            self.setPlaceholderColor()
        }
    }
    
    /// Setting border width
    @IBInspectable var borderWidth: CGFloat {
       get {
          return layer.borderWidth
       }
       set {
          self.layoutIfNeeded()
          layer.borderWidth = newValue
       }
    }
    
    /// Setting border color
    @IBInspectable var borderColor:  UIColor? {
       get {
          if let color = layer.borderColor {
             return UIColor(cgColor: color)
          }
          return nil
       }
       set {
          self.layoutIfNeeded()
          if let color = newValue {
             layer.borderColor = color.cgColor
          } else {
             layer.borderColor = nil
          }
       }
    }
    
    
    //MARK: - Variables
    private var viewTempWidth: CGFloat      = 0
    private var viewWidth: CGFloat          = 50
    private var imageWidthHeight: CGFloat   = 20
    private var viewHeight: CGFloat         = 40
    private var txtColor =  ColorsConst.Text
    private var bottomBorderLine:UIView?

    var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    var customTextProtocol: CustomTextProtocol?
   
    //MARK: - View Life Cycle
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    //MARK: - IBActions
    
    
    /// Set bottom border
    func updateBottomBorder() {
        DispatchQueue.main.async {
            if let border = self.viewWithTag(500) {
                border.removeFromSuperview()
            }
            self.bottomBorderLine = UIView(frame: CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: self.bottomBorderHeight))
            self.bottomBorderLine?.tag = 500
            self.bottomBorderLine?.backgroundColor = self.bottomBorderColor
            self.borderStyle = UITextField.BorderStyle.none
            if let bottomBorderLine = self.bottomBorderLine {
                self.addSubview(bottomBorderLine)
            }
        }
    }
    
    /// Clear all text
    @objc fileprivate func btnClearTextPressed(sender: UIButton) {
        self.text = ""
        self.clearButtonImage = nil
        customTextProtocol?.didClearText(self)
    }
    
    /// Show hide password
    @objc func btnShowHidePressed(sender: UIButton) {
       self.isSecureTextEntry = !self.isSecureTextEntry
       updateRightView()
    }
    
    
    /// Left View
    fileprivate func updateLeftView() {
        DispatchQueue.main.async {
            if let image = self.leftImage {
                self.viewTempWidth = self.viewWidth
                self.leftViewMode = UITextField.ViewMode.always
                let aViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: self.viewTempWidth, height: self.viewHeight))
                aViewLeft.isUserInteractionEnabled = false
                let aImgView = UIImageView(frame: CGRect(x: 15, y: (self.viewHeight - self.imageWidthHeight) / 2, width: self.imageWidthHeight, height: self.imageWidthHeight))
                aImgView.contentMode = .scaleAspectFit
                aImgView.image = image
                //            aImgView.tintColor = color
                aViewLeft.addSubview(aImgView)
                self.leftView = aViewLeft
                self.padding = UIEdgeInsets(top: self.padding.top, left: self.viewTempWidth, bottom: self.padding.bottom, right: self.rightImage != nil ? self.viewTempWidth : self.padding.right)
            } else {
                self.viewTempWidth = 0
                self.padding = UIEdgeInsets(top: self.padding.top, left: self.padding.left, bottom: self.padding.bottom, right: self.rightImage != nil ? self.viewTempWidth : self.padding.right)
                self.leftViewMode = UITextField.ViewMode.never
                self.leftView = nil
            }
        }
    }
    
    /// Right View
    fileprivate func updateRightView() {
        DispatchQueue.main.async {
            if let image = self.rightImage {
                self.viewTempWidth = self.viewWidth
                self.rightViewMode = UITextField.ViewMode.always
                let aViewRight = UIView(frame: CGRect(x: 0, y: 0, width: self.viewTempWidth, height: self.viewHeight))
                aViewRight.isUserInteractionEnabled = false
                let aImgView = UIImageView(frame: CGRect(x: (self.viewTempWidth - self.imageWidthHeight), y: (self.viewHeight - self.imageWidthHeight) / 2, width: self.imageWidthHeight, height: self.imageWidthHeight))
                aImgView.contentMode = .scaleAspectFit
                aImgView.image = image
                //            aImgView.tintColor = color
                aViewRight.addSubview(aImgView)
                self.rightView = aViewRight
                self.padding = UIEdgeInsets(top: self.padding.top, left: self.leftImage != nil ? self.viewTempWidth : self.padding.left, bottom: self.padding.bottom, right: self.viewTempWidth - 10)
            } else if let image = self.clearButtonImage {
                self.viewTempWidth = self.viewWidth
                self.rightViewMode = UITextField.ViewMode.always
               let aViewRight = UIView(frame: CGRect(x: 0, y: 0, width: self.viewWidth, height: self.viewHeight))
               let aImgView = UIImageView(frame: CGRect(x: (self.viewWidth - self.imageWidthHeight) / 2, y: (self.viewHeight - self.imageWidthHeight) / 2, width: self.imageWidthHeight, height: self.imageWidthHeight))
               aImgView.contentMode = .scaleAspectFit
               aImgView.image = image
               aViewRight.addSubview(aImgView)
                let clearButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height))
//                clearButton.setImage(image, for: .normal)
               aViewRight.addSubview(clearButton)
                self.rightView = aViewRight
                clearButton.addTarget(self, action: #selector(self.btnClearTextPressed(sender:)), for: .touchUpInside)
                self.padding = UIEdgeInsets(top: self.padding.top, left: self.leftImage != nil ? self.viewTempWidth : self.padding.left, bottom: self.padding.bottom, right: self.viewTempWidth - 10)
            } else if let imageShow = self.showPasswordButtonImage, let imageHide = self.hidePasswordButtonImage {
                self.viewTempWidth = self.viewWidth
                self.rightViewMode = UITextField.ViewMode.always
                let aViewRight = UIView(frame: CGRect(x: 0, y: 0, width: self.viewWidth, height: self.viewHeight))
                let aImgView = UIImageView(frame: CGRect(x: (self.viewWidth - self.imageWidthHeight), y: (self.viewHeight - self.imageWidthHeight) / 2, width: self.imageWidthHeight, height: self.imageWidthHeight))
                aImgView.contentMode = .scaleAspectFit
                aImgView.image = self.isSecureTextEntry ? imageShow : imageHide
                aViewRight.addSubview(aImgView)
                let showHidePasswordButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.viewWidth, height: self.frame.height))
                //                clearButton.setImage(image, for: .normal)
                aViewRight.addSubview(showHidePasswordButton)
                self.rightView = aViewRight
                showHidePasswordButton.addTarget(self, action: #selector(self.btnShowHidePressed(sender:)), for: .touchUpInside)
                self.padding = UIEdgeInsets(top: self.padding.top, left: self.leftImage != nil ? self.viewTempWidth : self.padding.left, bottom: self.padding.bottom, right: self.viewTempWidth - 10)
             } else {
                self.viewTempWidth = 0
                self.padding = UIEdgeInsets(top: self.padding.top, left: self.leftImage != nil ? self.viewTempWidth : self.padding.left, bottom: self.padding.bottom, right: self.padding.right)
                self.leftViewMode = UITextField.ViewMode.never
                self.rightView = nil
            }
        }
    }
    
    /// Setting attributed placeholder
    func setPlaceholder() {
        DispatchQueue.main.async {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ?  self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: self.placeholderColor])
        }
    }
    
    /// Setting attributed placeholder with text color
    fileprivate func setPlaceholderColor() {
        self.textColor = self.placeholderColor == ColorsConst.PlaceholderError ? ColorsConst.PlaceholderError : txtColor
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ?  self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: self.placeholderColor])
    }
    
}
