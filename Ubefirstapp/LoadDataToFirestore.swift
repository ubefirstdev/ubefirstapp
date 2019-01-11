//
//  LoadDataToFirestore.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 03/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import Foundation

class LoadDataToFirestore {
    
    func agregarHijoNuevoAndReturnHijoref(alias: String, nombre: String){
        let docIDhijo = db.collection("users").document(userData.uid).collection("hijos").document().documentID
        var i = 0
        /*var recuerdoref=[String]()
        
        while (i<8){
            recuerdoref.append(self.crearRecuerdoVacio())
            i = i + 1

        }*/
        
        let dimensionesref = self.crearDimensionesDefaultAndReturnDimensionesref(hijosref: docIDhijo)
        
        let docData: [String: Any] = [
            "nombre": nombre,
            "alias": alias,
            "dimensionesref": [dimensionesref[0],dimensionesref[1],dimensionesref[2],dimensionesref[3],dimensionesref[4],dimensionesref[5],dimensionesref[6],dimensionesref[7]]
        ]
        
        db.collection("users").document(userData.uid).collection("hijos").document(docIDhijo).setData(docData) { err in
            if let err=err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        userData.hijosref.append(docIDhijo)
        userData.hijos[userData.hijos.count-1].nombre=nombre
        userData.hijos[userData.hijos.count-1].alias=alias
        userData.hijos[userData.hijos.count-1].dimensionesref=dimensionesref
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
    
    func crearDimensionesDefaultAndReturnDimensionesref(hijosref: String) -> [String]{
        var i = 0
        var docid = [String]()
        var dimensionesDefault = [Dimension]()

        while i<8 {
            docid.append(db.collection("users").document(userData.uid).collection("hijos").document(hijosref).collection("dimensiones").document().documentID)
            dimensionesDefault.append(Dimension())
            i = i + 1

        }
    
        let docData0: [String: Any] = [
            "nombre": "Deportes"
        ]
        dimensionesDefault[0].nombre="Deportes"
        
        let docData1: [String: Any] = [
            "nombre": "Académica"
        ]
        
        dimensionesDefault[1].nombre="Académica"
        
        let docData2: [String: Any] = [
            "nombre": "Cultural"
        ]
        dimensionesDefault[2].nombre="Cultural"
        
        let docData3: [String: Any] = [
            "nombre": "Musical"
        ]
        dimensionesDefault[3].nombre="Musical"
        
        let docData4: [String: Any] = [
            "nombre": "Espiritual"
        ]
        dimensionesDefault[4].nombre="Espiritual"
        
        let docData5: [String: Any] = [
            "nombre": "Cívico"
        ]
        dimensionesDefault[5].nombre="Cívico"
        
        let docData6: [String: Any] = [
            "nombre": "Viajero"
        ]
        dimensionesDefault[6].nombre="Viajero"
        
        let docData7: [String: Any] = [
            "nombre": "Otros"
        ]
        dimensionesDefault[7].nombre="Otros"
        
        db.collection("users").document(userData.uid).collection("hijos").document(hijosref).collection("dimensiones").document(docid[0]).setData(docData0) { err in
            if let err=err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        db.collection("users").document(userData.uid).collection("hijos").document(hijosref).collection("dimensiones").document(docid[1]).setData(docData1) { err in
            if let err=err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        db.collection("users").document(userData.uid).collection("hijos").document(hijosref).collection("dimensiones").document(docid[2]).setData(docData2) { err in
            if let err=err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        db.collection("users").document(userData.uid).collection("hijos").document(hijosref).collection("dimensiones").document(docid[3]).setData(docData3) { err in
            if let err=err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        db.collection("users").document(userData.uid).collection("hijos").document(hijosref).collection("dimensiones").document(docid[4]).setData(docData4) { err in
            if let err=err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        db.collection("users").document(userData.uid).collection("hijos").document(hijosref).collection("dimensiones").document(docid[5]).setData(docData5) { err in
            if let err=err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        db.collection("users").document(userData.uid).collection("hijos").document(hijosref).collection("dimensiones").document(docid[6]).setData(docData6) { err in
            if let err=err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        db.collection("users").document(userData.uid).collection("hijos").document(hijosref).collection("dimensiones").document(docid[7]).setData(docData7) { err in
            if let err=err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        userData.hijos.append(Hijo())
        userData.hijos[userData.hijos.count-1].dimensiones.append(contentsOf: dimensionesDefault)
        
        return docid
    }
    
    
    func agregarNuevoUsuario(uid: String, nombre: String, correo: String) {
        
        let docDataUser: [String: Any] = [
            "uid": uid,
            "premium": false,
            "colaborador": false,
            "nombre": nombre,
            "correo": correo,
            "hijosref": []
        ]
        
        db.collection("users").document(uid).setData(docDataUser)
    }
}
