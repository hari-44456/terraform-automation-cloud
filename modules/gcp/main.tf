resource "google_compute_firewall" "firewall" {

  count = var.number_of_instances

  name    = "${var.prefix}-firewall-externalssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] 
  target_tags   = ["externalssh"]
}

resource "google_compute_firewall" "webserverrule" {
  count = var.number_of_instances
  name    = "${var.prefix}-webserver"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80","443"]
  }

  source_ranges = ["0.0.0.0/0"] 
  target_tags   = ["webserver"]
}

resource "google_compute_address" "static" {
  count = var.number_of_instances
  name = "vm-public-address"
  project = var.project
  region = var.region
  depends_on = [ google_compute_firewall.firewall[0] ]
}

resource "google_compute_instance" "dev" {
  count = var.number_of_instances
  name         = "${var.prefix}-vm"
  machine_type = "f1-micro"
  zone         = "${var.region}-a"
  tags         = ["externalssh","webserver"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.static[0].address
    }
  }

  provisioner "remote-exec" {
    connection {
      host        = google_compute_address.static[0].address
      type        = "ssh"
      user        = var.user
      timeout     = "500s"
      private_key = file(var.private_key_location)
    }

    inline = [
      "mkdir newDir",
      "rmdir newDir"
    ]
  }

   provisioner "local-exec" {
      command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook  -i '${google_compute_address.static[0].address},' --private-key ${var.private_key_location} ansible/playbook.yml"
  }

  depends_on = [ google_compute_firewall.firewall[0], google_compute_firewall.webserverrule[0] ]

  metadata = {
    ssh-keys = "${var.user}:${file(var.public_key_location)}"
  }
}