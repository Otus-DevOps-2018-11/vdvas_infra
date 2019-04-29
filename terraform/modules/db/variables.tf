variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable zone {
  description = "zone"
  default     = "europe-west1-b"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-1554061702"
}
