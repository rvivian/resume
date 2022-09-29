variable "location" { #Location of the Azure resources
  type = string
  default = "westus3"
}

variable "location_short_code" { #3-character short code for location
  type = string
  default = "wu3"
}

variable "shortcode" { #business unit short code
  type = string
  default = "rs"
}

variable "product" { #name of product or service being deployed
  type = string
  default = "resume"
}

variable "envname" { #name of the environment being deployed to
  type = string
  default = "dev"
}