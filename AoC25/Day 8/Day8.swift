//
//  DayTemplate.swift
//  AoC24
//
//  Created by Mike Lewis on 12/3/24.
//

import Foundation

func Day8(file: String, part: Int) -> String {
    var tot = 0
    let lines = loadStringsFromFile(file)
    var numConns = 0
    
    var boxes: Set<JunctBox> = []
    var circuits: Set<Circuit> = []
    
    /* Fill up our set of boxes */
    for line in lines {
        let parts = line.split(separator: ",").map { Int($0)! }
        boxes.insert(JunctBox(x: parts[0], y: parts[1], z: parts[2]))
    }

    /* Each box knows the distance from itself to every other box */
    for box in boxes {
        for other in boxes where (box != other && box.dists.keys.contains(other) == false) {
            let dist = sqrt(Double((box.x - other.x) * (box.x - other.x) + (box.y - other.y) * (box.y - other.y) + (box.z - other.z) * (box.z - other.z)))
            box.dists[other] = dist
            other.dists[box] = dist
        }
    }
    
    doNConnections(1000)
    printCircSummary()
    tot = getTop3Prod()
    
    
    print(tot)
    return "\(tot)"
    
    func getTop3Prod() -> Int {
        var prod = 1
        let sortedCirc = circuits.sorted(by: {$0.boxes.count > $1.boxes.count })
        for i in 0..<3 {
            prod *= sortedCirc[i].boxes.count
        }
        
        return prod
    }
    
    func numConnections() -> Int {
        var cnt: Int = 0
        for circuit in circuits {
            cnt += circuit.boxes.count
        }
        return cnt
    }
    
    func doNConnections(_ n: Int) {
        while numConns < n {
            let (b1, b2) = getClosestPair()
            if let b1 = b1, let b2 = b2 {
                connect(b1, b2)
            }
        }
    }
    
    func printCircSummary() {
        var circCnt = 0
        for circuit in circuits.sorted(by: { $0.boxes.count > $1.boxes.count } ) {
            print("Circuit \(circCnt): \(circuit.boxes.count) boxes")
            circCnt += 1
        }
    }
    
    func getClosestPair() -> (JunctBox?, JunctBox?) {
        var (box1, box2, minDist): (JunctBox?, JunctBox?, Double?) = (nil, nil, nil)
        for box in boxes {
//            print("\(box.x),\(box.y),\(box.z): \(box.dists.count)")
            if let d = box.dists.values.min() {
                if let minD = minDist {
                    if d < minD {
                        minDist = d
                        box1 = box
                        box2 = box.dists.min {$0.value < $1.value}!.key
                    }
                } else {
                    minDist = d
                    box1 = box
                    box2 = box.dists.min {$0.value < $1.value}!.key
                }
            }
        }

        return (box1!, box2!)
    }
    
    func connect(_ box1: JunctBox, _ box2: JunctBox) {

        print("Connecting \(box1.coordStr) and \(box2.coordStr)")
        
        if let c1 = box1.inCircuit {
            /* If box1 is in circuit */
            if c1.boxes.contains(box2) {
                /* box1 & box2 are already in same circuit! */
                print("\(box1.coordStr) and \(box2.coordStr) are in the same circuit!")
                numConns += 1
            } else {
                if let c2 = box2.inCircuit {
                    assert(c1 != c2, "WAIT!!! Boxes \(box1.coordStr) and \(box2.coordStr) are in the same circuit!")
                    
                    /* box1 & box2 are in separate circuits. Combine them! */
                    print("** Combining \(box1.coordStr)'s and \(box2.coordStr)'s circuits")
                    let newCircuit = Circuit(boxes: c1.boxes.union(c2.boxes) )
                    for newb in newCircuit.boxes {
                        newb.inCircuit = newCircuit
                    }
                    circuits.insert(newCircuit)
                    circuits.remove(c1)
                    circuits.remove(c2)
                    print("****")
                    print("C1")
                    for b in c1.boxes.sorted(by: {$0.coordStr < $1.coordStr }) {
                        print(b.coordStr)
                    }
                    print("****")
                    print("C2")
                    for b in c2.boxes.sorted(by: {$0.coordStr < $1.coordStr }) {
                        print(b.coordStr)
                    }
                    print("****")
                    print("NEW")
                    for b in newCircuit.boxes.sorted(by: {$0.coordStr < $1.coordStr }) {
                        print(b.coordStr)
                    }
                    print("c1: (\(c1.boxes.count)) c2: (\(c2.boxes.count)), new: (\(newCircuit.boxes.count))")
                    numConns += 1
                } else {
                    /* box1 is in circuit, but box2 is not. Add box2 to box1's circuit */
                    print("Adding \(box2.coordStr) to \(box1.coordStr)'s circuit")
                    c1.boxes.insert(box2)
                    box2.inCircuit = c1
                    numConns += 1
                }
            }
        } else if let c2 = box2.inCircuit {
            /* box2 is in circuit, but box1 is NOT. Add box1 to box2's circuit */
            print("Adding \(box1.coordStr) to \(box2.coordStr)'s circuit")
            c2.boxes.insert(box1)
            box1.inCircuit = c2
            numConns += 1
        } else {
            /* Neither box1 nor box2 is in circuit. Create new circuit for them! */
            print("New circuit created for \(box1.coordStr) and \(box2.coordStr)")
            let newCircuit = Circuit(boxes: [box1, box2])
            box1.inCircuit = newCircuit
            box2.inCircuit = newCircuit
            circuits.insert(newCircuit)
            numConns += 1
        }
        
        /* Remove the distances between box1 & box2 so we don't try to connect them again */
        box1.dists[box2] = nil
        box2.dists[box1] = nil
    }
    
    final class JunctBox: Hashable {
        let id = UUID()
        let x, y, z: Int
        var dists: [JunctBox: Double] = [:]
        var inCircuit: Circuit? = nil
        
        var coordStr: String { "\(x),\(y),\(z)" }
        
        init(x: Int, y: Int, z: Int) {
            self.x = x
            self.y = y
            self.z = z
        }

        static func == (lhs: JunctBox, rhs: JunctBox) -> Bool { lhs.id == rhs.id }
        func hash(into hasher: inout Hasher) { hasher.combine(id) }
    }
    
    class Circuit: Hashable {
        let id = UUID()
        
        var boxes: Set<JunctBox>
        
        static func == (lhs: Circuit, rhs: Circuit) -> Bool { lhs.id == rhs.id }
        func hash(into hasher: inout Hasher) { hasher.combine(id) }
        
        init(boxes: Set<JunctBox>) {
            self.boxes = boxes
        }

    }
}
