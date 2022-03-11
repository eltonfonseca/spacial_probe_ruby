# frozen_string_literal: true

require_relative 'src/probe'

def print_info(info)
  puts "X #{info[:x]} - Y: #{info[:y]} - Face: #{info[:face]}"
end

def main
  probe = Probe.new %w[M M TL M M M M]
  print_info(probe.current_position)
  probe.execute_moviments
  print_info(probe.current_position)
  probe.reset
  print_info(probe.current_position)
end

main
