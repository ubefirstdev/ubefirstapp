//
//  Colaboradores.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 06/03/19.
//  Copyright © 2019 Innomakers. All rights reserved.
//

class Colaborador {
    var nombre: String!
    var statusInvitacion: String!
    var correo: String!
    var nhijos: Int!
    var suscripcion: String!
    var usuarioUID:String!
    var hijosCompartidos: [Int?]
    var idInvitacion: String!
    
    init() {
        self.nombre=""
        self.statusInvitacion=""
        self.correo=""
        self.nhijos=0
        self.suscripcion=""
        self.usuarioUID=""
        self.hijosCompartidos=[]
        self.idInvitacion=""
    }
}
