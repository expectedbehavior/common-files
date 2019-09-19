Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'l', 'whereami'
Pry.commands.alias_command 'v', 'ls --locals'

Pry.config.control_d_handler = proc { exit! }
Pry.config.should_trap_interrupts = true
