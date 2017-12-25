use std::fs::File;
use std::io::{BufReader,BufRead};
use std::collections::{HashMap,HashSet};
use std::iter::FromIterator;


fn is_unique(line: &String) -> bool {
    let mut word_map = HashMap::new();
    for word in line.split_whitespace() {
        let count = word_map.entry(word.to_string()).or_insert(0);
        *count += 1;
    }

    word_map.values().filter(|&count| *count > 1).count() == 0
}

fn is_not_anagram(line: &String) -> bool {
    let mut encountered = HashSet::new();
    for word in line.split_whitespace() {
        let mut chars: Vec<_> = word.chars().collect();
        chars.sort();

        let sorted_word = String::from_iter(chars);
        if encountered.contains(&sorted_word) {
            return false;
        } else {
            encountered.insert(sorted_word.to_string());
        }
    }
    true
}

fn part_one() {
    let file = File::open("input.txt").unwrap();
    let non_duplicates = BufReader::new(&file)
        .lines()
        .filter_map(Result::ok)
        .filter(is_unique)
        .count();

    assert_eq!(337, non_duplicates);
}

fn part_two() {
    let file = File::open("input.txt").unwrap();
    let non_anagrams = BufReader::new(&file)
        .lines()
        .filter_map(Result::ok)
        .filter(is_not_anagram)
        .count();

    assert_eq!(231, non_anagrams);
}

fn main() {
    part_one();
    part_two();
}
