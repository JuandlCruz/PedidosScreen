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
               ]),
    Historicos(fecha: "2023-03-26 08:10:31 +0000",
               cliente: [
                Cliente(
                    cliente: "Javier González",
                    pedidos: [Pedido(numPedido: 98345221380,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-26 11:00:00 +0000", entregado: true)])]),
                Cliente(
                    cliente: "Jose Gutierrez",
                    pedidos: [Pedido(numPedido: 98345221387,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-26 11:00:00 +0000", entregado: false),
                                                Paquete(paquete: "21001311673400103456", hora: "2023-03-26 11:00:00 +0000", entregado: true)])]),
                Cliente(
                    cliente: "Juan Fernandez",
                    pedidos: [Pedido(numPedido: 98345221393,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-26 11:00:00 +0000", entregado: true),
                                                Paquete(paquete: "21001311673400103456", hora: "2023-03-26 11:00:00 +0000", entregado: true)]),
                              Pedido(numPedido: 98345221398,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-26 11:00:00 +0000", entregado: false)])])
               ]),
    Historicos(fecha: "2023-03-25 08:10:31 +0000",
               cliente: [
                Cliente(
                    cliente: "María José González",
                    pedidos: [Pedido(numPedido: 98345221380,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-25 11:00:00 +0000", entregado: true)])])
               ]),
    Historicos(fecha: "2023-03-23 08:10:31 +0000",
               cliente: [
                Cliente(
                    cliente: "María José González",
                    pedidos: [Pedido(numPedido: 98345221380,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-23 11:00:00 +0000", entregado: true)])]),
                Cliente(
                    cliente: "María Cristina Toledo",
                    pedidos: [Pedido(numPedido: 98345221387,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-23 11:00:00 +0000", entregado: false),
                                                Paquete(paquete: "21001311673400103456", hora: "2023-03-23 11:00:00 +0000", entregado: false)])]),
                Cliente(
                    cliente: "Marifer Gutierrez",
                    pedidos: [Pedido(numPedido: 98345221393,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-23 11:00:00 +0000", entregado: true),
                                                Paquete(paquete: "21001311673400103456", hora: "2023-03-23 11:00:00 +0000", entregado: false)]),
                              Pedido(numPedido: 98345221398,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-23 11:00:00 +0000", entregado: true)])])
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
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-19 11:00:00 +0000", entregado: true)])])
               ]),
    Historicos(fecha: "2023-03-12 08:10:31 +0000",
               cliente: [
                Cliente(
                    cliente: "María José González",
                    pedidos: [Pedido(numPedido: 98345221380,
                                     paquetes: [Paquete(paquete: "21001311673400103456", hora: "2023-03-12 11:00:00 +0000", entregado: true)])])
               ])
]
