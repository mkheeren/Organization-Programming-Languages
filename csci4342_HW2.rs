// Name: Mary Kait Heeren
// HW: HW 2
// Language: Rust
// Purpose: Similar to HW 1, we are inputting binary digit data from a file using the loadDiagnostics method, performing calculations based on the input, then printing out the calculations
// Resources: Rust Programming Language articles, Stack Overflow, Learning Rust Article


//used for reading input and radix conversion
use std::fs::read_to_string;
use std::io::{self, Write};
use std::str::FromStr;

//Purpose: read in input of binary numbers of the same length from a file
//line by line, store in vector (result)
fn loadDiagnostics(filename: &str) -> Vec<String> {

    let mut result = Vec::new();

    for line in read_to_string(filename).unwrap().lines() {
        result.push(line.to_string());

    }

    println!("Loading diagnostics...");

    result

}


//Purpose: Calculate o2 and co2 rates before calculating life support
//Input:result vector read in from the file
//Output: o2 rate, co2 rate, and life support rate
fn checkLifeSupport(result: &[String]) {

    let mut o2values = result.to_vec();

    let num_bits = o2values[0].len();




    for i in 0..num_bits {

        let mut count_zero = 0;

        let mut count_one = 0;




        for line in o2values.iter() {

            let character = line.chars().nth(i).unwrap();

            if character == '1' {

                count_one  += 1;

            }

            else

            {

                count_zero += 1;

            }

        }




        let most_dig = if count_one >= count_zero {'1'} else {'0'};

        o2values.retain(|line| line.chars().nth(i).unwrap() == most_dig);




        if o2values.len() == 1 {

            break;

        }

    }




    let mut co2values = result.to_vec();

    let num_bits = co2values[0].len();




    for i in 0..num_bits {

        let mut count_zero = 0;

        let mut count_one = 0;




        for line in co2values.iter() {

            let character = line.chars().nth(i).unwrap();

            if character == '1' {

                count_one  += 1;

            }

            else

            {

                count_zero += 1;

            }

        }




        let least_dig = if count_one >= count_zero {'0'} else {'1'};

        co2values.retain(|line| line.chars().nth(i).unwrap() == least_dig);




        if co2values.len() == 1 {

            break;

        }

    }

    let o2rate = u32::from_str_radix(&o2values[0], 2).unwrap();

    println!("O2 Generator computed...");




    let co2rate = u32::from_str_radix(&co2values[0], 2).unwrap();

    println!("CO2 Scrubber rate computed...");




    let life_support = o2rate * co2rate;

    println!("Life Support rate: {}", life_support);

}




//Purpose: read in filename and call
fn main() {

    let mut filename = String::new();




    io::stdin().read_line(&mut filename).expect("Failed to read line.");

    let filename = filename.trim();




    let results = loadDiagnostics(filename);

    checkLifeSupport(&results);

}