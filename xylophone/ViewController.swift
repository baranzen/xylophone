//
//  ViewController.swift
//  xylophone
//
//  Created by Baran Zengeralp on 24.08.24.
//

import UIKit

class ViewController: UIViewController {
    
    private let buttonList: [UIButton] = []
    private let buttonTextList = ["C","D","D","E","F","G","A","B"]
    private let buttonUIColorList : [UIColor] = [.red,.orange,.yellow,.green,.systemBlue,.blue,.purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(hex: "346FE6BE")
        setupStackViewWithButtons()
    }
    
    public func setupStackViewWithButtons(){
        let stackView = createStackView()
        
        view.addSubview(stackView)
        
        setupStackViewConstraints(stackView: stackView)
        
        for i in 0...6{
            print(i)
            let button = createButton(title: buttonTextList[i], color: buttonUIColorList[i])
            stackView.addArrangedSubview(button)
        }
        
    }
    
    public func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }
    
    public func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 5
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        return button
    }
    
    public func setupStackViewConstraints (stackView: UIStackView){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}

extension UIColor{
    convenience init(hex: String){
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        let alpha = CGFloat(1.0)
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
