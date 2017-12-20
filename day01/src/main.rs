use std::fs::File;
use std::io::prelude::*;

fn search_sum(chars: &Vec<char>, search_offset: usize) -> u32 {
    const RADIX: u32 = 10;

    let mut sum = 0;
    for (i, current) in chars.iter().enumerate() {
        let next = chars.iter().cycle().nth(i + search_offset).unwrap();
        if current == next {
            sum += current.to_digit(RADIX).unwrap();
        }
    }
    sum
}

fn main() {
    let mut f = File::open("input.txt").expect("File not found!");

    let mut contents = String::new();
    f.read_to_string(&mut contents)
        .expect("something went wrong reading the file!");

    let chars: Vec<char> = contents.chars().collect();

    // part 1
    assert_eq!(1177, search_sum(&chars, 1));
    
    // part 2
    assert_eq!(1060, search_sum(&chars, chars.len()/2));

}
