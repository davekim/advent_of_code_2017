use std::fs::File;
use std::io::{BufReader,BufRead};

fn diff_of_line(line: String) -> u32 {
    let v: Vec<u32> = line.split("\t").flat_map(|s| s.parse::<u32>()).collect();

    let min = v.iter().min().unwrap();
    let max = v.iter().max().unwrap();

    max - min
}

fn main() {
    let file = File::open("input.txt").unwrap();

    let checksum: u32 = BufReader::new(file).lines()
        .filter_map(Result::ok)
        .map(diff_of_line)
        .fold(0, |sum, d| sum + d);

    assert_eq!(46402, checksum);
}
