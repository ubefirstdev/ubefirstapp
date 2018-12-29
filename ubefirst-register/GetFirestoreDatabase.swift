//
//  AppClass.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 27/12/18.
//  Copyright © 2018 roman. All rights reserved.
//
import Firebase

class GetFirestoreDatabase{
    
    public func loadDataPadre(){
        /*db.collection("users").whereField("correo", isEqualTo: "dev@ubefirst.app").limit(to: 1).getDocuments{(snapshot, error) in
            if error != nil {
                print(error!)
            }else {
                for document in (snapshot?.documents)!{
                    let name = document.data()["nombre"] as? String
                    print(name!)
                }
            }
        }*/
        db.collection("users").whereField("correo", isEqualTo: "dev@ubefirst.app").limit(to: 1).getDocuments{(snapshot, error) in
            if error != nil {
                print(error!)
            }else {
                for document in (snapshot?.documents)!{
                    let name = document.data()["nombre"] as? String
                    print(name!)
                }
            }
        }
       
    }
    
    public func loadDataHijos(){
        db.collection("hijos").whereField("childOf", isEqualTo: "dev@ubefirst.app").limit(to: 1).getDocuments{(snapshot, error) in
            if error != nil {
                print(error!)
            }else {
                for document in (snapshot?.documents)!{
                    let name = document.data()["dimensionesref"] as? [String]
                    print(name!)
                }
            }
        }
        
        //var ref: DatabaseReference!
        /*ref.child("padres").queryEqual(toValue: "luisalbertolivamedina@hotmail.com", childKey: "correo").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let nombre = value?["correo"] as? String ?? ""
            print(nombre)
        }) { (error) in
            print(error.localizedDescription)
        }*/

    }
}




