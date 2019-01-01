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
    var hijosref: [String]!
    var hijos: [Hijo]!
    
    init() {
        self.nombre=""
        self.correo=""
        self.hijos = [Hijo]()
        self.hijosref=[String]()
        self.uid=""
        
    }
}

