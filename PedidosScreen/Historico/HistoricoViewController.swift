//
//  HistoricoViewController.swift
//  PedidosScreen
//
//  Created by Juan on 22/3/23.
//

import UIKit

class HistoricoViewController: UIViewController {
    
    private enum Constants {
        static let segmentBgColor = UIColor(red: 27.0/255.0, green: 27.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        static let selectedSegmentBgColor = UIColor(red: 54.0/255.0, green: 51.0/255.0, blue: 48.0/255.0, alpha: 1.0)
        static let segmentedViewHeight = 70.0
        static let segmentedPadding = 16.0
        static let todayOffset = 30.0
    }
    
    private let tableView = UITableView()
    
    private let segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["HOY", "-2D", "-3D", "1S"])
        segmented.selectedSegmentIndex = 0
        segmented.layer.cornerRadius = 5.0
        segmented.backgroundColor = Constants.segmentBgColor
        segmented.selectedSegmentTintColor = Constants.selectedSegmentBgColor
        segmented.tintColor = .white
        segmented.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
    private let segmentedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let entregadosLabel: UILabel = {
        let label = UILabel()
        label.text = "•ENTREGADO"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    let entregadosNum: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 80, weight: .light)
        return label
    }()
    
    private lazy var entregadosStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [entregadosLabel, entregadosNum])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    let consultadosLabel: UILabel = {
        let label = UILabel()
        label.text = "•CONSULTADO"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let consultadosNum: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 80, weight: .light)
        return label
    }()
    
    private lazy var consultadosStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [consultadosLabel, consultadosNum])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let stackViewPaquetes: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.backgroundColor = .black
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: Constants.segmentedPadding, leading: Constants.segmentedPadding, bottom: Constants.segmentedPadding, trailing: Constants.segmentedPadding)
        return stackView
    }()
    
    private func setupNavigationBar() {
        self.title = ".19 Online"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoricoTableViewCell.self, forCellReuseIdentifier: "HistoricoTableViewCell")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.sectionHeaderTopPadding = 0
        
        segmentedView.addSubview(segmentedControl)
        stackView.addArrangedSubview(segmentedView)
        stackView.addArrangedSubview(stackViewPaquetes)
        stackViewPaquetes.addArrangedSubview(entregadosStackView)
        stackViewPaquetes.addArrangedSubview(consultadosStackView)
        stackView.addArrangedSubview(tableView)
        view.addSubview(stackView)
        
        
        let entregadosTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        entregadosStackView.addGestureRecognizer(entregadosTapGesture)
        
        let consultadosTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        consultadosStackView.addGestureRecognizer(consultadosTapGesture)
        
        segmentedView.heightAnchor.constraint(equalToConstant: Constants.segmentedViewHeight).isActive = true
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: segmentedView.topAnchor, constant: Constants.segmentedPadding),
            segmentedControl.bottomAnchor.constraint(equalTo: segmentedView.bottomAnchor, constant: -Constants.segmentedPadding),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedView.leadingAnchor, constant: Constants.segmentedPadding),
            segmentedControl.trailingAnchor.constraint(equalTo: segmentedView.trailingAnchor, constant: -Constants.segmentedPadding)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        filterAndReloadData()
        setupNavigationBar()
    }
    
    var filteredHistoricos: [Historicos] = []
    var filteredHistoricosEntregados: [Historicos] = []
    var filteredHistoricosConsultados: [Historicos] = []
    var historicosOriginales: [Historicos] = []
    
    func filterAndReloadData() {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        setContentOffset()
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            filteredHistoricos = historicos.filter { historico in
                let date = inputDateFormatter.date(from: historico.fecha)!
                return Calendar.current.isDateInToday(date)
            }
        case 1:
            filteredHistoricos = historicos.filter { historico in
                let date = inputDateFormatter.date(from: historico.fecha)!
                return date <= today && date >= yesterday
            }
        case 2:
            filteredHistoricos = historicos.filter { historico in
                let date = inputDateFormatter.date(from: historico.fecha)!
                return date <= today && date >= twoDaysAgo
            }
        case 3:
            filteredHistoricos = historicos.filter { historico in
                let date = inputDateFormatter.date(from: historico.fecha)!
                return date <= today && date >= oneWeekAgo
            }
        default:
            fatalError("Invalid segmented control index")
        }
        
        historicosOriginales = filteredHistoricos
        
        filteredHistoricosEntregados = filtrarHistoricos(filteredHistoricos, entregado: true)
        filteredHistoricosConsultados = filtrarHistoricos(filteredHistoricos, entregado: false)
        
        entregadosNum.text = String(totalPaquetes(historico: filteredHistoricos, entregado: true))
        consultadosNum.text = String(totalPaquetes(historico: filteredHistoricos, entregado: false))
        
    }
    
    private func setContentOffset() {
        if segmentedControl.selectedSegmentIndex == 0 {
            tableView.contentOffset.y = Constants.todayOffset
        } else {
            tableView.contentOffset.y = 0
        }
    }
    
    @objc func segmentedControlDidChange(_ sender: UISegmentedControl) {
        filterAndReloadData()
        tableView.reloadData()
        tableView.layoutIfNeeded()
        setContentOffset()
    }
    
    
    // MARK: - Filtrar por Todos, Entregados o Consultados
    
    func totalPaquetes(historico: [Historicos], entregado: Bool) -> Int {
        return historico.reduce(0) { total, historico in
            let paquetesNoEntregados = historico.cliente.flatMap { cliente in
                cliente.pedidos.flatMap { pedido in
                    pedido.paquetes.filter { paquete in
                        return paquete.entregado == entregado
                    }
                }
            }
            return total + paquetesNoEntregados.count
        }
    }
    
    var filtroActual: String = "Todos"
    @objc func tapGestureHandler(sender: UITapGestureRecognizer) {
        if sender.view == entregadosStackView {
            entregadosStackView.alpha = 1
            consultadosStackView.alpha = 0.4
            if filtroActual == "Entregados" {
                consultadosStackView.alpha = 1
                filtroActual = "Todos"
                actualizarTablaConHistoricos(historicosOriginales)
            } else {
                actualizarTablaConHistoricos(filteredHistoricosEntregados)
                filtroActual = "Entregados"
            }
        } else if sender.view == consultadosStackView {
            consultadosStackView.alpha = 1
            entregadosStackView.alpha = 0.4
            if filtroActual == "Consultados" {
                entregadosStackView.alpha = 1
                filtroActual = "Todos"
                actualizarTablaConHistoricos(historicosOriginales)
            } else {
                actualizarTablaConHistoricos(filteredHistoricosConsultados)
                filtroActual = "Consultados"
            }
        }
    }
    
    func actualizarTablaConHistoricos(_ historicos: [Historicos]) {
        filteredHistoricos = historicos
        tableView.reloadData()
        tableView.layoutIfNeeded()
        setContentOffset()
    }
    
    func filtrarHistoricos(_ historicos: [Historicos], entregado: Bool) -> [Historicos] {
        return historicos.map { historico in
            let clientesFiltrados = historico.cliente.map { cliente in
                let pedidosFiltrados = cliente.pedidos.filter { pedido in
                    let paquetesFiltrados = pedido.paquetes.filter { paquete in
                        return paquete.entregado == entregado
                    }
                    return !paquetesFiltrados.isEmpty
                }.map { pedido in
                    let paquetesFiltrados = pedido.paquetes.filter { paquete in
                        return paquete.entregado == entregado
                    }
                    return Pedido(numPedido: pedido.numPedido, paquetes: paquetesFiltrados)
                }
                return Cliente(cliente: cliente.cliente, pedidos: pedidosFiltrados)
            }.filter { cliente in
                return !cliente.pedidos.isEmpty
            }
            return Historicos(fecha: historico.fecha, cliente: clientesFiltrados)
        }.filter { historico in
            return !historico.cliente.isEmpty
        }
    }
    
}

// MARK: - TABLA
extension HistoricoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return 1
        } else {
            return filteredHistoricos.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if segmentedControl.selectedSegmentIndex == 0 {
            tableView.contentInset.top = -Constants.todayOffset
            return nil
        } else {
            let headerView = SectionHeaderView(reuseIdentifier: "SectionHeaderView")
            headerView.configure(fecha: filteredHistoricos[section].fecha, clientes: filteredHistoricos[section].cliente.count)
            tableView.contentInset.top = 0
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredHistoricos.isEmpty {
            return 0
        } else {
            return filteredHistoricos[section].cliente.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoricoTableViewCell", for: indexPath) as! HistoricoTableViewCell
        
        let cliente = filteredHistoricos[indexPath.section].cliente[indexPath.row]
        cell.configurarCelda(with: cliente)
        let lastRowIndex = tableView.numberOfRows(inSection: indexPath.section) - 1
        let shouldShowSeparator = indexPath.row != lastRowIndex
        cell.configurarSeparador(show: shouldShowSeparator)
        return cell
    }
}
