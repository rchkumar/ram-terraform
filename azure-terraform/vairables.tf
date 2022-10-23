variable "client-secret" {
  type = string
  sensitive = true
}

variable "number-of-subnets" {
  type = number
  default = 2

}