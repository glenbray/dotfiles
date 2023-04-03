require "awesome_print"
AwesomePrint.irb!

def m(klass)
  klass.public_instance_methods - Object.public_instance_methods
end

if defined?(Rails)
  env = Rails.env
  env_color = if env.production?
    "\e[31m#{env}\e[0m"
  else
    env
  end

  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS_APP] = {
    PROMPT_I: "#{Rails.application.class.module_parent_name} (#{env_color}) > ",
    PROMPT_N: nil,
    PROMPT_S: nil,
    PROMPT_C: nil,
    RETURN: "=> %s\n"
  }

  IRB.conf[:PROMPT_MODE] = :RAILS_APP
end
