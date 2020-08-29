use std::env;
use std::fs::File;
use std::io::BufReader;
use std::io::BufRead;

fn next_line(reader: &mut BufReader<File>) -> String {
	let mut line = String::new();
	reader.read_line(&mut line).expect("can't read input file");
	line.get(..line.capacity()-1).unwrap_or("").to_string()
}

fn main() {
	let args:Vec<String> = env::args().collect();

	let filename:&String = &args[1];
	println!("filename is {:?}", filename);

	let file = File::open(filename).expect("input file not found");
//	println!("file {:?}", file);

	let mut reader = BufReader::new(file);
//	println!("reader {:?}", reader);

	let mut line = next_line(&mut reader);
    let puzzle_depth:u32 = line.parse().expect("puzzle depth is not a number");
    println!("puzzle depth is {:?}", puzzle_depth);

    line = next_line(&mut reader);
    for row in line.split(',') {
    	println!("{}", row);
    }
}
