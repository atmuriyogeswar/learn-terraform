resource "null_resource" "web" {
  
}

variable "string" {
  default = "Hello, World!"
}

variable "number" {
  default = 42
}
variable "boolean" {
  default = true
}

variable "list" {
  default = ["apple", "banana", "cherry"]
}
variable "map" {
  default = {
    name = "John Doe"
    age  = 30
    city = "New York"
  }
}
