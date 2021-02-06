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
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # pull needed docker images to speed things up
      "docker pull rdpanek/jmeter:vnc-5.3.0",
      "docker pull docker.elastic.co/elasticsearch/elasticsearch:6.8.13",
      "docker pull docker.elastic.co/kibana/kibana:6.8.13",
      # create docker network
      "docker network create perf",
      # create jmeter dir
      "mkdir /opt/jmeter"
    ]
  }
  provisioner "file" {
  source      = "run_docker_containers.sh"
  destination = "/opt/jmeter/run_docker_containers.sh"
}
}

output "ip" {
  value = digitalocean_droplet.docker-perf-server.ipv4_address
}
