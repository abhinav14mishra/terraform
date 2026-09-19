data "aws_vpc" "default"{
    default = true
}

resource "aws_subnet" "this" {
    vpc_id = data.aws_vpc.default.id
    cidr_block        = "172.31.48.0/24"
    
    lifecycle {
      postcondition {
        condition = self.availability_zone == "ap-south-1a" 
        error_message = "ap-south-1a is allowed"
      }
    }
}