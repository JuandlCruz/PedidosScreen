//
//  ViewController.swift
//  PedidosScreen
//
//  Created by Juan de la Cruz Sanchez Agudo on 16/3/23.
//

import UIKit

class ViewController: UIViewController {

    private enum Constants {
        static let todayLabelSize = 50.0
        static let ordersLabelSize = 16.0
        static let totalOrdersLabelSize = 140.0
        static let bottomStackViewSeparation = -20.0
        static let mainStackViewLeading = 19.0
        static let mainStackViewTrailing = 30.0
        static let mainStackViewTop = 31.0
        static let mainStackViewBottom = -30.0
    }
    
    private func getTodayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "'Hoy,' dd MMM"
        return dateFormatter.string(from: Date())
    }
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "model"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = getTodayDate()
        label.font = .systemFont(ofSize: Constants.todayLabelSize, weight: .light)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pedidosLabel: UILabel = {
        let label = UILabel()
        label.text = "PEDIDOS POR ENTREGAR"
        label.font = .systemFont(ofSize: Constants.ordersLabelSize, weight: .medium, width: .standard)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pedidosTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "45"
        label.font = .systemFont(ofSize: Constants.totalOrdersLabelSize, weight: .ultraLight)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [pedidosLabel, pedidosTotalLabel])
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.distribution = .fill
        vStack.spacing = Constants.bottomStackViewSeparation
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [dateLabel, bottomStackView])
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.distribution = .equalCentering
        vStack.spacing = .zero
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigationBar()
        setupView()
    }
    
    func setupNavigationBar() {
        self.title = ".19 Online"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func setupView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.addSubview(overlayView)
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            overlayView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.mainStackViewTop),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.mainStackViewLeading),
            mainStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: Constants.mainStackViewTrailing),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.mainStackViewBottom)
        ])
    }
}
