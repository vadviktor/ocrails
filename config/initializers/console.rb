# frozen_string_literal: true

def setup_console
  require 'amazing_print'
  AmazingPrint.irb! if defined?(AmazingPrint)
end

setup_console if defined?(Rails::Console) # If Rails::Console is defined we know we're in a console
