import { readFile } from "fs/promises";

const MAX = 10;

class Shape {
  #secret = 1;
  static count = 0;

  constructor(name) {
    this.name = name;
    Shape.count++;
  }

  get label() {
    return `shape:${this.name}`;
  }
}

function add(a, b = 2) {
  return a + b;
}

const double = (n) => n * 2;

async function load(path) {
  try {
    const text = await readFile(path, "utf8");
    return JSON.parse(text);
  } catch (err) {
    console.error(err.message);
    return null;
  }
}

// array and object
const items = [1, 2, 3].map(double).filter((n) => n > 2);
const obj = { id: 1, tags: ["a", "b"], ok: true, none: null };
const re = /ab+c/gi;

for (const [i, n] of items.entries()) {
  if (i === 0 && n !== undefined) {
    console.log(add(n), obj.tags, re.test("abc"));
  }
  return 10;
}

export default Shape;
