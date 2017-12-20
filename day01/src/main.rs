use std::fs::File;
use std::io::prelude::*;

fn main() {
    let mut f = File::open("input.txt").expect("File not found!");

    let mut contents = String::new();
    f.read_to_string(&mut contents)
        .expect("something went wrong reading the file!");

    let mut chars: Vec<char> = contents.chars().collect();
    chars.extend(contents.chars().take(1));

    const RADIX: u32 = 10;

    let mut sum = 0;
    let mut iter = chars.iter().peekable();
    while let Some(current) = iter.next() {
        if let Some(next) = iter.peek() {
            if current == *next {
                sum += current.to_digit(RADIX).unwrap();
            }
        }
    }

    assert_eq!(1177, sum);
}
