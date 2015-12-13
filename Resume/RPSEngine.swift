//
//  RPSEngine.swift
//  Resume
//  Code modified from http://www.rpscontest.com/entry/1160001
//  Originally coded in Python by Flight Odyssey
//
//  Translated and created by Kevin Caughman on 7/27/15.
//  Copyright © 2015 Kevin Caughman. All rights reserved.
//


class RPSEngine {
    
    //MARK: - RPSEngine Properties
    var numPre = 30
    var numMeta = 6
    var limit = 8
    var possibleMove = ["R", "P", "S"]
    var beat = ["R": "P", "P": "S", "S": "R"]
    var moves = ["","","",""]
    var pScore = [[Double] ] (count: 6, repeatedValue: [Double] (count: 30, repeatedValue: 5.0))
    var centrifuge =   ["RP": 0,
                        "PS": 1,
                        "SR": 2,
                        "PR": 3,
                        "SP": 4,
                        "RS": 5,
                        "RR": 6,
                        "PP": 7,
                        "SS": 8]
    var centripete = ["R": 0, "P": 1, "S": 2]
    var soma = [0,0,0,0,0,0,0,0,0]
    var rps = [1,1,1]
    var best = [0,0,0]
    var length = 0
    var p = [String] (count : 30, repeatedValue : ["R", "P", "S"].randomItem())
    var m = [String] (count : 6, repeatedValue : ["R", "P", "S"].randomItem())
    var mScore = [5.0, 2.0, 5.0, 2.0, 4.0, 2.0]
    var index = Int()
    var output = String()

    //MARK: - RPSEngine Primary Method
        //Returns the move to play in RPS. Input is the move played by the human player in the previous round.
    
    func getMove(input: String, aiOn: Bool) -> String
    {
        if !input.isEmpty && aiOn
        {
            if mScore.maxElement() < 0.07 || randomRange(min: 3, max: 40) > length
            {
                output = beat[possibleMove[random()]]!
            }
            
            for var i = 0; i < numPre; i++
            {
                let pp = p[i]
                let bpp = beat[pp]
                let bbpp = beat[bpp!]
                var tempNum = Double()
                pScore[0][i] = 0.95 * pScore[0][i] + (Double(input == pp) - Double(input == bbpp!)) * 3;
                pScore[1][i] = 0.95 * pScore[1][i] + (Double(output == pp) - Double(output == bbpp!)) * 3;
                tempNum = (Double(input == pp) * 3.3) - (Double(input == bpp!) * 1.2) - (Double(input == bbpp!) * 2.3)
                pScore[2][i] = 0.85 * pScore[2][i] + tempNum
                tempNum = (Double(output == pp) * 3.3) - (Double(output == bpp!) * 1.2) - (Double(output == bbpp!) * 2.3)
                pScore[3][i] = 0.85 * pScore[3][i] + tempNum
                pScore[4][i] = (pScore[4][i] + Double(input == pp) * 3) * 1 - Double(input == bbpp!)
                pScore[5][i] = (pScore[5][i] + Double(output == pp) * 3) * 1 - Double(output == bbpp!)
            }
    
            for var i = 0; i < numMeta; i++
            {
                mScore[i] = 0.96 * (mScore[i] + Double(input == m[i])) - Double(input == beat[beat[m[i]]!]!)
            }
            soma[centrifuge[input + output]!] += 1
            rps[centripete[input]!] += 1
            moves[0] += String(centrifuge[input + output]!)
            moves[1] += input
            moves[2] += output
            length += 1
    
            var c = Int()
            var d = Int()
            for var y = 0; y < 3; y++
            {
                c = min(length, limit);
                while c >= 1 && !moves[y].Slice(0, end: length - 1).contains(moves[y].Slice(length - c, end: length))
                {
                    c -= 1
                }
                d = moves[y].RFind(moves[y].Slice(length - c, end: length), start: 0, end: length - 1)
                index = (c + d >= 0) ? c + d : moves[1].length - (c + d)
                p[2 * y] = moves[1].substring(index, length: 1)
                p[1 + (2 * y)] = beat[moves[2].substring(index, length: 1)]!
            }
            c = min(length, limit);
            while c >= 2 && !moves[0].Slice(0, end: length - 2).contains(moves[0].Slice(length - c, end: length - 1))
            {
                c -= 1
            }
            d = moves[0].RFind(moves[0].Slice(length - c, end: length - 1), start: 0, end: length - 2)
    
            if (c + d >= length)
            {
    
                p[6] = possibleMove[random()]
                p[7] = p[6]
            }
            else
            {
                index = (c + d >= 0) ? c + d : moves[1].length - (c + d)
                p[6] = NSString(string: moves[2]).substringWithRange(NSRange(location: index, length: 1))
                p[7] = beat[NSString(string: moves[2]).substringWithRange(NSRange(location: index, length: 1))]!
            }
    
            best[0] = soma[centrifuge[output + "R"]!] * rps[0] / rps[centripete[output]!]
            best[1] = soma[centrifuge[output + "P"]!] * rps[1] / rps[centripete[output]!]
            best[2] = soma[centrifuge[output + "S"]!] * rps[2] / rps[centripete[output]!]
            p[8] = possibleMove[best.indexOf(best.maxElement()!)!]
            p[9] = p[8];
    
            for var i = 10; i < numPre; i++
            {
                p[i] = beat[beat[p[i - 10]]!]!
            }
    
            for var i = 0; i < numMeta; i += 2
            {
                m[i] = p[pScore[i].indexOf(pScore[i].maxElement()!)!]
                m[i + 1] = p[pScore[i + 1].indexOf(pScore[i + 1].maxElement()!)!]
            }
            output = beat[m[mScore.indexOf(mScore.maxElement()!)!]]!
            return output
        }
        else
        {
            return possibleMove[random()]
        }
    }
    
    //MARK: - Helper Functions
    
    //takes in a range and returns an Int
    func randomRange(min min: Int, max: Int) -> Int {
        if max < min { return min }
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
    
    //set to return a number from 0-3 for our game
    func random() -> Int {
        return Int(arc4random_uniform(3))
    }

}

