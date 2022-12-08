import Foundation
/// ITP-342 Spring 2022 Homework 2
/// Strings, Functions, and Optionals


// ************
// Follow the instructions in the comments to complete the coding problems. You can simply write your code in the Swift Playground we've provided. Rename the file in the format LastFirstHW2.playground, then zip the file in the format LastFirstHW2.zip and submit on Blackboard.
// ************

/// 1.
/// Format the below into a Swift String, taking care to keep the exact formatting, including quotation marks and tabs! You can ignore the slashes for the comment, though.
/// Hint: use the escape character for tab, new-line, and quotation marks.
//    "Hello, this is a
// multiline-quote."

// Uncomment below to finish the line of code and print!
  let multiLineQuote = "\t\"Hello, this is a\nmultiline-quote.\""
  print(multiLineQuote)

/// 2.
/// Mutate the below string to read "Hello!" instead of "Hello."
/// Hint: don't re-assign the value of the String directly, but use the insert and remove methods to mutate in place.
var message = "Hello."
// Your String mutation code here
message.remove(at: message.index(before: message.endIndex))
message.insert("!", at: message.endIndex)
print(message)

/// 3.
/// Use the priceWithSalesTax variable to format the price tag string like this: "Total price: $XXX.XX" (with just 2 decimal places)
let priceWithSalesTax = 124.99 * 1.095
let stringTax = String(format: "%.2f", priceWithSalesTax)
// Uncomment me!
  let priceTag = "Total price: $\(stringTax)"
  print(priceTag)


/// 4.
/// The below code combines names and dates of birth and prints them. There's a lot of repeated logic! Using your best judgement, refactor these operations into a function.
/// Hint: consider designing a function that takes in a name and date of birth as String parameters
var p1 = "Wanda Austin"
var d1 = "1/1/1954"
nameFormatter(name: p1, dob: d1)

var p2 = "Tommy Trojan"
var d2 = "2/24/1912"
nameFormatter(name: p2, dob: d2)

var p3 = "Traveler IX"
var d3 = "12/1/2017"
nameFormatter(name: p3, dob: d3)
// Your function and function calls to produce the same output as above here
func nameFormatter(name: String, dob: String){
    let formatted = name + " " + dob
    print(formatted)
}


/// 5.
/// Write a function that returns the sum of two Ints and that can be called like this: let x = add(1, 2)
// Your function here
func add(_ one: Int, _ two: Int) -> Int{
    return one + two
}

/// 6.
/// Write a function that prints the sum of two Ints, does not return the sum, and can be called like this: printSum(a: 1, b: 2)
// Your function here
func printSum(a: Int, b: Int){
    print(a+b)
}

/// 7.
/// Write a function that returns a formatted String including age someone is turning this year given the year they were born.
/// The function should be able to be called as follows. It should also use the parameter name "year" and arguement label provided ("bornIn").
/// Example function call:
/// hello("John", bornIn: 1995)) // Returns: "John is turning 24 in 2019"
// Your function here
func hello(_ name: String, bornIn year: Int) -> String {
    let age = 2022 - year
    return "\(name) is turning \(age) in 2022"
}

/// 8.
/// Write a function that takes in a Float score representing a grade percentage and returns a String describing the grade. Handle bad input appropriately.
/// Example:
/// grade(95) returns "A"
/// grade(70.2) returns "C-"
// Your function here
func grade(_ score: Float) -> String{
    if(score <= 100 && score >= 93){
        return "A"
    }
    else if(score <= 92 && score >= 90){
        return "A-"
    }
    else if(score <= 89 && score >= 87){
        return "B+"
    }
    else if(score <= 86 && score >= 83){
        return "B"
    }
    else if(score <= 82 && score >= 80){
        return "B-"
    }
    else if(score <= 79 && score >= 77){
        return "C+"
    }
    else if(score <= 76 && score >= 73){
        return "C"
    }
    else if(score <= 72 && score >= 70){
        return "C-"
    }
    else if(score <= 69 && score >= 67){
        return "D+"
    }
    else if(score <= 66 && score >= 65){
        return "D"
    }
    else if(score <= 64 && score >= 0){
        return "F"
    }
    else{
        return "Invalid entry"
    }
}


/// 9.
/// Write a function below that allow both of the function calls below compile without any changes. The function doesn't have to actually do anything.
/// Hint: Take a look at the function slides 12-17 for default argument values.
// Write your function here
func foo(_ parameterWithoutDefault: Int,
         _ parameterWithDefault: Int = 12){
    
}
// Uncomment me to make sure your function works!
  foo(1, 2)
  foo(1)


/// 10.
/// Write a function that takes in a String called word and a Character called letter, and returns an integer reprsenting the number of times letter appears in word. Then, call the function with some sample input and print it. Add a comment next to your sample input noting what the expected output is.
/// Hint: Use a for loop to iterate over word.indices
print(noOfChars(word: "Hello", letter: "l")) //Expected ans = 2
print(noOfChars(word: "Hello", letter: "z")) //Expected ans = 0
// Your code here
func noOfChars(word: String, letter: Character) -> Int{
    var count = 0;
    for char in word {
        if(letter == char){
            count+=1;
        }
    }
    return count;
}

/// 11.
/// Write a function using the inout keyword that takes in an Int and increments it by 1. Call your function to show it works.
var val = 0
print(incrementVal(&val)) // Expected = 1
// Your code here
func incrementVal(_ a: inout Int) -> Int{
    return (a+1)
}

/// 12.
/// Safely unwrap the optional variable below, taking care to avoid crashing. If the optional has a value, print it. If it doesn't, print "No value". You can use any method you like to unwrap the optional.
var maybeHasAValue: String?
safelyUnwrap(maybeHasAValue) // Expected = No value
// Your code here
func safelyUnwrap(_ maybeHasAValue: String?){
    if let x = maybeHasAValue{
        print(x)
    }
    else{
        print("No value")
    }
}
