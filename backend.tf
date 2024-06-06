terraform {
    backend "s3" {
        bucket         	   = "shirimaasen-tf-s3-state"
        key                = "terraform.tfstate"
        region         	   = "eu-west-1"
        encrypt        	   = true
        dynamodb_table = "shirimaasen_components_tf_lockid"
    }
}
