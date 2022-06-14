resource "ansible_host" "salt-proxy" {
  count = 1

  // 配置机器的 hostname，一般配置为计算资源的 public_ip (或 private_ip)
  inventory_hostname  = alicloud_instance.ecsone[count.index].public_ip

  // 配置机器所属分组
  groups = ["salt-proxy"]

  // 传给 ansible 的 vars，可在 playbook 文件中引用
  vars = {
    wait_connection_timeout   = 60
    proxy_private_ip          = alicloud_instance.ecsone[count.index].private_ip
    proxy_docker_tag          = var.proxy_docker_tag
  }
}
provider "alicloud" {
        access_key = "LTAI5tELihjv9s88iz8xd5g8"
        secret_key = "amvPoLc2PTnxLqfoUU7EGT2QenAtcr"
        region = "cn-hangzhou"
}
provider_installation {
    // 配置 network mirror 规则
    network_mirror {    
        // 提供 network mirror 服务的地址
        url = "https://registry.cloudiac.org/v1/mirrors/providers/"
        // hostname 为 registry.cloudiac.org 的 provider 查询不走 mirror
        exclude = ["registry.cloudiac.org/*/*"]
    }

    direct {
        // hostname 为 registry.cloudiac.org 的 provider 可以直接下载 
        include = ["registry.cloudiac.org/*/*"]
        // 其他 hostname 下的 provider 只能走 network mirror 
        exclude = ["*/*/*"]
    }
}
