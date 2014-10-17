fn dangling() -> Box<int> {
    let i = box 1234i;
    return i;
}

fn add_one() -> int {
    let num = dangling();
    return *num + 1;
}

fn main() {
    add_one();
}
