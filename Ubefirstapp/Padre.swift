//
//  PadreClass.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 27/12/18.
//  Copyright © 2018 roman. All rights reserved.
//

class Padre{
    var nombre: String!
    var correo: String!
    var uid: String!
    var premium: Bool!
    var colaborador: Bool!
    var hijosref: [String]!
    var hijos: [Hijo]!
    var colaboradoresref: [String]!
    var colaboradores: [Colaborador]!
    
    init() {
        self.nombre=""
        self.correo=""
        self.hijos = [Hijo]()
        self.hijosref=[String]()
        self.uid=""
        self.premium=nil
        self.colaborador=nil
        self.colaboradoresref=[String]()
        self.colaboradores=[Colaborador]()
    }
}

