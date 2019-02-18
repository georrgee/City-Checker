//  Constants.swift
//  JEFIT Take Home Project

//  Created by George Garcia on 2/12/19.
//  Copyright © 2019 George Garcia. All rights reserved.
//

import Foundation

// MARK: Networking Constants

let client_id = "1HXPSPVL1EMU14MM0UQKWPPFK2HOGJANMJZPNMOVLEEAZWGQ"
let client_secret = "HZHHWXE1YWEVPWN1LDMKBA0LT1UYKMLSAQCB11ERIHXNUJIA"

//let client_id = "QAGOJ3OMFSYWVA5L3ALT1IZVKLSYHIKLPUR5TZTYBRH5ETAW"
//let client_secret = "CENZ05ZZIMITRTXJ4X4FZJIDEJEPWCKIZ2EDZUX2GJPYHDQB"

//let client_id = "EQWC1DR50NRXNNKCV0WBXZOGWZR1TNUNHX5OTALS44W2MGZ0"
//let client_secret = "B22LMLK4R31OYHGQDK2EP3LLKJOPWF1HDDXZKIIBGQDUVMGR"

//let client_id = "H3MWI1034WBF05AUUVKPOE2SMM5DM0JFCU2CYVRXBVUWYRZR"
//let client_secret = "XL1GKAL4Q3GKOMM2TY3IQCZDEFBM3RWEW1OR3OA1TZ0B1ARV"

//let client_id = "A3DTIY2RMBWNT2S32EPMW43MUGJVO01G5A3HB13AH4V01LMU"
//let client_secret = "UBDXTRJFSZ1TNFKPSFU1R41IN0HMLQC04BCQLQZVAYSIYF0C"


let section = "topPicks"

// MARK: Screen 1 (Main Page. List of chosen cities)

struct City {
    var name: String?
    var imageName: String?
    var lat: Double = 0
    var long: Double = 0
    
    init(name: String, image: String, lat: Double, long: Double) {
        self.name = name
        self.imageName = image
        self.lat = lat
        self.long = long
    }
}

