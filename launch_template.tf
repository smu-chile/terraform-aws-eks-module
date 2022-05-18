resource "aws_launch_template" "more_pods_per_node" {
  name = "bootstrap"

  user_data = filebase64("bootstrap/bootstrap.sh")

}