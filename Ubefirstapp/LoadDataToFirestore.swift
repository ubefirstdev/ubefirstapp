//
//  LoadDataToFirestore.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 03/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import Foundation

class LoadDataToFirestore {
    
    func agregarHijoNuevo(alias: String, nombre: String){
        let docid = db.collection("hijos").document().documentID
        
        let recuerdoref = self.crearRecuerdoVacio()
        let dimensionref = self.crearDimensionVacia(recuerdoref: recuerdoref)
        
        let docData: [String: Any] = [
            "nombre": nombre,
            "alias": alias,
            "childOf": userData.uid,
            "dimensionesref": [dimensionref]
        ]
        
        db.collection("hijos").document(docid).setData(docData) { err in
            if let err=err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        let nuevohijo = Hijo()
        nuevohijo.nombre=nombre
        nuevohijo.alias=alias
        nuevohijo.dimensionesref.append(dimensionref)
        
        let nuevadimensionvacia = Dimension()
        nuevadimensionvacia.recuerdosref.append(recuerdoref)
        
        userData.hijosref.append(docid)
        userData.hijos.append(nuevohijo)
        userData.hijos[userData.hijos.count-1].dimensiones.append(nuevadimensionvacia)
        agregarReferenciaNuevoHijo()
        
        
        }
    
    func agregarReferenciaNuevoHijo(){
        var doc: [String: [Any]]=[:]
        
        if userData.hijosref.count == 1{
            doc = [
                "hijosref": [userData.hijosref[0]]
            ]
        } else if userData.hijosref.count == 2{
            doc = [
                "hijosref": [userData.hijosref[0], userData.hijosref[1]]
            ]
        } else if userData.hijosref.count == 3{
            doc = [
                "hijosref": [userData.hijosref[0], userData.hijosref[1], userData.hijosref[2]]
            ]
        }else if userData.hijosref.count == 4{
            doc = [
                "hijosref": [userData.hijosref[0], userData.hijosref[1], userData.hijosref[2], userData.hijosref[3]]
            ]
        }else if userData.hijosref.count == 5{
            doc = [
                "hijosref": [userData.hijosref[0], userData.hijosref[1], userData.hijosref[2], userData.hijosref[3], userData.hijosref[4]]
            ]
        }
        
        
        db.collection("users").document(userData.uid).setData(doc, merge: true)
        
    }
    
    func crearRecuerdoVacio () -> String{
        let docid = db.collection("recuerdos").document().documentID
        
        let docData: [String: Any] = [
            "titulo": "",
            "descripcion": "",
            "Dimension": "",
            "elementosref": [],
            "hijo": "",
            "ubicacion": ""
        ]
        
        db.collection("recuerdos").document(docid).setData(docData) { err in
            if let err=err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        return docid
    }
    
    func crearDimensionVacia(recuerdoref: String) -> String{
        let docid = db.collection("dimensiones").document().documentID
        
        let docData: [String: Any] = [
            "nombre": "",
            "recuerdosref": [recuerdoref]
        ]
        
        db.collection("dimensiones").document(docid).setData(docData) { err in
            if let err=err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        return docid
    }
    
    
    
    
}
