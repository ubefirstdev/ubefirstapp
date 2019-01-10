//
//  LoadingPageViewController.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 29/12/18.
//  Copyright © 2018 roman. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FBSDKLoginKit
import FirebaseAuth

let db = Firestore.firestore()
var userUID: String!
var userData = Padre()

class LoadingPageViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var indexHijos=0
    var indexDimension=0
    var indexRecuerdo=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userData.uid=Auth.auth().currentUser?.uid
        /*userData.correo=Auth.auth().currentUser?.email
        userData.nombre=Auth.auth().currentUser?.displayName*/
        self.progressBar.progress=0.0
        self.activityIndicator.startAnimating()
        self.loadDataPadre()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    public func userExists() -> Bool{
        var r = false
        db.collection("users").whereField("uid", isEqualTo: userData.uid).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else if ((querySnapshot?.isEmpty)!){
                    print("usuario no existe")
                    r=false
                }else {
                    print("usuario existe")
                    r=true
                }
        }

        
        return r
    }
    
    public func loadDataPadre(){
        db.collection("users").document(userData.uid).getDocument{(document, error) in
            if error != nil {
                print(error!)
            }else if ((document?.exists == false)) {
                print("usuario no existe")
                let d = LoadDataToFirestore()
                d.agregarNuevoUsuario(uid: userData.uid, nombre: userData.nombre, correo: userData.correo)
                self.activityIndicator.stopAnimating()
                self.progressBar.progress=1
                OperationQueue.main.addOperation {
                    [weak self] in
                    self?.performSegue(withIdentifier: "LoadingPageToHome", sender: self)
                }
            }else{
                userData.nombre = document?.data()!["nombre"] as? String
                userData.correo = document?.data()!["correo"] as? String
                userData.hijosref = document?.data()!["hijosref"] as? [String]
                userData.premium = document?.data()!["premium"] as? Bool
                userData.colaborador = document?.data()!["colaborador"] as? Bool
                
                if (userData.hijosref.isEmpty){
                    self.activityIndicator.stopAnimating()
                    self.progressBar.progress=1
                    OperationQueue.main.addOperation {
                        [weak self] in
                        self?.performSegue(withIdentifier: "LoadingPageToHome", sender: self)
                    }
                } else {
                    self.progressBar.progress=0.25
                    self.loadDataHijos()
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
                    self.loadDataHijos()
                }else{
                    self.indexHijos=0
                    self.progressBar.progress=0.50
                    self.loadDimensionesData()
                }
            }
            
        })
        
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
                    self.loadDimensionesData()
                }else{
                    self.indexDimension=0
                    self.indexHijos=self.indexHijos+1
                    if (self.indexHijos<userData.hijos.count){
                        self.loadDimensionesData()
                    }else{
                        self.indexDimension=0
                        self.indexHijos=0
                        self.progressBar.progress=0.75
                        self.loadRecuerdosData()
                    }
                }
            }
            
        })
        
    }
    
    public func loadRecuerdosData(){
            //arreglar falla que ocasiona un error si una dimension no tiene ningun recuerdo
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
                    self.loadRecuerdosData()
                }else{
                    self.indexRecuerdo=0
                    self.indexDimension=self.indexDimension+1
                    if (self.indexDimension<userData.hijos[self.indexHijos].dimensiones.count){
                        self.loadRecuerdosData()
                    }else{
                        self.indexHijos=self.indexHijos+1
                        self.indexDimension=0
                        self.indexRecuerdo=0
                        if(self.indexHijos<userData.hijos.count){
                            self.loadRecuerdosData()
                        }else{
                            self.indexDimension=0
                            self.indexHijos=0
                            self.indexRecuerdo=0
                            self.activityIndicator.stopAnimating()
                            self.progressBar.progress=1
                            OperationQueue.main.addOperation {
                                [weak self] in
                                self?.performSegue(withIdentifier: "LoadingPageToHome", sender: self)
                            }
                        }
                    }
                }
            }
        })
    }
}
