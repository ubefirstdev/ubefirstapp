//
//  LoadDataToFirestore.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 03/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import Foundation

class LoadDataToFirestore {
    
    func agregarHijoNuevo(alias: String, childOf: String, dimensionesref: [String], nombre: String){
        let docid = db.collection("hijos").document().documentID
        
        let docData: [String: Any] = [
            "nombre": nombre,
            "alias": alias,
            "childOf": childOf
        ]
        
        db.collection("hijos").document(docid).setData(docData) { err in
            if let err=err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func guarddocTest(){
        var i = 0
        
        while(i<userData.hijosref.count){
            db.collection("users").document("test").setData(["hijosref": [userData.hijosref[i]]], merge: true)
            i = i + 1
        }
        
    }
    
    func makeStringFromArray(StringsArray: [String]) -> String{
        var i = 0
        var string = ""
        let c = userData.hijosref[0].description

        while (i<StringsArray.count){
            string = string + StringsArray[i].description
            if (i<StringsArray.count-1){
                string = string + ","
            }
            i = i + 1
        }
        
        return string
    }
    
    
    
    
}
