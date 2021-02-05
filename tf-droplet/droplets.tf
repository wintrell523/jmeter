resource "digitalocean_droplet" "docker-perf-server" {
  image    = "docker-20-04"
  name     = "docker-perf-server"
  region   = "fra1"
  size     = "s-4vcpu-8gb"
  monitoring = true
  ssh_keys = [
      data.digitalocean_ssh_key.terraform.id
    ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }
}

output "ip" {
  value = digitalocean_droplet.docker-perf-server.ipv4_address
}
