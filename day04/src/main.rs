use std::fs::File;
use std::io::{BufReader,BufRead};
use std::collections::HashMap;


fn is_unique(line: &String) -> bool {
    let mut word_map = HashMap::new();
    for word in line.split_whitespace() {
        let count = word_map.entry(word.to_string()).or_insert(0);
        *count += 1;
    }

    word_map.values().filter(|&count| *count > 1).count() == 0
}

fn main() {
    let file = File::open("input.txt").unwrap();

    let valid_passphrases = BufReader::new(&file)
        .lines()
        .filter_map(Result::ok)
        .filter(is_unique)
        .count();

    // part 1
    assert_eq!(337, valid_passphrases);
}
