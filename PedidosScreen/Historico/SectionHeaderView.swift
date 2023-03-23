//
//  SectionHeaderView.swift
//  PedidosScreen
//
//  Created by Juan de la Cruz Sanchez Agudo on 21/3/23.
//
import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {
    private enum Constants {
        static let margenTabla32 = 32.0
        static let margenTabla16 = 16.0
        static let headerLabelSize = 16.0
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.headerLabelSize, weight: .regular)
        return label
    }()
    
    let clientsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.headerLabelSize, weight: .regular)
        label.textColor = UIColor.systemGray
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(clientsLabel)
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.margenTabla16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.margenTabla16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.margenTabla32),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.margenTabla32)
        ])
        
        contentView.backgroundColor = UIColor.systemGray5
    }
    
    func configure(fecha: String, clientes: Int) {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let date = inputDateFormatter.date(from: fecha)!
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.locale = Locale(identifier: "es_ES")
        if Calendar.current.isDateInToday(date) {
            outputDateFormatter.dateFormat = "'HOY', dd MMM"
            //stackView.removeFromSuperview()
        } else {
            outputDateFormatter.dateFormat = "EEE, dd MMM"
        }
        
        let formattedDate = outputDateFormatter.string(from: date)
        
        dateLabel.text = formattedDate.uppercased()
        clientsLabel.text = "\(clientes) CLIENTES"
    }
}
