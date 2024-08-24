//
//  ViewController.swift
//  xylophone
//
//  Created by Baran Zengeralp on 24.08.24.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    private var buttonList: [UIButton] = []
    private let buttonTextList = ["C", "D", "E", "F", "G", "A", "B"]
    private let buttonUIColorList: [UIColor] = [.red, .orange, .yellow, .green, .systemBlue, .blue, .purple]
    private var player: AVAudioPlayer!
    private let feedbackGenerator = UIImpactFeedbackGenerator()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(hex: "346FE6BE")
        setupStackViewWithButtons()
    }

    public func setupStackViewWithButtons() {
        let stackView = createStackView()

        view.addSubview(stackView)

        setupStackViewConstraints(stackView: stackView)

        for i in 0 ... 6 {
            let button = createButton(title: buttonTextList[i], color: buttonUIColorList[i])
            let view = createUIView(index: i, button: button)
            buttonList.append(button)
            stackView.addArrangedSubview(view)
        }
    }

    public func createUIView(index: Int, button: UIButton) -> UIView {
        let uiView = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        uiView.backgroundColor = .clear // Görünüm arka plan rengini ayarlayabilirsiniz

        uiView.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: uiView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: uiView.centerYAnchor),
            button.bottomAnchor.constraint(equalTo: uiView.bottomAnchor),
            button.topAnchor.constraint(equalTo: uiView.topAnchor),
            button.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: CGFloat(index * 6)),
            button.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: CGFloat(-(index * 6))),
        ])
        return uiView
    }

    public func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 30
        return stackView
    }

    public func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.titleLabel?.font = UIFont(name: "Bradley Hand", size: 45)

        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        return button
    }

    public func setupStackViewConstraints(stackView: UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }

    public func playSound(_ title: String) {
        let url = Bundle.main.url(forResource: title, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

    @objc private func buttonPressed(_ sender: UIButton) {
        if let buttonIndex = buttonList.firstIndex(of: sender) {
            print("Button \(sender.currentTitle!) tapped")
            feedbackGenerator.impactOccurred()
            playSound(sender.currentTitle!)
        }
    }
}

extension UIColor {
    convenience init(hex: String) {
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
