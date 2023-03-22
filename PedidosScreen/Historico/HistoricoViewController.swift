//
//  HistoricoViewController.swift
//  PedidosScreen
//
//  Created by Juan on 22/3/23.
//

import UIKit

class HistoricoViewController: UIViewController {
    
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["HOY", "-2D", "-3D", "1S"])
        segmented.selectedSegmentIndex = 0
        segmented.layer.cornerRadius = 5.0
        segmented.backgroundColor = .black
        segmented.selectedSegmentTintColor = .darkGray
        segmented.tintColor = .white
        segmented.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
    let segmentedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoricoTableViewCell.self, forCellReuseIdentifier: "HistoricoTableViewCell")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.sectionHeaderTopPadding = 0
        
        segmentedView.addSubview(segmentedControl)
        stackView.addArrangedSubview(segmentedView)
        stackView.addArrangedSubview(tableView)
        view.addSubview(stackView)
        
        segmentedView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: segmentedView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: segmentedView.centerYAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedView.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: segmentedView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange), for: .valueChanged)
        filterAndReloadData()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.title = ".19 Online"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    var filteredHistoricos: [Historicos] = []
    
    func filterAndReloadData() {
        // Filtrar los datos según la opción seleccionada en el UISegmentedControl
        switch segmentedControl.selectedSegmentIndex {
        case 0: // "Hoy"
            filteredHistoricos = historicos.filter { historico in
                let inputDateFormatter = DateFormatter()
                inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                let date = inputDateFormatter.date(from: historico.fecha)!
                return Calendar.current.isDateInToday(date)
            }
        case 1: // "-2D (dos días antes de hoy)"
            let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
            filteredHistoricos = historicos.filter { historico in
                let inputDateFormatter = DateFormatter()
                inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                let date = inputDateFormatter.date(from: historico.fecha)!
                return Calendar.current.isDate(date, inSameDayAs: twoDaysAgo)
            }
        case 2: // "-3D (tres días antes de hoy)"
            let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
            filteredHistoricos = historicos.filter { historico in
                let inputDateFormatter = DateFormatter()
                inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                let date = inputDateFormatter.date(from: historico.fecha)!
                return Calendar.current.isDate(date, inSameDayAs: threeDaysAgo)
            }
        case 3: // "1S (hace una semana)"
            let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
            let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
            filteredHistoricos = historicos.filter { historico in
                let inputDateFormatter = DateFormatter()
                inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                let date = inputDateFormatter.date(from: historico.fecha)!
                return date >= oneWeekAgo && date <= twoDaysAgo
            }
        default:
            fatalError("Invalid segmented control index")
        }
        tableView.reloadData()
    }

    
    @objc func segmentedControlDidChange(_ sender: UISegmentedControl) {
        filterAndReloadData()
    }

}

extension HistoricoViewController: UITableViewDelegate, UITableViewDataSource {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return 1
        } else {
            return filteredHistoricos.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SectionHeaderView(reuseIdentifier: "SectionHeaderView")
        headerView.configure(fecha: filteredHistoricos[section].fecha, clientes: filteredHistoricos[section].cliente.count)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            return nil
        } else {
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredHistoricos[section].cliente.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoricoTableViewCell", for: indexPath) as! HistoricoTableViewCell
        
        let cliente = filteredHistoricos[indexPath.section].cliente[indexPath.row]
        cell.configurarCelda(with: cliente)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: indexPath.section) - 1
        let separatorTag = 1000
        if indexPath.row != lastRowIndex {
            let separator = UIView(frame: CGRect(x: 0, y: cell.bounds.height - 15, width: cell.bounds.width, height: 15))
            separator.tag = separatorTag
            separator.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleHeight]
            separator.backgroundColor = .systemGray5
            cell.addSubview(separator)
        } else {
            cell.viewWithTag(separatorTag)?.removeFromSuperview()
        }
    }
}
