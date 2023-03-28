//
//  PedidosScreenTests.swift
//  PedidosScreenTests
//
//  Created by JSANCAGU on 28/3/23.
//

import XCTest
@testable import PedidosScreen

final class HistoricoViewControllerTests: XCTestCase {
    
    var sut : HistoricoViewController!
    
    override func setUpWithError() throws {
        sut = HistoricoViewController()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_FiltrarHistoricos() {
        let historicos = [
            Historicos(fecha: "2023-03-27 09:10:31 +0000",
                       cliente: [
                        Cliente(
                            cliente: "Javier González",
                            pedidos: [Pedido(numPedido: 98345221380,
                                             paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-27 11:00:00 +0000", entregado: true)])]),
                        Cliente(
                            cliente: "Jose Gutierrez",
                            pedidos: [Pedido(numPedido: 98345221387,
                                             paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-27 11:00:00 +0000", entregado: false),
                                                        Paquete(paquete: "21001311673400103456", hora: "2023-03-27 11:00:00 +0000", entregado: true)])]),
                        Cliente(
                            cliente: "Juan Fernandez",
                            pedidos: [Pedido(numPedido: 98345221393,
                                             paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-27 11:00:00 +0000", entregado: true),
                                                        Paquete(paquete: "21001311673400103456", hora: "2023-03-27 11:00:00 +0000", entregado: true)]),
                                      Pedido(numPedido: 98345221398,
                                             paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-27 11:00:00 +0000", entregado: false)])])
                       ])
        ]
        
        let entregado = true
        
        // Llamar al método y verificar el resultado
        let historicosFiltrados = sut.filtrarHistoricos(historicos, entregado: entregado)
        XCTAssertEqual(historicosFiltrados.count, 1)
        XCTAssertEqual(historicosFiltrados[0].cliente.count, 3)
        XCTAssertEqual(historicosFiltrados[0].cliente[0].pedidos.count, 1)
        XCTAssertEqual(historicosFiltrados[0].cliente[0].pedidos[0].paquetes.count, 1)
        
    }
}
