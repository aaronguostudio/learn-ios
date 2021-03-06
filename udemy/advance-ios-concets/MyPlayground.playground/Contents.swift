import Foundation

// observe
var pizzaInInches: Int = 10 {
    willSet {
        print("will Set \(newValue), before \(pizzaInInches)")
    }
    
    didSet {
        if pizzaInInches >= 18 {
            print("Invalid size")
        }
        print("did set \(pizzaInInches), before \(oldValue)")
    }
}

pizzaInInches = 20

var numberOfPeople: Int = 6
var slicesPerPerson = 5

// computed properties, shortcut for getter
var numOfSlices: Int {
    return pizzaInInches - 4
}

// full version of getter
var numOfSlicesGetterAndSetter: Int {
    get {
        return pizzaInInches - 4
    }
    set {
        print("\(newValue) has been set")
    }
}

var numOfPizza: Int {
    get {
        let numberOfPeopleFedPerPizza = numOfSlices / slicesPerPerson
        return numberOfPeople / numberOfPeopleFedPerPizza
    }
    set {
        let totalSlices = numOfSlices * newValue
        numberOfPeople = totalSlices / slicesPerPerson
    }
}


numOfSlicesGetterAndSetter = 12

numOfPizza = 4
print(numberOfPeople)

// practice for computed
var width: Float = 1.5
var height: Float = 2.3

var bucketsOfPaint: Int {
    get {
        let area = width * height
        let areaCoveredPerBucket: Float = 1.5
        let numOfBuckets = area / areaCoveredPerBucket
        let roundedBuckets = ceilf(numOfBuckets)
        return Int(roundedBuckets)
    }
    
    set {
        let areaCanCover = Double(newValue) * 1.5
        print("This amount of paint can cover an area of \(areaCanCover)")
    }
}

bucketsOfPaint = 4


print(bucketsOfPaint)




































