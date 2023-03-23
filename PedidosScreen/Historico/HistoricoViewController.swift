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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
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
        stackView.addArrangedSubview(tableView)
        view.addSubview(stackView)
        
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
    
    func filterAndReloadData() {
        
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        
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
    }

    @objc func segmentedControlDidChange(_ sender: UISegmentedControl) {
        filterAndReloadData()
        tableView.reloadData()
        tableView.layoutIfNeeded()
        
        if segmentedControl.selectedSegmentIndex == 0 {
            tableView.contentOffset.y = Constants.todayOffset
        } else {
            tableView.contentOffset.y = 0
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
        let headerView = SectionHeaderView(reuseIdentifier: "SectionHeaderView")
        headerView.configure(fecha: filteredHistoricos[section].fecha, clientes: filteredHistoricos[section].cliente.count)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            tableView.contentInset.top = -Constants.todayOffset
            return nil
        } else {
            tableView.contentInset.top = 0
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
        let lastRowIndex = tableView.numberOfRows(inSection: indexPath.section) - 1
        let shouldShowSeparator = indexPath.row != lastRowIndex
        cell.configurarSeparador(show: shouldShowSeparator)
        return cell
    }
}
