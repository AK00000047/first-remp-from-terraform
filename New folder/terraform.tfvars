vpc_config = {
  "vpc1" = {
    cidr_block = "192.168.0.0/16"
    tags = {
      Name = "vpc1"
    }
  }
  "vpc2" = {
    cidr_block = "192.168.0.0/24"
    tags = {
      Name = "vpc2"
    }
  }
}

subnet_config = {
  "web-subnet-1" = {
    vpc_name   = "vpc1"
    cidr_block = "192.168.1.0/24"
    tags = {
      Name = "web-subnet-1"
    }
    availability_zone = "ap-south-1a"
  }
  "web-subnet-2" = {
    vpc_name   = "vpc1"
    cidr_block = "192.168.2.0/24"
    tags = {
    Name = "web-subnet-2" }
    availability_zone = "ap-south-1b"
  }

  "app-subnet-1" = {
    vpc_name   = "vpc1"
    cidr_block = "192.168.3.0/24"
    tags = {
      Name = "app-subnet-1"
    }
    availability_zone = "ap-south-1a"
  }
  "app-subnet-2" = {
    vpc_name   = "vpc1"
    cidr_block = "192.168.4.0/24"
    tags = {
      Name = "app-subnet-2"
    }
    availability_zone = "ap-south-1b"
  }
  "data-subnet-1" = {
    vpc_name   = "vpc1"
    cidr_block = "192.168.5.0/24"
    tags = {
      Name = "data-subnet-1"
    }
    availability_zone = "ap-south-1a"
  }
  "data-subnet-2" = {
    vpc_name   = "vpc1"
    cidr_block = "192.168.6.0/24"
    tags = {
      Name = "data-subnet-2"
    }
    availability_zone = "ap-south-1b"
  }
}
internet_gateway_config = {

  "IGW01" = {

    vpc_name = "VPC1"
  }
}

eip_config = {
  "eip1" = {
    tags = {
      Name = "eip1"
    }
  }
  "eip2" = {
    tags = {
      Name = "eip2"
    }
  }
  "eip3" = {
    tags = {
      Name = "eip3"
    }
  }
  "eip4" = {
    tags = {
      Name = "eip4"
    }
  }
}

nat_gateway_config = {

  "NGW1" = {

    eip_name = "eip1"

    subnet_name = "web-subnet-1"

    tags = {
      Name = "NGW1"
    }

  }

  "NGW2" = {

    eip_name = "eip2"

    subnet_name = "web-subnet-2"

    tags = {
      Name = "NGW2"
    }

  }

  "NGW3" = {

    eip_name = "eip3"

    subnet_name = "web-subnet-1"

    tags = {
      Name = "NGW3"
    }

  }
  "NGW4" = {

    eip_name = "eip4"

    subnet_name = "web-subnet-2"

    tags = {
      Name = "NGW4"
    }

  }

}
route_table_config = {

  "RT01" = {

    private = 0

    vpc_name = "VPC1"

    gateway_name = "IGW01"

    tags = {
      Name = "public_route_table"
    }
  }

  "RT02" = {

    private = 1

    vpc_name = "VPC1"

    gateway_name = "NGW1"

    tags = {
      Name = "private_route_table"
    }

  }

  "RT03" = {
    private = 1

    vpc_name = "VPC1"

    gateway_name = "NGW2"

    tags = {
      Name = "private_route_table"
    }

  }

  "RT04" = {
    private = 1

    vpc_name = "VPC1"

    gateway_name = "NGW3"

    tags = {
      Name = "private_route_table"
    }

  }
  "RT05" = {
    private = 1

    vpc_name = "VPC1"

    gateway_name = "NGW4"

    tags = {
      Name = "private_route_table"
    }

  }
}
route_table_association = {
  "RTAss01" = {
    subnet_name      = "web-subnet-1"
    route_table_name = "RT01"
  }
  "RTAss02" = {
    subnet_name      = "web-subnet-2"
    route_table_name = "RT01"
  }
  "RTAss03" = {
    subnet_name      = "app-subnet-1"
    route_table_name = "RT02"
  }
  "RTAss04" = {
    subnet_name      = "app-subnet-2"
    route_table_name = "RT03"
  }
  "RTAss05" = {
    subnet_name      = "data-subnet-1"
    route_table_name = "RT04"
  }
  "RTAss06" = {
    subnet_name      = "data-subnet-2"
    route_table_name = "RT05"
  }
}

security_group_config = {
    "public_security_group" = {
        sg_name = "public_security_group"

        sg_description = "public_security_group"

        vpc_name = "VPC1"

        from_port = 0

        to_port = 0

        protocol = -1

        cidr_blocks = "0.0.0.0/0"

        tags = {
            Name = "public_security_group"
        }
    }
     "lb_security_group" = {

        sg_name = "lb_security_group"

        sg_description = "lb_security_group"

        vpc_name = "VPC1"

        from_port = 80

        to_port = 80

        protocol = "TCP"

        cidr_blocks = "0.0.0.0/0"

        tags = {
            Name = "lb_security_group"
    
        }
     }

     "rds_security_group" = {

        sg_name = "rds_security_group"

        sg_description = "rds_security_group"

        vpc_name = "VPC1"

        from_port = 3306

        to_port = 3306

        protocol = "TCP"

        cidr_blocks = "0.0.0.0/0"

        tags = {
            Name = "rds_security_group"
    
        }
     }
}
instance_config={
     "web_server" = {
        instance_type = "t2.medium"

        subnet_name = "web-subnet-1"

        security_group_name = "public_security_group"

        tags = {
            Name = "web_server"
        }
    }
    "instance01" = {
        instance_type = "t2.medium"
        subnet_name = "app-subnet-1"
        security_group_name = "public_security_group"
        tags = {
            Name = "instance01"
        }
    }

    "instance02" = {

        instance_type = "t2.medium"

        subnet_name = "app-subnet-2"

        security_group_name = "public_security_group"

        tags = {
            Name = "instance02"
        }
    }

}





