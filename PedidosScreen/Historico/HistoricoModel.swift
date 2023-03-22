//
//  HistoricoModel.swift
//  PedidosScreen
//
//  Created by Juan de la Cruz Sanchez Agudo on 20/3/23.
//

import Foundation


struct Historicos {
    let fecha: String
    let cliente: [Cliente]
}

struct Cliente {
    let cliente: String
    let pedidos: [Pedido]
}

struct Pedido {
    let numPedido: Int
    let paquetes: [Paquete]
}

struct Paquete {
    let paquete: String
    let hora: String
    let entregado: Bool
}

let historicos: [Historicos] = [
    Historicos(fecha: "2023-03-22 08:10:31 +0000",
               cliente: [
                Cliente(
                    cliente: "María José González",
                    pedidos: [Pedido(numPedido: 98345221380,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-22 11:00:00 +0000", entregado: true)])]),
                Cliente(
                    cliente: "María Cristina Toledo",
                    pedidos: [Pedido(numPedido: 98345221387,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-22 11:00:00 +0000", entregado: true),
                                                Paquete(paquete: "21001311673400103456", hora: "2023-03-22 11:00:00 +0000", entregado: true)])]),
                Cliente(
                    cliente: "Marifer Gutierrez",
                    pedidos: [Pedido(numPedido: 98345221393,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-22 11:00:00 +0000", entregado: true),
                                                Paquete(paquete: "21001311673400103456", hora: "2023-03-22 11:00:00 +0000", entregado: true)]),
                              Pedido(numPedido: 98345221398,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-22 11:00:00 +0000", entregado: true)])])
               ]),
    Historicos(fecha: "2023-03-21 08:10:31 +0000",
               cliente: [
                Cliente(
                    cliente: "María José González",
                    pedidos: [Pedido(numPedido: 98345221380,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-21 11:00:00 +0000", entregado: true)])]),
                Cliente(
                    cliente: "María Cristina Toledo",
                    pedidos: [Pedido(numPedido: 98345221387,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-21 11:00:00 +0000", entregado: true),
                                                Paquete(paquete: "21001311673400103456", hora: "2023-03-21 11:00:00 +0000", entregado: true)])]),
                Cliente(
                    cliente: "Marifer Gutierrez",
                    pedidos: [Pedido(numPedido: 98345221393,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-21 11:00:00 +0000", entregado: true),
                                                Paquete(paquete: "21001311673400103456", hora: "2023-03-21 11:00:00 +0000", entregado: true)]),
                              Pedido(numPedido: 98345221398,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-21 11:00:00 +0000", entregado: true)])])
               ]),
    Historicos(fecha: "2023-03-20 08:10:31 +0000",
               cliente: [
                Cliente(
                    cliente: "Marifer Gutierrez",
                    pedidos: [Pedido(numPedido: 98345221393,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-20 11:00:00 +0000", entregado: true),
                                                Paquete(paquete: "21001311673400103456", hora: "2023-03-20 11:00:00 +0000", entregado: true)]),
                              Pedido(numPedido: 98345221398,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-20 11:00:00 +0000", entregado: true)])]),
                Cliente(
                    cliente: "María Cristina Toledo",
                    pedidos: [Pedido(numPedido: 98345221387,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-20 11:00:00 +0000", entregado: true),
                                                Paquete(paquete: "21001311673400103456", hora: "2023-03-20 11:00:00 +0000", entregado: true)])]),
               ]),
    Historicos(fecha: "2023-03-19 08:10:31 +0000",
               cliente: [
                Cliente(
                    cliente: "María José González",
                    pedidos: [Pedido(numPedido: 98345221380,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-21 11:00:00 +0000", entregado: true)])])
               ])
]


/*
 let historicos: [HistoricoCliente] = [
 HistoricoCliente(cliente: "María José González",
 pedidos: [HistoricoModel(numPedido: 98345221380, fecha: "2023-03-21 08:10:31 +0000",
 paquetes: [PaqueteModel(paquete: "21001311673400103456", hora: "2023-03-21 08:10:31 +0000", entregado: true)])]),
 HistoricoCliente(cliente: "María Cristina Toledo",
 pedidos: [HistoricoModel(numPedido: 98345221387, fecha: "2023-03-21 08:10:31 +0000",
 paquetes: [PaqueteModel(paquete: "21001311673400103456", hora: "2023-03-21 08:10:31 +0000", entregado: true),
 PaqueteModel(paquete: "21001311673400103456", hora: "2023-03-21 08:10:31 +0000", entregado: true)])]),
 HistoricoCliente(cliente: "Marifer Gutierrez",
 pedidos: [HistoricoModel(numPedido: 98345221393, fecha: "2023-03-20 08:10:31 +0000",
 paquetes: [PaqueteModel(paquete: "21001311673400103456", hora: "2023-03-21 08:10:31 +0000", entregado: true),
 PaqueteModel(paquete: "21001311673400103456", hora: "2023-03-21 08:10:31 +0000", entregado: true)]),
 HistoricoModel(numPedido: 98345221398, fecha: "2023-03-20 08:10:31 +0000",
 paquetes: [PaqueteModel(paquete: "21001311673400103456", hora: "2023-03-21 08:10:31 +0000", entregado: true)])]),
 HistoricoCliente(cliente: "María Cristina Toledo",
 pedidos: [HistoricoModel(numPedido: 98345221387, fecha: "2023-03-10 08:10:31 +0000",
 paquetes: [PaqueteModel(paquete: "21001311673400103456", hora: "2023-03-21 08:10:31 +0000", entregado: true),
 PaqueteModel(paquete: "21001311673400103456", hora: "2023-03-21 08:10:31 +0000", entregado: true)])]),
 HistoricoCliente(cliente: "María José González",
 pedidos: [HistoricoModel(numPedido: 98345221380, fecha: "2023-03-07 08:10:31 +0000",
 paquetes: [PaqueteModel(paquete: "21001311673400103456", hora: "2023-03-21 08:10:31 +0000", entregado: true)])])
 ]
 */

