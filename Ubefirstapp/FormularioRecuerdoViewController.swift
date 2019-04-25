//
//  FormularioRecuerdoViewController.swift
//  Ubefirst
//
//  Created by MariaJose De la Fuente on 29/12/18.
//  Copyright © 2018 Roman Falcon. All rights reserved.
//

import UIKit
import AWSS3

class FormularioRecuerdoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var imageview_previaImagen: UIImageView!
    @IBOutlet weak var textField_nombreRecuerdo: UITextField!
    @IBOutlet weak var textField_ubicacionRecuerdo: UITextField!
    @IBOutlet weak var textField_descripcionRecuerdo: UITextView!
    @IBOutlet weak var picker_persona: UIPickerView!
    @IBOutlet weak var picker_dimension: UIPickerView!
    @IBOutlet weak var picker_fecha: UIDatePicker!
    var indexPersona = 0
    var indexDimension = 0
    var folderPath = ""

    @IBAction func btnPressed_agregarRecuerdo(_ sender: Any) {
        
        if(validar(str: self.textField_nombreRecuerdo.text!)&&validar(str: self.textField_ubicacionRecuerdo.text!)&&validar(str: self.textField_descripcionRecuerdo.text!)){
            
            
            var docData: [String: Any] = [:]
            self.picker_fecha.datePickerMode = UIDatePicker.Mode.date
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "es")
            dateFormatter.dateFormat = "dd MMM yyyy"
            let selectedDate = dateFormatter.string(from: self.picker_fecha.date)
            
            //Se inicia la estructura en donde sera guardara en aws y se sobreescribe en folderPath que es donde se tendra la informacion de acceso de la imagen en firebase hacia aws
            CrearCarpetaRecuerdo()
            
            docData = [
                "titulo": self.textField_nombreRecuerdo.text!,
                "hijo": userData.hijos[self.indexPersona].nombre,
                "dimension": userData.hijos[self.indexPersona].dimensiones[self.indexDimension].nombre,
                "fecha": selectedDate,
                "ubicacion": self.textField_ubicacionRecuerdo.text!,
                "descripcion": self.textField_descripcionRecuerdo.text,
                "elementospath": folderPath
            ]
            
            //aqui iria el codigo para poder subir elementos a dropbox, en esta parte del codigo es donde se realiza la creacion de un nuevo recuerdo
            //Se debe crear la carpeta y luego se debe subir la imagen en esa carpeta
            
            SubirImagenACarpeta()
            
            //se agrega el recuerdo al objeto padre
            let recuerdoNuevo  = Recuerdo()
            recuerdoNuevo.titulo = self.textField_nombreRecuerdo.text
            recuerdoNuevo.hijo = userData.hijos[self.indexPersona].nombre
            recuerdoNuevo.dimension = userData.hijos[self.indexPersona].dimensiones[self.indexDimension].nombre
            recuerdoNuevo.fecha = selectedDate
            recuerdoNuevo.ubicacion = self.textField_ubicacionRecuerdo.text!
            recuerdoNuevo.descripcion = self.textField_descripcionRecuerdo.text
            recuerdoNuevo.elementospath = folderPath
            
            userData.hijos[self.indexPersona].dimensiones[self.indexDimension].recuerdos.append(recuerdoNuevo)
            
            db.collection("hijos").document(userData.hijosref[self.indexPersona]).collection("dimensiones").document(userData.hijos[self.indexPersona].dimensionesref[self.indexDimension]).collection("recuerdos").document().setData(docData)
            self.navigationController?.popViewController(animated: true)
            
        }
        else{
            //Se indica que el campo esta incompleto
            let alertController = UIAlertController(title: "Error en registro", message: "Favor de llenar todos los campos", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker_persona.delegate = self
        self.picker_persona.dataSource = self
        self.picker_dimension.delegate = self
        self.picker_dimension.dataSource = self
        self.imageview_previaImagen.image = imagenRecuerdoBuffer
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField_nombreRecuerdo.resignFirstResponder()
        self.textField_ubicacionRecuerdo.resignFirstResponder()
        self.textField_descripcionRecuerdo.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var r = 0
        if (pickerView==self.picker_persona){
            r = userData.hijos.count
        }
        else if (pickerView==self.picker_dimension){
            r = userData.hijos[self.indexPersona].dimensiones.count
        }
        return r
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView==self.picker_persona){
            return userData.hijos[row].nombre
        } else {
            return userData.hijos[self.indexPersona].dimensiones[row].nombre
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView==self.picker_persona){
            self.indexPersona = row
        }else{
            self.indexDimension = row
        }
        self.picker_dimension.reloadAllComponents()
    }
    
    
    func CrearCarpetaRecuerdo(){
            let hijo = userData.hijos[self.indexPersona].nombre!
            let dimension = userData.hijos[self.indexPersona].dimensiones[self.indexDimension].nombre!
            let recuerdo = self.textField_nombreRecuerdo.text!
            let user = userData.uid!
            folderPath = user+"/"+hijo+"/"+dimension+"/"+recuerdo+".png"
        }
    
    func SubirImagenACarpeta(){
        
        guard let image = imageview_previaImagen.image else {return}
        if let data = image.pngData(){
            DispatchQueue.main.async(execute: {
                let transferUtility = AWSS3TransferUtility.default()
                let S3BucketName = "innomakers.ubefirst"
                let expression = AWSS3TransferUtilityUploadExpression()
                
                transferUtility.uploadData(data, bucket: S3BucketName, key: self.folderPath, contentType: "image/png", expression: expression) { (task, error) in
                    if let error = error{
                        print(error.localizedDescription)
                        return
                    }
                    //MENSAJE COMO EN CUENTA CREADA CON EXITOself.statusLabel.text = "uploaded successfully"
                    
                    
                }
            })
        }
    }
    
    func validar(str: String) -> Bool{return !(str=="")}
}


