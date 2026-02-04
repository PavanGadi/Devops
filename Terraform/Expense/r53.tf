resource "aws_route53_record" "Expense" {
  zone_id = var.zone_id
  count = length(var.instance_names)
# below we are giving in flower brackets to make sure it is considered as varible instead of Text.
  name  = var.instance_names[count.index] == "frontend" ? var.domain_name : "${var.instance_names [count.index]}.${var.domain_name}"
# name = local.record_name
  ttl   = 1
  type  = "A"
# below condition is if instance is front end public ip will be taken, else private ip will be taken
  records = var.instance_names[count.index] == "frontend" ? [aws_instance.Expense[count.index].public_ip] : [aws_instance.Expense[count.index].private_ip]
# records = local.record_value
# if records already exists
allow_overwrite = "true"
}

# in line no 11 and 6 can be written without locals, But using locals makes this file cleaner.
# As locals can hold the expressions the entire expression is referred in locals.tf
# As those lines have count.index they will not work in locals, so we have commented those lines.
# But at the end we can use those kind of expressions in locals