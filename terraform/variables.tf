variable "credentials" {
  description = "My Credentials"
  default     = "../my_creds.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}

variable "project" {
  description = "Project"
  default     = "air-quality-analysis-418420"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default = "us-east4-a"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default = "US"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  #Update the below to what you want your dataset to be called
  default = "air_quality_dataset"
}

variable "gcs_bucket_name_riverside" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default = "air-quality-analysis-data-riverside"
}

variable "gcs_bucket_name_dallas" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default = "air-quality-analysis-data-dallas"
}

variable "gcs_bucket_name_nynj" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default = "air-quality-analysis-data-nynj"
}

variable "gcs_bucket_name_dc" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default = "air-quality-analysis-data-dc"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}