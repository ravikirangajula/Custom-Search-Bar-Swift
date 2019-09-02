//
//  RKCustomSearchViewProtocol.swift
//
//  Created by Ravikiran on 07/05/2019.
//  Copyright © 2019 Ravikiran. All rights reserved.
//

import UIKit

protocol RKCustomSearchViewProtocol: class {
    func textFieldDidBeginEditing()
}


@IBDesignable
open class RKCustomSearchView: UIView {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var searchtextField: UITextField!
    
    public var searchButton: UIButton?

    private let cancelIconIdentifier = "ic_search_bar_cancel"
    private let searchIconIdentifier = "ic_search_bar_search"
    
    internal weak var delegate: RKCustomSearchViewProtocol?
    var textDidChange: ((String?) -> Void)?
    var textDidEnd: ((String?) -> Void)?
    
    let kCONTENT_XIB_NAME = "RKCustomSearchView"
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}
// MARK: - Setup View
extension RKCustomSearchView {
    
    private func commonInit() {
        container = loadViewFromNib()
        container.frame = self.bounds
        container.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        container.translatesAutoresizingMaskIntoConstraints = true
        container.layer.borderColor = UIColor.gray.cgColor
        container.layer.borderWidth = 1.0
        container.layer.masksToBounds = true
        container.layer.cornerRadius = 6
        container.backgroundColor = .clear
        container.inputView?.backgroundColor = .clear
        searchtextField.inputView?.backgroundColor = .clear
        addSubview(container)
        setupViews()
        setUpFonts()
    }
    
    private func loadViewFromNib() -> UIView {
        let views = Bundle.main.loadNibNamed("RKCustomSearchView", owner: self, options: nil) ?? []
        if views.count == 1, let customView = views.first as? UIView {
            return customView
        }
        return UIView()
    }
    
    @IBAction func searchMode(_ sender: Any) {
        
        if(searchButton?.accessibilityIdentifier == cancelIconIdentifier){
            searchtextField.text = nil
            searchtextField.resignFirstResponder()
        } else {
            searchtextField.becomeFirstResponder()
        }
    }
    
    private func setUpFonts() {
        container.backgroundColor = .clear
        
    }
    
    private func setupViews() {
        
        if (searchButton == nil) {
            
            searchButton =  UIButton(type: .custom)
            searchButton?.imageEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 5)
            searchButton?.frame = CGRect(x: CGFloat(22), y: CGFloat(5), width: CGFloat(28), height: CGFloat(28))
            searchButton?.addTarget(self, action: #selector(self.searchMode), for: .touchUpInside)
            searchtextField.addTarget(self, action: #selector(editingDidStart(textField:)), for: .editingDidBegin)
            searchtextField.addTarget(self, action: #selector(editingDidEnd(textField:)), for: .editingDidEnd)
            searchtextField.addTarget(self, action: #selector(editingDidChange(textField:)), for: .editingChanged)
            searchButton?.imageView?.contentMode = .scaleAspectFit
            searchtextField.rightView = searchButton
            searchtextField.rightViewMode = .always
            searchtextField.textColor = .black
          //  searchtextField.placeHolder(font: UIFont.systemFont(ofSize: 12), placeholderText: "Search")
            searchtextField.font = UIFont.systemFont(ofSize: 14)
            setupSearchRightView()

        }
    }
    
    @objc func editingDidStart(textField: UITextField) {
        setupCancelRightView()
        focusedBorder()
    }
    
    @objc func editingDidChange(textField: UITextField) {
        textDidChange?(textField.text ?? "")
    }
    
    @objc func editingDidEnd(textField: UITextField) {
        textDidChange?(textField.text ?? "")
        textDidEnd?(textField.text ?? "")
        setupSearchRightView()
        unfocusedBorder()
    }
    
    private func focusedBorder() {
        container.layer.borderWidth = 2.0
        container.layer.borderColor = UIColor.blue.cgColor
    }
    
    private func unfocusedBorder() {
        container.layer.borderWidth = 2.0
        container.layer.borderColor = UIColor.gray.cgColor
    }
 
    func setupSearchRightView() {
        searchButton?.setImage(UIImage(named: searchIconIdentifier)?.withRenderingMode(.alwaysTemplate), for: .normal)
        searchButton?.imageView?.tintColor = .gray
        searchButton?.accessibilityIdentifier = searchIconIdentifier
    }
    
    func setupCancelRightView() {
        searchButton?.setImage(UIImage(named: cancelIconIdentifier)?.withRenderingMode(.alwaysTemplate), for: .normal)
        searchButton?.imageView?.tintColor = .gray
        searchButton?.accessibilityIdentifier = cancelIconIdentifier
    }
}


