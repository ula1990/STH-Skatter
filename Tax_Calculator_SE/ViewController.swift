//
//  ViewController.swift
//  Tax_Calculator_SE
//
//  Created by Ulad Daratsiuk-Demchuk on 7/9/17.
//  Copyright © 2017 Ulad Daratsiuk. All rights reserved.
//

import UIKit
import ObjectiveC
import Foundation




@objc class ViewController: UIViewController {
    
    


    @IBOutlet weak var output: UILabel!

    @IBOutlet weak var input: UILabel!
    
    @IBOutlet weak var taxLbl: UILabel!
    
    @IBOutlet weak var nettLabel: UILabel!
    
    @IBOutlet weak var taxResultLbl: UILabel!
    
    @IBOutlet weak var incomeLbl: UILabel!
    
    @IBOutlet weak var addInfo: UILabel!
    
    @IBOutlet weak var annualLbl: UILabel!
    
    
    //USER DEFAULTS
    
    let defaults = UserDefaults.standard
    let taxL = "taxL"
    let nettL = "nettL"
    let addI = "addI"
    let outputL = "outputL"

    
    //PART0 Coefficients for Netto and Tax
    
    var stillTyping = false

    var taxPercent = [0.15528, 0.15969, 0.16370, 0.1674,0.170,0.1742,0.1772, 0.180125,0.1827,0.18529,0.187714,0.18994,0.19205,0.19410,0.196,0.1978,0.19956,0.20119,0.20274,0.20427,0.20568,0.20704,0.20838,0.209625,0.210857,0.212,0.21309,0.2141,0.21520,0.216185,0.217163,0.21807,0.21894,0.219827,0.22064,0.221433,0.22236,0.223645,0.22488,0.22609,0.227230,0.22836,0.229462,0.230529,0.231536,0.23254,0.2335211,0.2344722,0.23536,0.23627,0.237146,0.239710,0.24309,0.246410,0.24964,0.2528,0.255851,0.25885,0.261783,0.26464,0.267411,0.270139,0.27280,0.275409,0.2779325,0.280422,0.28285,0.28523,0.2875483,0.28982,0.292063,0.29425,0.296371,0.2984693,0.30052,0.30254,0.304495,0.306431,0.308330,0.310192,0.312,0.31379,0.31555,0.317277,0.319137,0.3212545,0.32331,0.32535,0.3273628,0.32933,0.331252,0.333155,0.335025,0.3368644,0.338655,0.340433,0.34218,0.343901,0.345577,0.347241,0.34888,0.35049,0.352062,0.353625,0.3551627,0.356676,0.35815,0.3596212,0.361067,0.3624925,0.3638814,0.365264,0.366627,0.3679710,0.36928,0.37058,0.3718723,0.3731408,0.374377,0.375611,0.376827,0.378027,0.37919,0.380364,0.381516,0.38265,0.38376,0.38486,0.38596,0.387038,0.3880903,0.38914,0.39017,0.39120,0.392201,0.3932,0.394186,0.395160,0.3961104,0.39706,0.398,0.39892,0.39983,0.400738,0.401633,0.402517,0.4033801,0.40424,0.4050982,0.405942,0.406765,0.4075909,0.408406,0.409213,0.41,0.410788,0.411569,0.41234,0.413092,0.41384,0.41459,0.41533,0.416053,0.41677,0.41749,0.4182,0.41889,0.419583,0.420269,0.420948,0.421610,0.42227551,0.42293,0.42358,0.42422,0.42486,0.425492,0.426118]
    
    var nettoPercent = [0.84472, 0.84030, 0.83629, 0.832, 0.829, 0.8258, 0.8227,0.819875,0.81721,0.81470, 0.812285,0.81005,0.80794,0.805894,0.804,0.8022,0.8004,0.79880,0.79725,0.79572,0.79431,0.79295,0.79161,0.790375,0.78914,0.788,0.78690,0.78580,0.784792,0.78381,0.78283,0.78192,0.78105,0.78017,0.779355,0.778566,0.777639,0.776354,0.77511,0.77390,0.772769,0.77163,0.770537,0.769470,0.76846,0.767457,0.7664788,0.76552,0.764630,0.763729,0.762853,0.7602894,0.756909,0.75358,0.7503544,0.7472,0.74414,0.74114,0.73821,0.735357,0.73258,0.729860,0.72719,0.7245909,0.7220674,0.71957,0.71714,0.714760,0.712451,0.710170,0.707936,0.70575,0.7036288,0.7015306,0.69947,0.69746,0.695504,0.69356,0.691669,0.68980,0.688,0.68620,0.68444,0.68272,0.68086,0.678745,0.676684,0.67464,0.672637,0.67066,0.66874,0.666844,0.66497,0.663135,0.661344,0.65956,0.657818,0.656098,0.654422,0.65275,0.65112,0.64950,0.64793,0.646375,0.64483,0.64332,0.64184,0.6403787,0.63893,0.637507,0.63611851,0.634735,0.633372,0.63202,0.630719,0.629414,0.628127,0.626859,0.625622,0.624388,0.623172,0.621972,0.620802,0.6196351,0.61848,0.617346,0.61623,0.61513,0.614039,0.61296,0.6119096,0.61085,0.609821,0.6087974,0.607798,0.6068,0.6058136,0.604839,0.603889,0.602939,0.602,0.60107,0.600167,0.59926,0.59836,0.59748235,0.596619,0.59575,0.59490,0.59405,0.59323,0.592409,0.591593,0.590786,0.59,0.58921,0.588430,0.587659,0.586907,0.5861,0.585405,0.58466,0.58394,0.58322,0.58250,0.5818,0.581109,0.58041,0.579730,0.57905,0.578389,0.577724,0.577065,0.57641,0.57577,0.57514,0.57450,0.573881]
    
    @IBAction func numButton(_ sender: UIButton) {
        
          let number = sender.currentTitle!

                if stillTyping{
                        if (input.text?.count)! < 5 {
        
                            input.text = input.text! + number
        //PART1 to Calculate Netto amount
                           func sum()->Int{
                                let b = Int(input.text!)
                                if b! < 12501 {
                                    let result = nettoPercent[0]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 13001 && b! >= 12501{
                                    let result = nettoPercent[1]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 13501 && b! >= 13001{
                                    let result = nettoPercent[2]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 14001 && b! >= 12501{
                                    let result = nettoPercent[3]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 14501 && b! >= 14001{
                                    let result = nettoPercent[4]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 15001 && b! >= 14501{
                                    let result = nettoPercent[5]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 15501 && b! >= 15001{
                                    let result = nettoPercent[6]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 16001 && b! >= 15501{
                                    let result = nettoPercent[7]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 16501 && b! >= 16001{
                                    let result = nettoPercent[8]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 17001 && b! >= 16501{
                                    let result = nettoPercent[9]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 17501 && b! >= 17001{
                                    let result = nettoPercent[10]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 18001 && b! >= 17501{
                                    let result = nettoPercent[11]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 18501 && b! >= 18001{
                                    let result = nettoPercent[12]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 19001 && b! >= 18501{
                                    let result = nettoPercent[13]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 19501 && b! >= 19001{
                                    let result = nettoPercent[14]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 20001 && b! >= 19501{
                                    let result = nettoPercent[15]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 20501 && b! >= 20001{
                                    let result = nettoPercent[16]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 21001 && b! >= 20501{
                                    let result = nettoPercent[17]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 21501 && b! >= 21001{
                                    let result = nettoPercent[18]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 22001 && b! >= 21501{
                                    let result = nettoPercent[19]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 22501 && b! >= 22001{
                                    let result = nettoPercent[20]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 23001 && b! >= 22501{
                                    let result = nettoPercent[21]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 23501 && b! >= 23001{
                                    let result = nettoPercent[22]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 24001 && b! >= 23501{
                                    let result = nettoPercent[23]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 24501 && b! >= 24001{
                                    let result = nettoPercent[24]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 25001 && b! >= 24501{
                                    let result = nettoPercent[25]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 25501 && b! >= 25001{
                                    let result = nettoPercent[26]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 26001 && b! >= 25501{
                                    let result = nettoPercent[27]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 26501 && b! >= 26001{
                                    let result = nettoPercent[28]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 27001 && b! >= 26501{
                                    let result = nettoPercent[29]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 27501 && b! >= 27001{
                                    let result = nettoPercent[30]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 28001 && b! >= 27501{
                                    let result = nettoPercent[31]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 28501 && b! >= 28001{
                                    let result = nettoPercent[32]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 29001 && b! >= 28501{
                                    let result = nettoPercent[33]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 29501 && b! >= 29001{
                                    let result = nettoPercent[34]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 30001 && b! >= 29501{
                                    let result = nettoPercent[35]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 30501 && b! >= 30001{
                                    let result = nettoPercent[36]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 31001 && b! >= 30501{
                                    let result = nettoPercent[37]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 31501 && b! >= 31001{
                                    let result = nettoPercent[38]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 32001 && b! >= 31501{
                                    let result = nettoPercent[39]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 32501 && b! >= 32001{
                                    let result = nettoPercent[40]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 33001 && b! >= 32501{
                                    let result = nettoPercent[41]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 33501 && b! >= 33001{
                                    let result = nettoPercent[42]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 34001 && b! >= 33501{
                                    let result = nettoPercent[43]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 34501 && b! >= 34001{
                                    let result = nettoPercent[44]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 35001 && b! >= 34501{
                                    let result = nettoPercent[45]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 35501 && b! >= 35001{
                                    let result = nettoPercent[46]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 36001 && b! >= 35501{
                                    let result = nettoPercent[47]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 36501 && b! >= 36001{
                                    let result = nettoPercent[48]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 37001 && b! >= 36501{
                                    let result = nettoPercent[49]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 37501 && b! >= 37001{
                                    let result = nettoPercent[50]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 38001 && b! >= 37501{
                                    let result = nettoPercent[51]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 38501 && b! >= 38001{
                                    let result = nettoPercent[52]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 39001 && b! >= 38501{
                                    let result = nettoPercent[53]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 39501 && b! >= 39001{
                                    let result = nettoPercent[54]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 40001 && b! >= 39501{
                                    let result = nettoPercent[55]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 40501 && b! >= 40001{
                                    let result = nettoPercent[56]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 41001 && b! >= 40501{
                                    let result = nettoPercent[57]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 41501 && b! >= 41001{
                                    let result = nettoPercent[58]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 42001 && b! >= 41501{
                                    let result = nettoPercent[59]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 42501 && b! >= 42001{
                                    let result = nettoPercent[60]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 43001 && b! >= 42501{
                                    let result = nettoPercent[61]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 43501 && b! >= 43001{
                                    let result = nettoPercent[62]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 44001 && b! >= 43501{
                                    let result = nettoPercent[63]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 44501 && b! >= 44001{
                                    let result = nettoPercent[64]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 45001 && b! >= 44501{
                                    let result = nettoPercent[65]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 45501 && b! >= 45001{
                                    let result = nettoPercent[66]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 46001 && b! >= 45501{
                                    let result = nettoPercent[67]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 46501 && b! >= 46001{
                                    let result = nettoPercent[68]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 47001 && b! >= 46501{
                                    let result = nettoPercent[69]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 47501 && b! >= 47001{
                                    let result = nettoPercent[70]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 48001 && b! >= 47501{
                                    let result = nettoPercent[71]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 48501 && b! >= 48001{
                                    let result = nettoPercent[72]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 49001 && b! >= 48501{
                                    let result = nettoPercent[73]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 49501 && b! >= 49001{
                                    let result = nettoPercent[74]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 50001 && b! >= 49501{
                                    let result = nettoPercent[75]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 50501 && b! >= 50001{
                                    let result = nettoPercent[76]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 51001 && b! >= 50501{
                                    let result = nettoPercent[77]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 51501 && b! >= 51001{
                                    let result = nettoPercent[78]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 52001 && b! >= 51501{
                                    let result = nettoPercent[79]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 52501 && b! >= 52001{
                                    let result = nettoPercent[80]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 53001 && b! >= 52501{
                                    let result = nettoPercent[81]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 53501 && b! >= 53001{
                                    let result = nettoPercent[82]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 54001 && b! >= 53501{
                                    let result = nettoPercent[83]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 54501 && b! >= 54001{
                                    let result = nettoPercent[84]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 55001 && b! >= 54501{
                                    let result = nettoPercent[85]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 55501 && b! >= 55001{
                                    let result = nettoPercent[86]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 56001 && b! >= 55501{
                                    let result = nettoPercent[87]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 56501 && b! >= 56001{
                                    let result = nettoPercent[88]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 57001 && b! >= 56501{
                                    let result = nettoPercent[89]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 57501 && b! >= 57001{
                                    let result = nettoPercent[90]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 58001 && b! >= 57501{
                                    let result = nettoPercent[91]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 58501 && b! >= 58001{
                                    let result = nettoPercent[92]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 59001 && b! >= 58501{
                                    let result = nettoPercent[93]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 59501 && b! >= 59001{
                                    let result = nettoPercent[94]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 60001 && b! >= 59001{
                                    let result = nettoPercent[95]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 60501 && b! >= 60001{
                                    let result = nettoPercent[96]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 61001 && b! >= 60501{
                                    let result = nettoPercent[97]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 61501 && b! >= 61001{
                                    let result = nettoPercent[98]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 62001 && b! >= 61501{
                                    let result = nettoPercent[99]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 62501 && b! >= 62001{
                                    let result = nettoPercent[100]*Double(b!)
                                    return Int(round(result))
                                }
                                else if b! < 63001 && b! >= 62501{
                                    let result = nettoPercent[101]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 63501 && b! >= 63001{
                                    let result = nettoPercent[102]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 64001 && b! >= 63501{
                                    let result = nettoPercent[103]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 64501 && b! >= 64001{
                                    let result = nettoPercent[104]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 65001 && b! >= 64501{
                                    let result = nettoPercent[105]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 65501 && b! >= 65001{
                                    let result = nettoPercent[106]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 66001 && b! >= 65501{
                                    let result = nettoPercent[107]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 66501 && b! >= 66001{
                                    let result = nettoPercent[108]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 67001 && b! >= 66501{
                                    let result = nettoPercent[109]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 67501 && b! >= 67001{
                                    let result = nettoPercent[110]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 68001 && b! >= 67501{
                                    let result = nettoPercent[111]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 68501 && b! >= 68001{
                                    let result = nettoPercent[112]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 69001 && b! >= 68501{
                                    let result = nettoPercent[113]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 69501 && b! >= 69001{
                                    let result = nettoPercent[114]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 70001 && b! >= 69501{
                                    let result = nettoPercent[115]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 70501 && b! >= 70001{
                                    let result = nettoPercent[116]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 71001 && b! >= 70501{
                                    let result = nettoPercent[117]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 71501 && b! >= 71001{
                                    let result = nettoPercent[118]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 72001 && b! >= 71501{
                                    let result = nettoPercent[119]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 72501 && b! >= 72001{
                                    let result = nettoPercent[120]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 73001 && b! >= 72501{
                                    let result = nettoPercent[121]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 73501 && b! >= 73001{
                                    let result = nettoPercent[122]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 74001 && b! >= 73501{
                                    let result = nettoPercent[123]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 74501 && b! >= 74001{
                                    let result = nettoPercent[124]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 75001 && b! >= 74501{
                                    let result = nettoPercent[125]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 75501 && b! >= 75001{
                                    let result = nettoPercent[126]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 76001 && b! >= 75501{
                                    let result = nettoPercent[127]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 76501 && b! >= 76001{
                                    let result = nettoPercent[128]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 77001 && b! >= 76501{
                                    let result = nettoPercent[129]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 77501 && b! >= 77001{
                                    let result = nettoPercent[130]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 78001 && b! >= 77501{
                                    let result = nettoPercent[131]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 78501 && b! >= 78001{
                                    let result = nettoPercent[132]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 79001 && b! >= 78501{
                                    let result = nettoPercent[133]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 79501 && b! >= 79001{
                                    let result = nettoPercent[134]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 80001 && b! >= 79501{
                                    let result = nettoPercent[135]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 80501 && b! >= 80001{
                                    let result = nettoPercent[136]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 81001 && b! >= 80501{
                                    let result = nettoPercent[137]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 81501 && b! >= 81001{
                                    let result = nettoPercent[138]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 82001 && b! >= 81501{
                                    let result = nettoPercent[139]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 82501 && b! >= 82001{
                                    let result = nettoPercent[140]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 83001 && b! >= 82501{
                                    let result = nettoPercent[141]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 83501 && b! >= 83001{
                                    let result = nettoPercent[142]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 84001 && b! >= 83501{
                                    let result = nettoPercent[143]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 84501 && b! >= 84001{
                                    let result = nettoPercent[144]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 85001 && b! >= 84501{
                                    let result = nettoPercent[145]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 85501 && b! >= 85001{
                                    let result = nettoPercent[146]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 86001 && b! >= 85501{
                                    let result = nettoPercent[147]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 86501 && b! >= 86001{
                                    let result = nettoPercent[148]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 87001 && b! >= 86501{
                                    let result = nettoPercent[149]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 87501 && b! >= 87001{
                                    let result = nettoPercent[150]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 88001 && b! >= 87501{
                                    let result = nettoPercent[151]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 88501 && b! >= 88001{
                                    let result = nettoPercent[152]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 89001 && b! >= 88501{
                                    let result = nettoPercent[153]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 89501 && b! >= 89001{
                                    let result = nettoPercent[154]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 90001 && b! >= 89501{
                                    let result = nettoPercent[155]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 90501 && b! >= 90001{
                                    let result = nettoPercent[156]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 91001 && b! >= 90501{
                                    let result = nettoPercent[157]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 91501 && b! >= 91001{
                                    let result = nettoPercent[158]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 92001 && b! >= 91501{
                                    let result = nettoPercent[159]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 92501 && b! >= 92001{
                                    let result = nettoPercent[160]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 93001 && b! >= 92501{
                                    let result = nettoPercent[161]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 93501 && b! >= 93001{
                                    let result = nettoPercent[162]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 94001 && b! >= 93501{
                                    let result = nettoPercent[163]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 94501 && b! >= 94001{
                                    let result = nettoPercent[164]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 95001 && b! >= 94501{
                                    let result = nettoPercent[165]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 95501 && b! >= 95001{
                                    let result = nettoPercent[166]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 96001 && b! >= 95501{
                                    let result = nettoPercent[167]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 96501 && b! >= 96001{
                                    let result = nettoPercent[168]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 97001 && b! >= 96501{
                                    let result = nettoPercent[169]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 97501 && b! >= 97001{
                                    let result = nettoPercent[170]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 98001 && b! >= 97501{
                                    let result = nettoPercent[171]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 98501 && b! >= 98001{
                                    let result = nettoPercent[172]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 99001 && b! >= 98501{
                                    let result = nettoPercent[173]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 99501 && b! >= 99001{
                                    let result = nettoPercent[174]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 100001 && b! >= 99501{
                                    let result = nettoPercent[175]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 100501 && b! >= 100001{
                                    let result = nettoPercent[176]*Double(b!)
                                    return Int(round(result))
                                }else if b! < 101001 && b! >= 100501{
                                    let result = nettoPercent[177]*Double(b!)
                                    return Int(round(result))
                                }else
                                {
                                    let result = 0
                                    return Int(result)
                                }
                            }
                            
      //PART2 to Calculation Taxes amount 
                            
                                func sumTax()->Int{
                                    let b = Int(input.text!)
                                    if b! < 12501 {
                                        let result = taxPercent[0]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 13001 && b! >= 12501{
                                        let result = taxPercent[1]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 13501 && b! >= 13001{
                                        let result = taxPercent[2]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 14001 && b! >= 13501{
                                        let result = taxPercent[3]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 14501 && b! >= 14001{
                                        let result = taxPercent[4]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 15001 && b! >= 14501{
                                        let result = taxPercent[5]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 15501 && b! >= 15001{
                                        let result = taxPercent[6]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 16001 && b! >= 15501{
                                        let result = taxPercent[7]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 16501 && b! >= 16001{
                                        let result = taxPercent[8]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 17001 && b! >= 16501{
                                        let result = taxPercent[9]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 17501 && b! >= 17001{
                                        let result = taxPercent[10]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 18001 && b! >= 17501{
                                        let result = taxPercent[11]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 18501 && b! >= 18001{
                                        let result = taxPercent[12]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 19001 && b! >= 18501{
                                        let result = taxPercent[13]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 19501 && b! >= 19001{
                                        let result = taxPercent[14]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 20001 && b! >= 19501{
                                        let result = taxPercent[15]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 20501 && b! >= 20001{
                                        let result = taxPercent[16]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 21001 && b! >= 20501{
                                        let result = taxPercent[17]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 21501 && b! >= 21001{
                                        let result = taxPercent[18]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 22001 && b! >= 21501{
                                        let result = taxPercent[19]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 22501 && b! >= 22001{
                                        let result = taxPercent[20]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 23001 && b! >= 22501{
                                        let result = taxPercent[21]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 23501 && b! >= 23001{
                                        let result = taxPercent[22]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 24001 && b! >= 23501{
                                        let result = taxPercent[23]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 24501 && b! >= 24001{
                                        let result = taxPercent[24]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 25001 && b! >= 24501{
                                        let result = taxPercent[25]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 25501 && b! >= 25001{
                                        let result = taxPercent[26]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 26001 && b! >= 25501{
                                        let result = taxPercent[27]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 26501 && b! >= 26001{
                                        let result = taxPercent[28]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 27001 && b! >= 26501{
                                        let result = taxPercent[29]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 27501 && b! >= 27001{
                                        let result = taxPercent[30]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 28001 && b! >= 27501{
                                        let result = taxPercent[31]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 28501 && b! >= 28001{
                                        let result = taxPercent[32]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 29001 && b! >= 28501{
                                        let result = taxPercent[33]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 29501 && b! >= 29001{
                                        let result = taxPercent[34]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 30001 && b! >= 29501{
                                        let result = taxPercent[35]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 30501 && b! >= 30001{
                                        let result = taxPercent[36]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 31001 && b! >= 30501{
                                        let result = taxPercent[37]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 31501 && b! >= 31001{
                                        let result = taxPercent[38]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 32001 && b! >= 31501{
                                        let result = taxPercent[39]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 32501 && b! >= 32001{
                                        let result = taxPercent[40]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 33001 && b! >= 32501{
                                        let result = taxPercent[41]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 33501 && b! >= 33001{
                                        let result = taxPercent[42]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 34001 && b! >= 33501{
                                        let result = taxPercent[43]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 34501 && b! >= 34001{
                                        let result = taxPercent[44]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 35001 && b! >= 34501{
                                        let result = taxPercent[45]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 35501 && b! >= 35001{
                                        let result = taxPercent[46]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 36001 && b! >= 35501{
                                        let result = taxPercent[47]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 36501 && b! >= 36001{
                                        let result = taxPercent[48]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 37001 && b! >= 36501{
                                        let result = taxPercent[49]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 37501 && b! >= 37001{
                                        let result = taxPercent[50]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 38001 && b! >= 37501{
                                        let result = taxPercent[51]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 38501 && b! >= 38001{
                                        let result = taxPercent[52]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 39001 && b! >= 38501{
                                        let result = taxPercent[53]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 39501 && b! >= 39001{
                                        let result = taxPercent[54]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 40001 && b! >= 39501{
                                        let result = taxPercent[55]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 40501 && b! >= 40001{
                                        let result = taxPercent[56]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 41001 && b! >= 40501{
                                        let result = taxPercent[57]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 41501 && b! >= 41001{
                                        let result = taxPercent[58]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 42001 && b! >= 41501{
                                        let result = taxPercent[59]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 42501 && b! >= 42001{
                                        let result = taxPercent[60]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 43001 && b! >= 42501{
                                        let result = taxPercent[61]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 43501 && b! >= 43001{
                                        let result = taxPercent[62]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 44001 && b! >= 43501{
                                        let result = taxPercent[63]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 44501 && b! >= 44001{
                                        let result = taxPercent[64]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 45001 && b! >= 44501{
                                        let result = taxPercent[65]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 45501 && b! >= 45001{
                                        let result = taxPercent[66]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 46001 && b! >= 45501{
                                        let result = taxPercent[67]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 46501 && b! >= 46001{
                                        let result = taxPercent[68]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 47001 && b! >= 46501{
                                        let result = taxPercent[69]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 47501 && b! >= 47001{
                                        let result = taxPercent[70]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 48001 && b! >= 47501{
                                        let result = taxPercent[71]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 48501 && b! >= 48001{
                                        let result = taxPercent[72]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 49001 && b! >= 48501{
                                        let result = taxPercent[73]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 49501 && b! >= 49001{
                                        let result = taxPercent[74]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 50001 && b! >= 49501{
                                        let result = taxPercent[75]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 50501 && b! >= 50001{
                                        let result = taxPercent[76]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 51001 && b! >= 50501{
                                        let result = taxPercent[77]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 51501 && b! >= 51001{
                                        let result = taxPercent[78]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 52001 && b! >= 51501{
                                        let result = taxPercent[79]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 52501 && b! >= 52001{
                                        let result = taxPercent[80]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 53001 && b! >= 52501{
                                        let result = taxPercent[81]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 53501 && b! >= 53001{
                                        let result = taxPercent[82]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 54001 && b! >= 53501{
                                        let result = taxPercent[83]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 54501 && b! >= 54001{
                                        let result = taxPercent[84]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 55001 && b! >= 54501{
                                        let result = taxPercent[85]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 55501 && b! >= 55001{
                                        let result = taxPercent[86]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 56001 && b! >= 55501{
                                        let result = taxPercent[87]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 56501 && b! >= 56001{
                                        let result = taxPercent[88]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 57001 && b! >= 56501{
                                        let result = taxPercent[89]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 57501 && b! >= 57001{
                                        let result = taxPercent[90]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 58001 && b! >= 57501{
                                        let result = taxPercent[91]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 58501 && b! >= 58001{
                                        let result = taxPercent[92]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 59001 && b! >= 58501{
                                        let result = taxPercent[93]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 59501 && b! >= 59001{
                                        let result = taxPercent[94]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 60001 && b! >= 59001{
                                        let result = taxPercent[95]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 60501 && b! >= 60001{
                                        let result = taxPercent[96]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 61001 && b! >= 60501{
                                        let result = taxPercent[97]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 61501 && b! >= 61001{
                                        let result = taxPercent[98]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 62001 && b! >= 61501{
                                        let result = taxPercent[99]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 62501 && b! >= 62001{
                                        let result = taxPercent[100]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else if b! < 63001 && b! >= 62501{
                                        let result = taxPercent[101]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 63501 && b! >= 63001{
                                        let result = taxPercent[102]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 64001 && b! >= 63501{
                                        let result = taxPercent[103]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 64501 && b! >= 64001{
                                        let result = taxPercent[104]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 65001 && b! >= 64501{
                                        let result = taxPercent[105]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 65501 && b! >= 65001{
                                        let result = taxPercent[106]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 66001 && b! >= 65501{
                                        let result = taxPercent[107]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 66501 && b! >= 66001{
                                        let result = taxPercent[108]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 67001 && b! >= 66501{
                                        let result = taxPercent[109]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 67501 && b! >= 67001{
                                        let result = taxPercent[110]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 68001 && b! >= 67501{
                                        let result = taxPercent[111]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 68501 && b! >= 68001{
                                        let result = taxPercent[112]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 69001 && b! >= 68501{
                                        let result = taxPercent[113]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 69501 && b! >= 69001{
                                        let result = taxPercent[114]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 70001 && b! >= 69501{
                                        let result = taxPercent[115]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 70501 && b! >= 70001{
                                        let result = taxPercent[116]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 71001 && b! >= 70501{
                                        let result = taxPercent[117]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 71501 && b! >= 71001{
                                        let result = taxPercent[118]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 72001 && b! >= 71501{
                                        let result = taxPercent[119]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 72501 && b! >= 72001{
                                        let result = taxPercent[120]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 73001 && b! >= 72501{
                                        let result = taxPercent[121]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 73501 && b! >= 73001{
                                        let result = taxPercent[122]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 74001 && b! >= 73501{
                                        let result = taxPercent[123]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 74501 && b! >= 74001{
                                        let result = taxPercent[124]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 75001 && b! >= 74501{
                                        let result = taxPercent[125]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 75501 && b! >= 75001{
                                        let result = taxPercent[126]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 76001 && b! >= 75501{
                                        let result = taxPercent[127]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 76501 && b! >= 76001{
                                        let result = taxPercent[128]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 77001 && b! >= 76501{
                                        let result = taxPercent[129]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 77501 && b! >= 77001{
                                        let result = taxPercent[130]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 78001 && b! >= 77501{
                                        let result = taxPercent[131]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 78501 && b! >= 78001{
                                        let result = taxPercent[132]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 79001 && b! >= 78501{
                                        let result = taxPercent[133]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 79501 && b! >= 79001{
                                        let result = taxPercent[134]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 80001 && b! >= 79501{
                                        let result = taxPercent[135]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 80501 && b! >= 80001{
                                        let result = taxPercent[136]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 81001 && b! >= 80501{
                                        let result = taxPercent[137]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 81501 && b! >= 81001{
                                        let result = taxPercent[138]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 82001 && b! >= 81501{
                                        let result = taxPercent[139]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 82501 && b! >= 82001{
                                        let result = taxPercent[140]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 83001 && b! >= 82501{
                                        let result = taxPercent[141]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 83501 && b! >= 83001{
                                        let result = taxPercent[142]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 84001 && b! >= 83501{
                                        let result = taxPercent[143]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 84501 && b! >= 84001{
                                        let result = taxPercent[144]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 85001 && b! >= 84501{
                                        let result = taxPercent[145]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 85501 && b! >= 85001{
                                        let result = taxPercent[146]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 86001 && b! >= 85501{
                                        let result = taxPercent[147]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 86501 && b! >= 86001{
                                        let result = taxPercent[148]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 87001 && b! >= 86501{
                                        let result = taxPercent[149]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 87501 && b! >= 87001{
                                        let result = taxPercent[150]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 88001 && b! >= 87501{
                                        let result = taxPercent[151]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 88501 && b! >= 88001{
                                        let result = taxPercent[152]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 89001 && b! >= 88501{
                                        let result = taxPercent[153]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 89501 && b! >= 89001{
                                        let result = taxPercent[154]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 90001 && b! >= 89501{
                                        let result = taxPercent[155]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 90501 && b! >= 90001{
                                        let result = taxPercent[156]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 91001 && b! >= 90501{
                                        let result = taxPercent[157]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 91501 && b! >= 91001{
                                        let result = taxPercent[158]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 92001 && b! >= 91501{
                                        let result = taxPercent[159]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 92501 && b! >= 92001{
                                        let result = taxPercent[160]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 93001 && b! >= 92501{
                                        let result = taxPercent[161]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 93501 && b! >= 93001{
                                        let result = taxPercent[162]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 94001 && b! >= 93501{
                                        let result = taxPercent[163]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 94501 && b! >= 94001{
                                        let result = taxPercent[164]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 95001 && b! >= 94501{
                                        let result = taxPercent[165]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 95501 && b! >= 95001{
                                        let result = taxPercent[166]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 96001 && b! >= 95501{
                                        let result = taxPercent[167]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 96501 && b! >= 96001{
                                        let result = taxPercent[168]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 97001 && b! >= 96501{
                                        let result = taxPercent[169]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 97501 && b! >= 97001{
                                        let result = taxPercent[170]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 98001 && b! >= 97501{
                                        let result = taxPercent[171]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 98501 && b! >= 98001{
                                        let result = taxPercent[172]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 99001 && b! >= 98501{
                                        let result = taxPercent[173]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 99501 && b! >= 99001{
                                        let result = taxPercent[174]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 100001 && b! >= 99501{
                                        let result = taxPercent[175]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 100501 && b! >= 100001{
                                        let result = taxPercent[176]*Double(b!)
                                        return Int(round(result))
                                    }else if b! < 101001 && b! >= 100501{
                                        let result = taxPercent[177]*Double(b!)
                                        return Int(round(result))
                                    }
                                    else
                                    {
                                        let result = 0
                                        return Int(result)
                                    }
                                    
                            }

       //Output to Labels
                            let numberFormatter = NumberFormatter()
                            numberFormatter.numberStyle = NumberFormatter.Style.currency
                            numberFormatter.locale = NSLocale(localeIdentifier: "sv_SE") as Locale!
                            output.text = numberFormatter.string (from: NSNumber(value:(sum())))
                            taxLbl.text = numberFormatter.string (from: NSNumber(value:(sumTax())))
                            addInfo.text = numberFormatter.string (from: NSNumber(value:(12*sum())))!
                            defaults.set(output.text!, forKey: outputL)
                            defaults.set(taxLbl.text!, forKey: taxL)
                            defaults.set(addInfo.text!, forKey: addI)
                            defaults.set(input.text!, forKey: nettL)
                    }
        }else {
                    input.text = number
                    stillTyping = true
        }
    }

//Clear Button
    
    @IBAction func clearButton(_ sender: UIButton) {
        output.text = ""
        input.text = output.text
        taxLbl.text = output.text
        addInfo.text = output.text
        stillTyping = false
        defaults.set(output.text!, forKey: outputL)
        defaults.set(taxLbl.text!, forKey: taxL)
        defaults.set(addInfo.text!, forKey: addI)
        defaults.set(input.text!, forKey: nettL)
    }
    
    //ABOUT BUTTON
    
   
    @IBAction func aboutButton(_ sender: Any) {
        self.performSegue(withIdentifier: "About", sender: self.navigationController)
    }

    //SHARE BUTTTON
 
    @IBAction func shareButton(_ sender: Any) {
 
    
        let activityVC = UIActivityViewController(activityItems: ["Take a look on this amazing app. to calculate the Taxes in Stockholm area https://itunes.apple.com/us/app/sth-skatter/id1289164861?ls=1&mt=8"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
         }
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //USER DEFAULTS
        
        if let outputLb = defaults.value(forKey: outputL){
            output.text = outputLb as? String
            
        }
        if let taxLb = defaults.value(forKey: taxL){
            taxLbl.text = taxLb as? String
            
        }
        if let addIn = defaults.value(forKey: addI){
            addInfo.text = addIn as? String
        }
        
        if let nettoLb = defaults.value(forKey: nettL){
            input.text = nettoLb as? String
        }
        
        
        let iconImageView = UIImageView(image: UIImage(named: "icon" ))
        self.navigationItem.titleView = iconImageView
        
        //CONFIGURE NAVIGATION CONTROLLER
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

