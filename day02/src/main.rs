use std::fs::File;
use std::io::{BufReader,BufRead};

fn diff_of_line(line: String) -> u32 {
    let v: Vec<u32> = line.split("\t").flat_map(|s| s.parse::<u32>()).collect();

    let min = v.iter().min().unwrap();
    let max = v.iter().max().unwrap();

    max - min
}

fn quotient_of_two_evenly_divisible_numbers(line: String) -> u32 {
    let mut numbers: Vec<u32> = line.split("\t").flat_map(|s| s.parse::<u32>()).collect();
    numbers.sort_by(|a, b| a.cmp(b));

    let mut quotient = 0;
    while let Some(top) = numbers.pop() {
        for num in numbers.iter() {
            if top % num == 0 {
                quotient = top / num;
                break;
            }
        }
    }
    quotient
}

fn part_one() {
    let file = File::open("input.txt").unwrap();

    let checksum: u32 = BufReader::new(&file).lines()
        .filter_map(Result::ok)
        .map(diff_of_line)
        .fold(0, |sum, d| sum + d);

    assert_eq!(46402, checksum);
}

fn part_two() {
    let file = File::open("input.txt").unwrap();

    let checksum: u32 = BufReader::new(&file).lines()
        .filter_map(Result::ok)
        .map(quotient_of_two_evenly_divisible_numbers)
        .fold(0, |sum, d| sum + d);

    assert_eq!(265, checksum);
}

fn main() {
    part_one();
    part_two();
}
