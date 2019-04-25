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
    var parentesco: String!
    var dimensionesref: [String]!
    var dimensiones: [Dimension]!
    
    init() {
        self.nombre=""
        self.alias=""
        self.parentesco=""
        self.dimensiones=[Dimension]()
        self.dimensionesref=[String]()
    }
    
    init (nombre: String, alias: String,parent: String, dimensionesref: [String], dimensiones: [Dimension]){
        self.nombre=nombre
        self.alias=alias
        self.parentesco=parent
        self.dimensiones=dimensiones
        self.dimensionesref=dimensionesref
    }
}
