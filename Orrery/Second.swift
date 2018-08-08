//
//  ViewController.swift
//  Orrery
//
//  Created by Derrick Huth on 16/08/2017.
//  Copyright © 2017 Derrick Huth. All rights reserved.
//

import UIKit

class Second: UIViewController {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var Sun: UIImageView!
    @IBOutlet weak var Earth: UIImageView!
    @IBOutlet weak var Shuttle1: UIImageView!
    @IBOutlet weak var Shuttle2: UIImageView!
    @IBOutlet weak var Orbit: UIImageView!
    @IBOutlet weak var Mars: UIImageView!
    
    
    @IBOutlet weak var EarthAngle: UILabel!
    @IBOutlet weak var Shuttle1Angle: UILabel!
    @IBOutlet weak var Shuttle2Angle: UILabel!
    @IBOutlet weak var OrbitAngle: UILabel!
    @IBOutlet weak var MarsAngle: UILabel!
    @IBOutlet weak var EarthMarsAngle: UILabel!
    
    
    @IBOutlet weak var EM1: UIImageView!
    @IBOutlet weak var EM2: UIImageView!
    @IBOutlet weak var EM3: UIImageView!
    @IBOutlet weak var EM4: UIImageView!
    @IBOutlet weak var EM5: UIImageView!
    @IBOutlet weak var EM6: UIImageView!
    @IBOutlet weak var EM7: UIImageView!
    @IBOutlet weak var EM8: UIImageView!
    @IBOutlet weak var EMT1: UIImageView!
    @IBOutlet weak var EMT2: UIImageView!
    @IBOutlet weak var EMT3: UIImageView!
    @IBOutlet weak var EMT4: UIImageView!
    @IBOutlet weak var EMT4I: UIImageView!
    @IBOutlet weak var EMT5: UIImageView!
    @IBOutlet weak var EMT6: UIImageView!
    @IBOutlet weak var EMT7: UIImageView!
    @IBOutlet weak var EMT8: UIImageView!
    
    @IBOutlet weak var PauseButton: UIButton!
    
    @IBAction func Restart(_ sender: Any) {
        restart()
    }
    
    @IBAction func Pause(_ sender: Any) {
        pauseClicked()
    }
    
    @IBAction func Step(_ sender: Any) {
        stepPressed()
    }
    
    var timer = Timer()
    var earthAng: Double = 0.0
    var orbitAng: Double = 0.0
    var marsAng: Double = 0.0
    var minMarsRate: Double = 100000.0
    var maxMarsRate: Double = 0.0
    var s1: Double = 0.0
    var s2: Double = 0.0
    var oldS1: Double = 0.0
    var oldS2: Double = 0.0
    var oldEMT16: Double = 0.0
    
    var shuttle1Visible: Bool = false
    var shuttle2Visible: Bool = false
    
    var em1: Double = 0.0
    var em2: Double = 0.0
    var em3: Double = 0.0
    var em4: Double = 0.0
    var em5: Double = 0.0
    var em6: Double = 0.0
    var em7: Double = 0.0
    var em8: Double = 0.0
    var emt1: Double = 0.0
    var emt2: Double = 0.0
    var emt3: Double = 0.0
    var emt4: Double = 0.0
    var emt5: Double = 0.0
    var emt6: Double = 0.0
    var emt7: Double = 0.0
    var emt8: Double = 0.0

    var em1Rate: Double = 0.0
    var em2Rate: Double = 0.0
    var em3Rate: Double = 0.0
    var em4Rate: Double = 0.0

    var emt1Rate: Double = 0.0
    var emt2Rate: Double = 0.0
    var emt3Rate: Double = 0.0
    var emt34ToothRate: Double = 0.0
    var emt4Tooth: Double = 0.0
    var shuttleOffset: Double = 0.0
    
    var ticks: Int = 0
    var isPaused: Bool = false
    var isStepping: Bool = false
    
    var emt = [Double]()
    var dis = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ScrollView.contentSize = CGSize(width: 500, height: 2300)
        start()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pauseClicked() {
        if (isPaused) {
            PauseButton.setTitle("Pause", for: .normal)
        } else {
            PauseButton.setTitle("Continue", for: .normal)
        }
        isPaused = !isPaused
    }
    
    func stepPressed() {
        isStepping = true
        isPaused = false
    }
    
    func start() {
        earthAng = 0
        orbitAng = -75.14
        marsAng = -75.14
        
        shuttle1Visible = false
        shuttle2Visible = false
        
        em1 = 0
        em2 = 0
        em3 = 0
        em4 = 0
        em5 = 0
        em6 = 3
        em7 = 3
        em8 = 0
        emt1 = 0
        emt2 = 2.9
        emt3 = 4
        emt4 = 0
        emt5 = 0
        emt6 = 5
        emt7 = 4
        emt8 = 0

        em1Rate = -1
        em2Rate = 44 / 53
        em3Rate = 44 / 53
        em4Rate = -44 / 53 * 57 / 89
        
        emt1Rate = -1
        emt2Rate = 45 / 62
        emt3Rate = 45 / 62
        emt34ToothRate = -(45 / 62) / (360 / 51)
        
        emt4Tooth = 58.5
        shuttleOffset = -55
        
        ticks = 0
        isPaused = false
        
        emt = [Double]()
        dis = [Double]()
        
        var i = 0
        while (i < 81) {
            emt.append(0.0)
            dis.append(0.0)
            i += 1
        }
        
        emt[0] = 3.1
        emt[1] = 9.3
        emt[2] = 15.2
        emt[3] = 20.5
        emt[4] = 26.5
        emt[5] = 31
        emt[6] = 36
        emt[7] = 39.5
        emt[8] = 42
        emt[9] = 44
        emt[10] = 45
        emt[11] = 47
        emt[12] = 49
        emt[13] = 51
        emt[14] = 52
        emt[15] = 54
        emt[16] = 56
        emt[17] = 58
        emt[18] = 60
        emt[19] = 64
        emt[20] = 68
        emt[21] = 72
        emt[22] = 78
        emt[23] = 84
        emt[24] = 90
        emt[25] = 96
        emt[26] = 102
        emt[27] = 108
        emt[28] = 114
        emt[29] = 120
        emt[30] = 126
        emt[31] = 132
        emt[32] = 138
        emt[33] = 144
        emt[34] = 150
        emt[35] = 156
        emt[36] = 162
        emt[37] = 168
        emt[38] = 174
        emt[39] = 180
        
        dis[0] = 45
        dis[1] = 45
        dis[2] = 45
        dis[3] = 45
        dis[4] = 43
        dis[5] = 41
        dis[6] = 39
        dis[7] = 37
        dis[8] = 33
        dis[9] = 29.5
        dis[10] = 26
        dis[11] = 23
        dis[12] = 20
        dis[13] = 17
        dis[14] = 14
        dis[15] = 11
        dis[16] = 8
        dis[17] = 5
        dis[18] = 3
        dis[19] = 2
        dis[20] = 1
        dis[21] = 0
        dis[22] = 0
        dis[23] = 0
        dis[24] = 0
        dis[25] = 0
        dis[26] = 0
        dis[27] = 0
        dis[28] = 0
        dis[29] = 0
        dis[30] = 0
        dis[31] = 0
        dis[32] = 0
        dis[33] = 0
        dis[34] = 0
        dis[35] = 0
        dis[36] = 0
        dis[37] = 0
        dis[38] = 0
        dis[39] = 0
        
        i = 0
        while (i < 39) {
            emt[i + 40] = 360 - emt[38 - i]
            dis[i + 40] = dis[38 - i]
            i += 1
        }
        emt[79] = 363.1
        dis[79] = 45

        Shuttle1.alpha = 0.5
        Shuttle2.alpha = 0.5
        
        timer = Timer(timeInterval: 0.1, target: self, selector: #selector(Second.rotate), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    func restart() {
        earthAng = 0
        orbitAng = -75.14
        marsAng = -75.14
        
        shuttle1Visible = false
        shuttle2Visible = false
        
        em1 = 0
        em2 = 0
        em3 = 0
        em4 = 0
        em5 = 0
        em6 = 3
        em7 = 3
        em8 = 0
        emt1 = 0
        emt2 = 2.9
        emt3 = 4
        emt4 = 0
        emt5 = 0
        emt6 = 5
        emt7 = 4
        emt8 = 0

        em1Rate = -1
        em2Rate = 44 / 53
        em3Rate = 44 / 53
        em4Rate = -44 / 53 * 57 / 89
        
        emt1Rate = -1
        emt2Rate = 45 / 62
        emt3Rate = 45 / 62
        emt34ToothRate = -(45 / 62) / (360 / 51)

        //  Starting tooth for eliptical gear and orbiter offset
        emt4Tooth = 58.5
        shuttleOffset = -55
        
        Shuttle1.alpha = 0.5
        Shuttle2.alpha = 0.5
        
        ticks = 0
        isPaused = false
        PauseButton.setTitle("Continue", for: .normal)
    }
    
    func rotate() {
        if (!isPaused) {
            em1 += em1Rate
            em1 = (em1  + 360).truncatingRemainder(dividingBy: 360)
            EM1.transform = CGAffineTransform.identity
            EM1.transform = EM1.transform.rotated(by: CGFloat(em1 * (Double.pi * 2) / 360))
            Earth.transform = CGAffineTransform.identity
            Earth.transform = Earth.transform.rotated(by: CGFloat(em1 * (Double.pi * 2) / 360))
            
            em2 += em2Rate
            em2 = (em2 + 360).truncatingRemainder(dividingBy: 360)
            EM2.transform = CGAffineTransform.identity
            EM2.transform = EM2.transform.rotated(by: CGFloat(em2 * (Double.pi * 2) / 360))
            
            em3 += em3Rate
            em3 = (em3 + 360).truncatingRemainder(dividingBy: 360)
            EM3.transform = CGAffineTransform.identity
            EM3.transform = EM3.transform.rotated(by: CGFloat(em3 * (Double.pi * 2) / 360))
            
            em4 += em4Rate
            em4 = (em4 + 360).truncatingRemainder(dividingBy: 360)
            EM4.transform = CGAffineTransform.identity
            EM4.transform = EM4.transform.rotated(by: CGFloat(em4 * (Double.pi * 2) / 360))
            
            em5 += em4Rate
            em5 = (em5 + 360).truncatingRemainder(dividingBy: 360)
            EM5.transform = CGAffineTransform.identity
            EM5.transform = EM5.transform.rotated(by: CGFloat(em5 * (Double.pi * 2) / 360))
            
            em6 -= em4Rate
            em6 = (em6 + 360).truncatingRemainder(dividingBy: 360)
            EM6.transform = CGAffineTransform.identity
            EM6.transform = EM6.transform.rotated(by: CGFloat(em6 * (Double.pi * 2) / 360))
            
            em7 -= em4Rate
            em7 = (em7 + 360).truncatingRemainder(dividingBy: 360)
            EM7.transform = CGAffineTransform.identity
            EM7.transform = EM7.transform.rotated(by: CGFloat(em7 * (Double.pi * 2) / 360))
            
            em8 += em4Rate
            em8 = (em8 + 360).truncatingRemainder(dividingBy: 360)
            EM8.transform = CGAffineTransform.identity
            EM8.transform = EM8.transform.rotated(by: CGFloat(em8 * (Double.pi * 2) / 360))
            
            
            
            emt1 += emt1Rate
            emt1 = (emt1  + 360).truncatingRemainder(dividingBy: 360)
            EMT1.transform = CGAffineTransform.identity
            EMT1.transform = EMT1.transform.rotated(by: CGFloat(emt1 * (Double.pi * 2) / 360))
            
            emt2 += emt2Rate
            emt2 = (emt2 + 360).truncatingRemainder(dividingBy: 360)
            EMT2.transform = CGAffineTransform.identity
            EMT2.transform = EMT2.transform.rotated(by: CGFloat(emt2 * (Double.pi * 2) / 360))
            
            emt3 += emt3Rate
            emt3 = (emt3 + 360).truncatingRemainder(dividingBy: 360)
            EMT3.transform = CGAffineTransform.identity
            EMT3.transform = EMT3.transform.rotated(by: CGFloat(emt3 * (Double.pi * 2) / 360))
            
            emt4Tooth += emt34ToothRate + 79
            emt4Tooth = emt4Tooth.truncatingRemainder(dividingBy: 79)
            OrbitAngle.text = "Tooth: " + String(emt4Tooth)
            emt4 = emt[Int(emt4Tooth)] + ((emt[Int(emt4Tooth) + 1] - emt[Int(emt4Tooth)]) * (emt4Tooth - Double(Int(emt4Tooth))))
            let tCam = emt4 - 180
            EMT4.transform = CGAffineTransform.identity
            EMT4.transform = EMT4.transform.rotated(by: CGFloat(tCam * (Double.pi * 2) / 360))
            EMT4I.transform = CGAffineTransform.identity
            EMT4I.transform = EMT4I.transform.rotated(by: CGFloat(tCam * (Double.pi * 2) / 360))
            let diff1 = dis[Int(emt4Tooth) + 1] - dis[Int(emt4Tooth)]
            let diff2 = emt4Tooth - Double(Int(emt4Tooth))
            var offsetCam = dis[Int(emt4Tooth)] + (diff1 * diff2)
            offsetCam = 0.5 - (offsetCam / 230)
            EMT4.layer.anchorPoint = CGPoint(x: CGFloat(offsetCam), y: 0.5)

            let oldEmt5 = emt5
            emt5 = -emt4
            EMT5.transform = CGAffineTransform.identity
            EMT5.transform = EMT5.transform.rotated(by: CGFloat((180 - emt5) * (Double.pi * 2) / 360))
            
            var diff = emt5 - oldEmt5
            diff = (diff + 360).truncatingRemainder(dividingBy: 360)
            emt6 += diff * 69 / 58
            emt6 = (emt6  + 360).truncatingRemainder(dividingBy: 360)
            EMT6.transform = CGAffineTransform.identity
            EMT6.transform = EMT6.transform.rotated(by: CGFloat(emt6 * (Double.pi * 2) / 360))
            
            let oldEmt7 = emt7
            emt7 = emt6
            EMT7.transform = CGAffineTransform.identity
            EMT7.transform = EMT7.transform.rotated(by: CGFloat(emt6 * (Double.pi * 2) / 360))
            
            diff = emt7 - oldEmt7
            diff = (diff + 360).truncatingRemainder(dividingBy: 360)
            emt8 -= diff * 62 / 65
            emt8 = (emt8 + 360).truncatingRemainder(dividingBy: 360)
            EMT8.transform = CGAffineTransform.identity
            EMT8.transform = EMT8.transform.rotated(by: CGFloat(emt8 * (Double.pi * 2) / 360))
            
            s1 = emt8 - shuttleOffset
            s1 = (s1  + 363.6628).truncatingRemainder(dividingBy: 360)
            
            if (ticks % 768 == 55) {
                shuttle1Visible = true
                Shuttle1.alpha = 1.0
            }
            if (ticks % 768 == 338) {
                shuttle1Visible = false
                Shuttle1.alpha = 0.5
            }
            
            Shuttle1.transform = CGAffineTransform.identity
            Shuttle1.transform = Shuttle1.transform.rotated(by: CGFloat(s1 * (Double.pi * 2) / 360))
            if (shuttle1Visible) {
                Shuttle1.transform = Shuttle1.transform.scaledBy(x: 1.0, y: 1.0)
            } else {
                Shuttle1.transform = Shuttle1.transform.scaledBy(x: 0.75, y: 0.75)
            }
            oldS1 = s1
            s2 = s1 - 54
            s2 = (s2 + 360).truncatingRemainder(dividingBy: 360)
            
            if (ticks % 768 == 24) {
                shuttle2Visible = true
                Shuttle2.alpha = 1.0
            }
            if (ticks % 768 == 238) {
                shuttle2Visible = false
                Shuttle2.alpha = 0.5
            }
            
            Shuttle2.transform = CGAffineTransform.identity
            Shuttle2.transform = Shuttle2.transform.rotated(by: CGFloat(s2 * (Double.pi * 2) / 360))
            if (shuttle2Visible) {
                Shuttle2.transform = Shuttle2.transform.scaledBy(x: 1.0, y: 1.0)
            } else {
                Shuttle2.transform = Shuttle2.transform.scaledBy(x: 0.75, y: 0.75)
            }
            oldS2 = s2
            
            Orbit.transform = CGAffineTransform.identity
            Orbit.transform = Orbit.transform.rotated(by: CGFloat((em8 - 75.14 + 3.6628) * (Double.pi * 2) / 360))
            Mars.transform = CGAffineTransform.identity
            Mars.transform = Mars.transform.rotated(by: CGFloat((em8 - 75.14 + 3.6628) * (Double.pi * 2) / 360))
            
            EarthAngle.text = "Earth Angle: " + String(em1)
            Shuttle1Angle.text = "Shuttle1 Angle: " + String(s1)
            MarsAngle.text = "EMT4: " + String(emt4)
            OrbitAngle.text = "Tooth No: " + String(emt4Tooth)
            var angle = em1 - (em4 - 75.14 + 3.6628)
            if (angle < -180) {
                angle = angle + 360
            }
            if (angle > 180) {
                angle = angle - 360
            }
            EarthMarsAngle.text = "Earth - Mars Angle: " + String(angle)
            
            if (ticks == 0)
            {
                isPaused = true
            }
            ticks += 1
            if (isStepping) {
                isStepping = false
                isPaused = true
            }
        }
    }
}

