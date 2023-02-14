require "awesome_print"
AwesomePrint.irb!

def m(klass)
  klass.public_instance_methods - Object.public_instance_methods
end

