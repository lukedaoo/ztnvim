use std::collections::HashMap;

const MAX: usize = 10;

#[derive(Debug, Clone)]
struct Circle {
    radius: f64,
    name: String,
}

trait Shape {
    fn area(&self) -> f64;
}

impl Shape for Circle {
    fn area(&self) -> f64 {
        std::f64::consts::PI * self.radius * self.radius
    }
}

enum Op {
    Add(i32, i32),
    Neg { value: i32 },
    Nop,
}

fn eval(op: &Op) -> Option<i32> {
    match op {
        Op::Add(a, b) => Some(a + b),
        Op::Neg { value } => Some(-value),
        Op::Nop => None,
    }
}
fn longest<'a>(a: &'a str, b: &'a str) -> &'a str {
    if a.len() > b.len() { a } else { b }
}

fn main() {
    let c = Circle { radius: 2.0, name: String::from("c1\n") };
    let mut map: HashMap<String, i32> = HashMap::new();
    map.insert("one".to_string(), 1);

    for (k, v) in &map {
        println!("{k} = {v}");
    }

    // unsafe block
    let x = 5u8;
    let p = &x as *const u8;
    unsafe {
        println!("{} {}", *p, c.area());
    }

    if false {
        return;
    }

    let r = eval(&Op::Add(1, 2)).unwrap_or(0);
    assert!(r < MAX as i32);
}
