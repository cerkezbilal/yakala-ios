//
//  ViewController.swift
//  yakala
//
//  Created by Bilal karademir on 14.04.2019.
//  Copyright © 2019 Bilal karademir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var surelabel: UILabel!
    
    @IBOutlet weak var enyuksekskorlabel: UILabel!
    @IBOutlet weak var skorlabel: UILabel!
    @IBOutlet weak var resim1: UIImageView!
    @IBOutlet weak var resim2: UIImageView!
    @IBOutlet weak var resim3: UIImageView!
    @IBOutlet weak var resim4: UIImageView!
    @IBOutlet weak var resim5: UIImageView!
    @IBOutlet weak var resim6: UIImageView!
    @IBOutlet weak var resim7: UIImageView!
    @IBOutlet weak var resim8: UIImageView!
    @IBOutlet weak var resim9: UIImageView!
    
    var score = 0
    //7)Timer sınıfından bir değişken oluşturalım
    var timer = Timer()
    var gorunmetimer = Timer()//Karakterlerin görünme süresi için timer 10. aşamanın B şıkkından sonra yapılacak
    var sure = 0//bunu 9 numaralı işlemden önce tanımlamalısın
    
    var karakterler = [UIImageView]()//10) işlemden önce karakterler için resim turunde dizi oluşturuyoruz
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //5)Skor değişkenini skorlabel a yazdırıyoruz..
        skorlabel.text = "Skor: \(score)"
        //12. aşamadan sonra burayı yaz
        let enyuksekpuan = UserDefaults.standard.object(forKey: "enyuksek")
        if(enyuksekpuan == nil){
            enyuksekskorlabel.text = "0"
            
        }
        if let yeniscore = enyuksekpuan as? Int {
            
            enyuksekskorlabel.text = String(yeniscore)
        }
        
        //1)Resimlere tıklandığında skor artması için recognizer tanımlıyoruz
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.SkorArttirma))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.SkorArttirma))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.SkorArttirma))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.SkorArttirma))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.SkorArttirma))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.SkorArttirma))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.SkorArttirma))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.SkorArttirma))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.SkorArttirma))
        //3)Resimlerin üzerine tıklanmasına izin veriyoruz
        resim1.isUserInteractionEnabled=true
        resim2.isUserInteractionEnabled=true
        resim3.isUserInteractionEnabled=true
        resim4.isUserInteractionEnabled=true
        resim5.isUserInteractionEnabled=true
        resim6.isUserInteractionEnabled=true
        resim7.isUserInteractionEnabled=true
        resim8.isUserInteractionEnabled=true
        resim9.isUserInteractionEnabled=true
        //4)Resimlerin hepsine 1.aşamada tanımladığımız recognizerleri tanımlıyoruz
        resim1.addGestureRecognizer(recognizer1)
        resim2.addGestureRecognizer(recognizer2)
        resim3.addGestureRecognizer(recognizer3)
        resim4.addGestureRecognizer(recognizer4)
        resim5.addGestureRecognizer(recognizer5)
        resim6.addGestureRecognizer(recognizer6)
        resim7.addGestureRecognizer(recognizer7)
        resim8.addGestureRecognizer(recognizer8)
        resim9.addGestureRecognizer(recognizer9)
        
        
        //8) Timer ı ayarlayalım
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.ZamanAzaltma), userInfo: nil, repeats: true)
       //bunu 9 numaralı işlemden önce tanımlamalısın..
        sure = 30;
        surelabel.text = "Süre: \(sure)"
        //11) resimlerin görünmesi için timer yarattık ve fonksiyonuna aşağıdaki karakterlerigizle yi tanımladık
         gorunmetimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(ViewController.KarakterleriGizle), userInfo: nil, repeats: true)
        
        
        //10 karakterlerin gizlenip görünmesi için..
        //A)resimleri bu diziye ekliyoruz
         karakterler.append(resim1)
         karakterler.append(resim2)
         karakterler.append(resim3)
         karakterler.append(resim4)
         karakterler.append(resim5)
         karakterler.append(resim6)
         karakterler.append(resim7)
         karakterler.append(resim8)
         karakterler.append(resim9)
        
        KarakterleriGizle()//Fonksiyon çalışması için çağırıyoruz
        
        
    }
    
    //B) 10. aşama için fonksiyon tanımlıyoruz resimler restgele görünsün diye
    @objc func KarakterleriGizle(){
        
        for karakter in karakterler{
            
            karakter.isHidden=true//karakterler gizleniyor
            
        }
        let random = Int( arc4random_uniform(UInt32(karakterler.count - 1)))//random bir sayı üretiyoruz
        karakterler[random].isHidden = false//bu random sayının o dizideki karşılığındaki resmi görünür yapıyoruz
        
       
        
        
    }
    
    
    //9)Timer için fonksiyon tanımlayalım ve yukarıdaki selector a bunu atayalım. en yukarıda bir zaman değişkeni oluşturalım
    @objc func ZamanAzaltma(){
        sure = sure - 1
        surelabel.text = "Süre: \(sure)"
        if sure == 0{
            //Eğer zaman sıfır olduysa timer durdur
            timer.invalidate()
            gorunmetimer.invalidate()
            for karakter in karakterler{
                
                karakter.isHidden=true//karakterler gizleniyor
                
            }
            
            
            
            //12)En yüksek skoru kaydetme
            
            if self.score > Int(enyuksekskorlabel.text!)!{
                
                UserDefaults.standard.set(self.score, forKey: "enyuksek")
                enyuksekskorlabel.text = String(self.score)
            }
            
            
            
            //Zaman dolarsa kullanıcıya uyarı vermek için..
            let alert = UIAlertController(title: "Oyun Bitti!!", message: "Süreniz doldu", preferredStyle: UIAlertController.Style.alert)
            let tamambutton = UIAlertAction(title: "Çıkış", style: UIAlertAction.Style.default, handler:{(UIAlertAction)
                in
                
              self.KarakterGizleme()
                self.dismiss(animated: true, completion: nil)
            })
           
           
            //11)Yeniden oynama için..
            let resetbuton = UIAlertAction(title: "Oyna", style: UIAlertAction.Style.default, handler: {(UIAlertAction)
                in
                self.score = 0;
                self.skorlabel.text = "Puan: \(self.score)"
                self.sure = 30
                self.surelabel.text="Süre: \(self.sure)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.ZamanAzaltma), userInfo: nil, repeats: true)
                self.gorunmetimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(ViewController.KarakterleriGizle), userInfo: nil, repeats: true)
                
            })
            

                
             alert.addAction(resetbuton)
             alert.addAction(tamambutton)
             self.present(alert,animated: true,completion: nil)
            
        }
    }
    @objc func KarakterGizleme(){
        
        for karakter in karakterler{
            
            karakter.isHidden=true//karakterler gizleniyor
            
        }
    }
    
    
    
    //2)Skort arttırması için bu metodu tanımlıyoruz
    @objc func SkorArttirma(){
        score = score+1;
        //6)Her skor arttığında skor ekrana yansıması için
         skorlabel.text = "Puan: \(score)"
    }


}

