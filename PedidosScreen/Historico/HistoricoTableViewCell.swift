//
//  HistoricoTableViewCell.swift
//  PedidosScreen
//
//  Created by Juan de la Cruz Sanchez Agudo on 20/3/23.
//

import UIKit

class HistoricoTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let margenTabla32 = 32.0
        static let margenTabla48 = 48.0
        static let margenTabla64 = 64.0
        static let margenTabla16 = 16.0
        static let paqueteLabelSize = 16.0
        static let clienteLabelSize = 32.0
        static let pedidoCortoLabelSize = 48.0
    }
    
    let clienteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.clienteLabelSize, weight: .light)
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.margenTabla32
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(clienteLabel)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            clienteLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.margenTabla32),
            clienteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.margenTabla16),
            clienteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.margenTabla16),
            
            stackView.topAnchor.constraint(equalTo: clienteLabel.bottomAnchor, constant: Constants.margenTabla32),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.margenTabla16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.margenTabla32),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.margenTabla48)
        ])
    }
    
    func configurarCelda(with model: Cliente) {
        clienteLabel.text = "\(model.cliente)"
        
        for arrangedSubview in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(arrangedSubview)
            arrangedSubview.removeFromSuperview()
        }
        
        model.pedidos.forEach { pedido in
            
            let HstackView = UIStackView()
            HstackView.translatesAutoresizingMaskIntoConstraints = false
            HstackView.axis = .horizontal
            HstackView.spacing = 0
            HstackView.distribution = .equalSpacing
            
            let pedidoCortoLabel = UILabel()
            pedidoCortoLabel.translatesAutoresizingMaskIntoConstraints = false
            pedidoCortoLabel.font = UIFont.systemFont(ofSize: Constants.pedidoCortoLabelSize, weight: .light)
            pedidoCortoLabel.text = String(String(pedido.numPedido).suffix(2))
            
            let pedidoLabel = UILabel()
            pedidoLabel.translatesAutoresizingMaskIntoConstraints = false
            pedidoLabel.font = UIFont.preferredFont(forTextStyle: .title2)
            pedidoLabel.text = String(pedido.numPedido)
            
            HstackView.addArrangedSubview(pedidoCortoLabel)
            HstackView.addArrangedSubview(pedidoLabel)
            
            stackView.addArrangedSubview(HstackView)
            
            pedido.paquetes.forEach { paquete in
                
                let row = UIView()
                
                let paqueteLabel = UILabel()
                let checkImageView = UIImageView()
                let horaLabel = UILabel()
                
                paqueteLabel.translatesAutoresizingMaskIntoConstraints = false
                paqueteLabel.font = UIFont.systemFont(ofSize: Constants.paqueteLabelSize)
                paqueteLabel.textColor = .lightGray
                paqueteLabel.text = "\(paquete.paquete)"
                
                let fechaString = paquete.hora
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
                if let date = dateFormatter.date(from: fechaString) {
                    dateFormatter.timeStyle = .short
                    let formattedDate = dateFormatter.string(from: date)
                    horaLabel.text = formattedDate
                } else {
                    print("Invalid date format")
                }
                
                horaLabel.translatesAutoresizingMaskIntoConstraints = false
                horaLabel.font = UIFont.systemFont(ofSize: Constants.paqueteLabelSize, weight: .bold)
                
                checkImageView.translatesAutoresizingMaskIntoConstraints = false
                checkImageView.contentMode = .scaleAspectFit
                checkImageView.image = paquete.entregado ? UIImage(systemName: "checkmark") : UIImage(systemName: "multiply")
                checkImageView.tintColor = paquete.entregado ? .systemGreen : .systemRed
                
                row.addSubview(paqueteLabel)
                row.addSubview(horaLabel)
                row.addSubview(checkImageView)
                
                NSLayoutConstraint.activate([
                    paqueteLabel.leadingAnchor.constraint(equalTo: row.leadingAnchor),
                    paqueteLabel.topAnchor.constraint(equalTo: row.topAnchor),
                    paqueteLabel.bottomAnchor.constraint(equalTo: row.bottomAnchor),
                    
                    horaLabel.leadingAnchor.constraint(equalTo: paqueteLabel.trailingAnchor, constant: Constants.margenTabla16),
                    horaLabel.topAnchor.constraint(equalTo: row.topAnchor),
                    horaLabel.bottomAnchor.constraint(equalTo: row.bottomAnchor),
                    
                    checkImageView.leadingAnchor.constraint(equalTo: horaLabel.trailingAnchor, constant: Constants.margenTabla16),
                    checkImageView.trailingAnchor.constraint(equalTo: row.trailingAnchor),
                    checkImageView.topAnchor.constraint(equalTo: row.topAnchor),
                    checkImageView.bottomAnchor.constraint(equalTo: row.bottomAnchor),
                    checkImageView.widthAnchor.constraint(equalToConstant: Constants.margenTabla32),
                    checkImageView.heightAnchor.constraint(equalToConstant: Constants.margenTabla32)
                ])
                
                stackView.addArrangedSubview(row)
            }
        }
    }
}
