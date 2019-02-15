data "alicloud_zones" "default" {
  "available_resource_creation" = "VSwitch"
}

# ---------------
# VPC
# ---------------
resource "alicloud_vpc" "vpc" {
  name       = "my-vpc"
  cidr_block = "10.0.0.0/16"
}

# ---------------
# NAT
# ---------------

resource "alicloud_nat_gateway" "nat-1" {
  vpc_id        = "${alicloud_vpc.vpc.id}"
  specification = "Small"
  name          = "nat-1"
}

resource "alicloud_eip" "snat-ip" {
  bandwidth            = 5
  internet_charge_type = "PayByTraffic"
  instance_charge_type = "PostPaid"
}

resource "alicloud_eip_association" "snat-ip-association" {
  allocation_id = "${alicloud_eip.snat-ip.id}"
  instance_id   = "${alicloud_nat_gateway.nat-1.id}"
}

resource "alicloud_snat_entry" "zone-1a-snat" {
  snat_table_id     = "${alicloud_nat_gateway.nat-1.snat_table_ids}"
  source_vswitch_id = "${alicloud_vswitch.zone-1a.id}"
  snat_ip           = "${alicloud_eip.snat-ip.ip_address}"
}

resource "alicloud_snat_entry" "zone-1b-snat" {
  snat_table_id     = "${alicloud_nat_gateway.nat-1.snat_table_ids}"
  source_vswitch_id = "${alicloud_vswitch.zone-1b.id}"
  snat_ip           = "${alicloud_eip.snat-ip.ip_address}"
}

# ---------------
# VSwitch zone 1a
# ---------------
resource "alicloud_vswitch" "zone-1a" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${data.alicloud_zones.default.zones.0.id}"
  name              = "zone-1a"
}

resource "alicloud_route_table" "zone-1a-routes" {
  vpc_id      = "${alicloud_vpc.vpc.id}"
  name        = "zone-1a-routes"
  description = "zone-1a-routes"
}

resource "alicloud_route_table_attachment" "zone-1a-routes-attachment" {
  vswitch_id     = "${alicloud_vswitch.zone-1a.id}"
  route_table_id = "${alicloud_route_table.zone-1a-routes.id}"
}

# ---------------
# VSwitch zone 1b
# ---------------
resource "alicloud_vswitch" "zone-1b" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${data.alicloud_zones.default.zones.1.id}"
  name              = "zone-1b"
}

resource "alicloud_route_table" "zone-1b-routes" {
  vpc_id      = "${alicloud_vpc.vpc.id}"
  name        = "zone-1b-routes"
  description = "zone-1b-routes"
}

resource "alicloud_route_table_attachment" "zone-1b-routes-attachment" {
  vswitch_id     = "${alicloud_vswitch.zone-1b.id}"
  route_table_id = "${alicloud_route_table.zone-1b-routes.id}"
}
