//
//  HistoricoTableViewController.swift
//  PedidosScreen
//
//  Created by Juan de la Cruz Sanchez Agudo on 20/3/23.
//

import UIKit

class HistoricoTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(HistoricoTableViewCell.self, forCellReuseIdentifier: "HistoricoTableViewCell")
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.sectionHeaderTopPadding = 0
        
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return historicos.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SectionHeaderView(reuseIdentifier: "SectionHeaderView")
        headerView.configure(fecha: historicos[section].fecha, clientes: historicos[section].cliente.count)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicos[section].cliente.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoricoTableViewCell", for: indexPath) as! HistoricoTableViewCell
        
        let cliente = historicos[indexPath.section].cliente[indexPath.row]
        cell.configurarCelda(with: cliente)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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
