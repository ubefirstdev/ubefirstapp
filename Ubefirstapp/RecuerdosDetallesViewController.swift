//
//  RecuerdosDetallesViewController.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 10/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import UIKit
import SwiftyDropbox

class RecuerdosDetallesViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var lbl_titulo: UILabel!
    @IBOutlet weak var lbl_hijo: UILabel!
    @IBOutlet weak var lbl_dimension: UILabel!
    @IBOutlet weak var lbl_fecha: UILabel!
    @IBOutlet weak var lbl_ubicacion: UILabel!
    @IBOutlet weak var txtView_descripcion: UITextView!
    var filenames: Array<String>?
    var folderPath = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].titulo
        self.lbl_titulo.text = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].titulo
        self.lbl_hijo.text = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].hijo

        self.lbl_dimension.text = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].dimension
        self.lbl_fecha.text = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].fecha
        self.lbl_ubicacion.text = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].ubicacion
        self.txtView_descripcion.text = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].descripcion
        folderPath = userData.hijos[lastPersonIndexTap].dimensiones[lastIndexDimensionTap].recuerdos[lastRecuerdoIndexTap].elementospath

        // Do any additional setup after loading the view.
        
        //MOSTARLAIMAGEN QUE ESTE EN SU PATH
        self.filenames = []
        //Aqui carga la imagen pero deberian ser thumbnails y por lo pronto solo aguanta una que ya luego nos permita ver en pantalla completa
        if let client = DropboxClientsManager.authorizedClient {
            client.files.listFolder(path: folderPath).response { response, error in
                if let result = response {
                    print("Folder contents:")
                    for entry in result.entries {
                        print(entry.name)
                        self.filenames?.append(entry.name)
                    }
                    if ((self.filenames?.count)!>0){
                        // Download a file
                        client.files.download(path: self.folderPath+"/"+(self.filenames?.first)!).response { response, error in
                            if let (metadata, archivo) = response {
                                print("Dowloaded file name: \(metadata.name)")
                                print("Downloaded file data: \(archivo)")
                                self.imageView.image=UIImage(data:archivo)
                            } else {
                                print(error!)
                            }
                        }
                            .progress { progressData in
                                print(progressData)}
                    }
                }
            }
            /*
            client.files.download(path: folderPath+"/"+(filenames?.first!)!)
                .response { response, error in
                    if let response = response {
                        let responseMetadata = response.0
                        print(responseMetadata)
                        let fileContents = response.1
                        print(fileContents)
                    } else if let error = error {
                        print(error)
                    }
                    print(self.folderPath)
                    let imageUIImage: UIImage = UIImage(data: (response?.1)!)!

                    self.imageView.image=imageUIImage
                    
                }
                .progress { progressData in
                    print(progressData)
            }
        }
        // Download a file
        client.filesDownload(path: "/hello.txt").response { response, error in
            if let (metadata, data) = response {
                println("Dowloaded file name: \(metadata.name)")
                println("Downloaded file data: \(data)")
                self.imageView.image=UIImage=UIImage(data:data)
            } else {
                println(error!)
            }
 */
        }
    }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

