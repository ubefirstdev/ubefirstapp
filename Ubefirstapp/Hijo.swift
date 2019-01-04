//
//  Hijo.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 27/12/18.
//  Copyright © 2018 roman. All rights reserved.
//

class Hijo{
    var nombre: String!
    var alias: String!
    var dimensionesref: [String]!
    var dimensiones: [Dimension]!
    
    init() {
        self.nombre=""
        self.alias=""
        self.dimensiones=[Dimension]()
        self.dimensionesref=[String]()
    }
    
    init (nombre: String, alias: String, dimensionesref: [String], dimensiones: [Dimension]){
        self.nombre=nombre
        self.alias=alias
        self.dimensiones=dimensiones
        self.dimensionesref=dimensionesref
    }
}
