provider "google" {
  credentials = file("secret_key.json")
  project = "diesel-monitor-285911"
  region = "europe-west1-b"
}

resource "google_compute_instance" "default" {
  name         = "teraform-jenkins"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"
  machine_type= "n1-standard-2"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  # metadata = {
  #   ssh-keys = "natli:${file("./secret_key.json")}"
  # }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  connection {
    user     = "root"
    type     = "ssh"
    agent = false
    private_key = file("/home/natli/Desktop/boot_camp/kubernetis/echo-final/secret_key.json")
    host = self.network_interface[0].access_config[0].nat_ip
    

  }

  # provisioner "file" {
  #   source      = "./Dockerfile"
  #   destination = "/tmp"
  # }

  # provisioner "file" {
  #   source      = "./entrypoint_jenkins.sh"
  #   destination = "/tmp"
  # }

  # provisioner "remote-exec" {
  #     inline = [
  #       "chmod 400 /tmp/entrypoint_jenkins.sh",
  #       "/tmp/entrypoint_jenkins.sh" 
  #     ]
  #   }


}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network =  "https://www.googleapis.com/compute/v1/projects/diesel-monitor-285911/global/networks/default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "22"]
  }

}







