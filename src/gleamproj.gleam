import gleam/io
import gleam/string
import gleam/list
import gleam/regex
import gleam/int

pub fn main() {
  let value = lines("")
  let sum = calc_sum(value, 0)

  io.debug(sum)
}

fn calc_sum(list: List(Int), start: Int) -> Int {
  case list {
    [head, ..tail] -> calc_sum(tail, start + head)
    [] -> start
  }
}

fn lines(str: String) -> List(Int) {
  str
  |> string.split("\n")
  |> list.map(fn(x) {
    let start =
      x
      |> get_int_from_str
    let end =
      x
      |> string.reverse
      |> get_int_from_str

    start
    |> int.multiply(10)
    |> int.add(end)
  })
}

fn get_first_int(line: String) -> Int {
  line
  |> get_int_from_str
}

fn get_int_from_str(line: String) -> Int {
  let assert Ok(re) = regex.from_string("\\d")

  case string.split(line, "") {
    [value, ..rest] -> {
      case regex.check(re, value) {
        True -> {
          let assert Ok(value) = int.parse(value)
          value
        }
        _ -> get_first_int(join_list(rest, ""))
      }
    }

    _ -> 0
  }
}

fn join_list(list: List(String), start: String) -> String {
  case list {
    [] -> start
    [first, ..rest] -> join_list(rest, start <> first)
  }
}
