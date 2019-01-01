//
//  AppClass.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 27/12/18.
//  Copyright © 2018 roman. All rights reserved.
//
/*import Firebase

class GetFirestoreDatabase{

    var indexHijos=0
    var indexDimension=0
    var indexRecuerdo=0
    
    public func loadDataPadre(){
        
        db.collection("users").whereField("uid", isEqualTo: userData.uid).limit(to: 1).getDocuments{(snapshot, error) in
            if error != nil {
                print(error!)
            }else {
                for document in (snapshot?.documents)!{
                    userData.nombre = document.data()["nombre"] as? String
                    userData.correo = document.data()["correo"] as? String
                    userData.hijosref = document.data()["hijosref"] as? [String]
                    
                    if (userData.hijosref.isEmpty){
                    } else {
                        database.loadDataHijos()
                    }
                }
            }
        }
        
    }
    
    public func loadDataHijos(){
            db.collection("hijos").document(userData.hijosref[self.indexHijos]).getDocument(completion: {(document, error) in
                if error != nil {
                    print(error)
                } else {
                    let hijotemp = Hijo()
                    hijotemp.nombre = document?.data()!["nombre"] as? String
                    hijotemp.alias = document?.data()!["alias"] as? String
                    hijotemp.dimensionesref = document?.data()!["dimensionesref"] as? [String]
                    userData.hijos.append(hijotemp)
                    self.indexHijos=self.indexHijos+1
                    
                    if (self.indexHijos<userData.hijosref.count){
                        database.loadDataHijos()
                    }else{
                        self.indexHijos=0
                        database.loadDimensionesData()
                    }
                }
                
            })
            /*db.collection("hijos").whereField("childOf", isEqualTo: "dev@ubefirst.app").limit(to: 1).getDocuments{(snapshot, error) in
                if error != nil {
                    print(error!)
                }else {
                    for document in (snapshot?.documents)!{
                        let name = document.data()["dimensionesref"] as? [String]
                        print(name!)
                    }
                }
            }*/
        
        
        //var ref: DatabaseReference!
        /*ref.child("padres").queryEqual(toValue: "luisalbertolivamedina@hotmail.com", childKey: "correo").observeSingleEvent(of: .value, with: {(snapshot) in
         let value = snapshot.value as? NSDictionary
         let nombre = value?["correo"] as? String ?? ""
         print(nombre)
         }) { (error) in
         print(error.localizedDescription)
         }*/
        
    }
    
    public func loadDimensionesData(){
        db.collection("dimensiones").document(userData.hijos[self.indexHijos].dimensionesref[self.indexDimension]).getDocument(completion: {(document, error) in
            if error != nil {
                print(error)
            } else {
                let dimensionTemp = Dimension()
                dimensionTemp.nombre = document?.data()!["nombre"] as? String
                dimensionTemp.recuerdosref = document?.data()!["recuerdosref"] as? [String]
                userData.hijos[self.indexHijos].dimensiones.append(dimensionTemp)
                self.indexDimension=self.indexDimension+1

                if (self.indexDimension<userData.hijos[self.indexHijos].dimensionesref.count){
                    database.loadDimensionesData()
                }else{
                    self.indexDimension=0
                    self.indexHijos=self.indexHijos+1
                    if (self.indexHijos<userData.hijos.count){
                        database.loadDimensionesData()
                    }else{
                        self.indexDimension=0
                        self.indexHijos=0
                        database.loadRecuerdosData()
                    }
                }
            }
            
        })
        
    }
    
    public func loadRecuerdosData(){
        db.collection("recuerdos").document(userData.hijos[self.indexHijos].dimensiones[self.indexDimension].recuerdosref[self.indexRecuerdo]).getDocument(completion: {(document, error) in
            if error != nil {
                print(error)
            } else {
                let recuerdoTemp = Recuerdo()
                recuerdoTemp.titulo = document?.data()!["titulo"] as? String
                recuerdoTemp.hijo = document?.data()!["hijo"] as? String
                recuerdoTemp.dimension = document?.data()!["dimension"] as? String
                recuerdoTemp.fecha = document?.data()!["fecha"] as? String
                recuerdoTemp.ubicacion = document?.data()!["ubicacion"] as? String
                recuerdoTemp.elementosref = document?.data()!["elementosref"] as? [String]
                userData.hijos[self.indexHijos].dimensiones[self.indexDimension].recuerdos.append(recuerdoTemp)
                self.indexRecuerdo=self.indexRecuerdo+1
                
                if (self.indexRecuerdo<userData.hijos[self.indexHijos].dimensiones[self.indexDimension].recuerdosref.count){
                    database.loadRecuerdosData()
                }else{
                    self.indexRecuerdo=0
                    self.indexDimension=self.indexDimension+1
                    if (self.indexDimension<userData.hijos[self.indexHijos].dimensiones.count){
                        database.loadRecuerdosData()
                    }else{
                        self.indexHijos=self.indexHijos+1
                        self.indexDimension=0
                        self.indexRecuerdo=0
                        if(self.indexHijos<userData.hijos.count){
                            database.loadRecuerdosData()
                        }else{
                            self.indexDimension=0
                            self.indexHijos=0
                            self.indexRecuerdo=0
                        }
                        
                    }
                }
            }
            
        })
        
        
    }
    

}
*/

//userData.hijos[self.indexHijos].dimensiones[self.indexDimension].recuerdosref[self.indexRecuerdo]


